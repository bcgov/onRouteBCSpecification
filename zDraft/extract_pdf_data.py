"""
extract_pdf_data.py
-------------------
Extracts the following fields from all PDF overload permit files in a folder:
  - Overload No.
  - From (route description)
  - Approved Vehicle Configuration table (Axle No., Axle Description,
    Axle Weight, Axle Spacing, No. of Tires, GVW)

Output: Excel file (overload_permits.xlsx by default)

Requirements:
    pip install pdfplumber pandas openpyxl

Usage:
    python extract_pdf_data.py <path_to_pdf_folder>
    python extract_pdf_data.py <path_to_pdf_folder> output.xlsx
"""

import re
import sys
from pathlib import Path

import pandas as pd
import pdfplumber


# ---------------------------------------------------------------------------
# Extraction helpers
# ---------------------------------------------------------------------------

def extract_overload_no(text: str) -> str | None:
    """Match 'Overload No. 24077' (no colon, space-separated)."""
    match = re.search(r'Overload\s+No\.?\s*(\w+)', text, re.IGNORECASE)
    return match.group(1) if match else None


def extract_from(text: str) -> str | None:
    """
    Extract the route description that follows the word 'From'.
    Captures until a blank line or a known section heading.

    Adjust the negative-lookahead stops below if your PDFs use different
    section headings (e.g. 'To:', 'Conditions:', 'Speed Limit:').
    """
    match = re.search(
        r'\bFrom\b\s+(.*?)(?=\n{2,}|\nConditions\b|\nApproved Vehicle\b'
        r'|\nSpeed\b|\nLoad\b|\nRoute\b|\nNote\b)',
        text,
        re.DOTALL | re.IGNORECASE,
    )
    if match:
        # Collapse any mid-value line breaks (e.g. coordinates split across lines)
        return ' '.join(match.group(1).split())
    return None


def find_vehicle_config_table(tables: list[list]) -> list[list] | None:
    """
    Return the first table whose first few rows contain 'Axle No.'
    (case-insensitive), which identifies the Approved Vehicle Configuration.
    """
    for table in tables:
        if not table:
            continue
        for row in table[:3]:
            for cell in row:
                if cell and 'axle no' in str(cell).lower():
                    return table
    return None


def _expand_merged(cells: list) -> list[str]:
    """
    Forward-fill None / blank cells to replicate merged-cell values
    (e.g. 'Tridem Drive' spanning axles 2-4 → ['Tridem Drive', 'Tridem Drive', 'Tridem Drive']).
    """
    result = []
    last = ''
    for c in cells:
        val = str(c).strip() if c is not None else ''
        if val:
            last = val
        result.append(last)
    return result


def table_to_axle_dict(table: list[list]) -> tuple[dict, str]:
    """
    Parse the vehicle config table into a per-axle dict.

    Returns:
        axles : {1: {'description': ..., 'weight': ..., 'spacing': ..., 'tires': ...}, ...}
        gvw   : GVW value string (or '')

    Merged cells (None from pdfplumber) are forward-filled for Description,
    Weight, and Tires (group values shared across axles).  Spacing is NOT
    forward-filled because each axle has its own unique spacing or is blank.
    """
    axle_numbers: list = []   # ordered, e.g. [1, 2, 3, ..., 12, 'GVW']
    axles: dict = {}
    gvw = ''

    for row in table:
        if not row or not row[0]:
            continue
        label = str(row[0]).strip()
        cells = row[1:]   # drop the label column

        if re.search(r'axle\s+no', label, re.IGNORECASE):
            # Header row — collect axle numbers; last column may be 'GVW'
            for cell in cells:
                val = str(cell).strip() if cell else ''
                if re.search(r'gvw', val, re.IGNORECASE):
                    axle_numbers.append('GVW')
                elif val.isdigit():
                    axle_numbers.append(int(val))
                else:
                    axle_numbers.append(None)   # blank filler column

        elif re.search(r'axle\s+description', label, re.IGNORECASE):
            expanded = _expand_merged(cells)
            for i, num in enumerate(axle_numbers):
                if isinstance(num, int) and i < len(expanded):
                    axles.setdefault(num, {})['description'] = expanded[i]

        elif re.search(r'axle\s+weight', label, re.IGNORECASE):
            expanded = _expand_merged(cells)
            for i, num in enumerate(axle_numbers):
                if num == 'GVW' and i < len(expanded):
                    gvw = expanded[i]
                elif isinstance(num, int) and i < len(expanded):
                    axles.setdefault(num, {})['weight'] = expanded[i]

        elif re.search(r'axle\s+spacing', label, re.IGNORECASE):
            # Each axle has its own spacing (or blank) — do NOT forward-fill
            for i, num in enumerate(axle_numbers):
                if isinstance(num, int) and i < len(cells):
                    val = str(cells[i]).strip() if cells[i] else ''
                    axles.setdefault(num, {})['spacing'] = val

        elif re.search(r'no\.?\s+of\s+tires|tires', label, re.IGNORECASE):
            expanded = _expand_merged(cells)
            for i, num in enumerate(axle_numbers):
                if isinstance(num, int) and i < len(expanded):
                    axles.setdefault(num, {})['tires'] = expanded[i]

    return axles, gvw


# ---------------------------------------------------------------------------
# Main processing
# ---------------------------------------------------------------------------

def process_pdfs(folder_path: str, output_file: str) -> None:
    folder = Path(folder_path)
    pdf_files = sorted(folder.glob('*.pdf'))

    if not pdf_files:
        print(f"No PDF files found in: {folder_path}")
        return

    rows = []

    for pdf_path in pdf_files:
        print(f"Processing: {pdf_path.name}")
        row: dict = {'Filename': pdf_path.name}

        try:
            full_text = ''
            all_tables: list[list] = []

            with pdfplumber.open(pdf_path) as pdf:
                for page in pdf.pages:
                    page_text = page.extract_text()
                    if page_text:
                        full_text += page_text + '\n'
                    page_tables = page.extract_tables()
                    if page_tables:
                        all_tables.extend(page_tables)

            # ---- Overload No. ----
            row['Overload No.'] = extract_overload_no(full_text) or 'NOT FOUND'

            # ---- From ----
            row['From'] = extract_from(full_text) or 'NOT FOUND'

            # ---- Approved Vehicle Configuration ----
            vehicle_table = find_vehicle_config_table(all_tables)
            if vehicle_table:
                axles, gvw = table_to_axle_dict(vehicle_table)
                row['_axles'] = axles
                row['GVW (kg)'] = gvw
            else:
                print(f"  WARNING: Vehicle config table not found in {pdf_path.name}")
                row['_axles'] = {}
                row['GVW (kg)'] = 'TABLE NOT FOUND'

        except Exception as exc:
            print(f"  ERROR processing {pdf_path.name}: {exc}")
            row['Overload No.'] = 'ERROR'
            row['From'] = 'ERROR'
            row['_axles'] = {}
            row['GVW (kg)'] = str(exc)

        rows.append(row)

    # ---- Determine full axle range across all PDFs ----
    all_axle_nums = sorted(
        {n for r in rows for n in r.get('_axles', {}).keys()}
    )

    # ---- Flatten per-axle data into top-level columns ----
    for row in rows:
        axles = row.pop('_axles', {})
        for n in all_axle_nums:
            a = axles.get(n, {})
            row[f'Axle {n} - Description']  = a.get('description', '')
            row[f'Axle {n} - Weight (kg)']  = a.get('weight', '')
            row[f'Axle {n} - Spacing (m)']  = a.get('spacing', '')
            row[f'Axle {n} - No. of Tires'] = a.get('tires', '')

    # ---- Write Excel ----
    axle_columns = [
        col
        for n in all_axle_nums
        for col in (
            f'Axle {n} - Description',
            f'Axle {n} - Weight (kg)',
            f'Axle {n} - Spacing (m)',
            f'Axle {n} - No. of Tires',
        )
    ]
    column_order = ['Filename', 'Overload No.', 'From'] + axle_columns + ['GVW (kg)']
    df = pd.DataFrame(rows, columns=column_order)
    df.to_excel(output_file, index=False, engine='openpyxl')

    print(f'\nDone! {len(rows)} file(s) processed.')
    print(f'Results saved to: {output_file}')


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    pdf_folder = sys.argv[1]
    output = sys.argv[2] if len(sys.argv) > 2 else 'overload_permits.xlsx'
    process_pdfs(pdf_folder, output)
