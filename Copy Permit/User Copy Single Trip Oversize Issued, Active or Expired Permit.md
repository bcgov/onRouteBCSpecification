# User Copy Single Trip Oversize Issued, Active or Expired Permit

**Jira:** [ORV2-4715](https://moti-imb.atlassian.net/browse/ORV2-4715)  
**Users:** PC, SA, TRAIN, CTPO, CA, PA

---

## Rule: There is no association between the copied permit and the original permit

### TC-01 — Copied permit has no link to the original permit

**Preconditions:** User is logged in. An Active or Expired permit exists.

| Step | Action                                                           | Expected Result                                               | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ------------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created                           |                 |
| 2    | Review the new permit application                                | No reference or link to the original permit number is present |                 |

---

## Rule: Client information is from the CV Client profile

### TC-02 — Client information in copied permit reflects profile changes made before copying

**Preconditions:** User is logged in. A permit exists. The user has access to update their CV Client profile.

| Step | Action                                                                                                                                    | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the CV Client profile and note the current **Doing Business As Name**, **Client Mailing Address**, **Province**, and **City** | Profile values recorded                              |                 |
| 2    | Update **Doing Business As Name** to a new value                                                                                          | Profile is saved with the new value                  |                 |
| 3    | Update **Client Mailing Address** to a new value                                                                                          | Profile is saved with the new value                  |                 |
| 4    | Navigate to the original permit and select **Copy** from the actions menu                                                                 | A new permit application is created                  |                 |
| 5    | Review **Doing Business As Name** on the new application                                                                                  | Reflects the updated profile value entered in step 2 |                 |
| 6    | Review **Client Mailing Address** on the new application                                                                                  | Reflects the updated profile value entered in step 3 |                 |

---

### TC-02b — Client information is pre-populated from the current CV Client profile (unchanged)

**Preconditions:** User is logged in. A permit exists with client information matching the current profile.

| Step | Action                                                           | Expected Result                     | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created |                 |
| 2    | Review **Doing Business As Name**                                | Matches the current profile value   |                 |
| 3    | Review **Client Mailing Address**                                | Matches the current profile value   |                 |
| 4    | Review **Country**                                               | Matches the current profile value   |                 |
| 5    | Review **Province**                                              | Matches the current profile value   |                 |
| 6    | Review **City**                                                  | Matches the current profile value   |                 |

---

### TC-03 — Client information reflects updated CV Client profile (changed since original permit)

**Preconditions:** User is logged in. A permit exists. The client profile has been updated since the original permit was issued.

| Step | Action                                                           | Expected Result                                                   | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created                               |                 |
| 2    | Review **Doing Business As Name**                                | Reflects the updated profile value, not the original permit value |                 |
| 3    | Review **Client Mailing Address**                                | Reflects the updated profile value, not the original permit value |                 |
| 4    | Review **Province**                                              | Reflects the updated profile value, not the original permit value |                 |
| 5    | Review **City**                                                  | Reflects the updated profile value, not the original permit value |                 |

---

## Rule: Contact information is from the CV Client profile for CV Clients only

### TC-04 — CV Client contact information is pre-populated from the current profile (unchanged)

**Preconditions:** CV Client (CA or PA) is logged in. A permit exists with contact information matching the current profile.

| Step | Action                                                           | Expected Result                             | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created         |                 |
| 2    | Review **First Name**                                            | Matches the current CV Client profile value |                 |
| 3    | Review **Last Name**                                             | Matches the current CV Client profile value |                 |
| 4    | Review **Primary Phone**                                         | Matches the current CV Client profile value |                 |
| 5    | Review **Client Email**                                          | Matches the current CV Client profile value |                 |

---

### TC-05 — CV Client contact information reflects updated profile (changed since original permit)

**Preconditions:** CV Client is logged in. A permit exists. The contact information in the profile has been updated since the original permit was issued.

| Step | Action                                                           | Expected Result                                                   | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created                               |                 |
| 2    | Review **First Name**                                            | Reflects the updated profile value, not the original permit value |                 |
| 3    | Review **Last Name**                                             | Reflects the updated profile value, not the original permit value |                 |
| 4    | Review **Primary Phone**                                         | Reflects the updated profile value, not the original permit value |                 |

---

## Rule: Start date of the copied permit is the current date

### TC-06 — Start date defaults to the current date

**Preconditions:** User is logged in. An Active or Expired permit exists.

| Step | Action                                                           | Expected Result                                                         | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created                                     |                 |
| 2    | Review the **Start Date** field                                  | Start date is set to today's date, not the original permit's start date |                 |

---

## Rule: Replicate permit duration from original permit to copied permit

### TC-07 — Duration is copied from the original permit

**Preconditions:** User is logged in. A permit exists with a specific duration.

| Step | Action                                   | Expected Result                      | Pass(P)/Fail(F) |
| ---- | ---------------------------------------- | ------------------------------------ | --------------- |
| 1    | Note the duration of the original permit | Duration recorded                    |                 |
| 2    | Select **Copy** from the actions menu    | A new permit application is created  |                 |
| 3    | Review the **Duration** field            | Duration matches the original permit |                 |

---

## Rule: Permit expiry date is calculated based on current date and duration of the copied permit

### TC-08 — Expiry date is calculated from today's date plus the copied duration

**Preconditions:** User is logged in. A permit exists with a known duration.

| Step | Action                                   | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ---------------------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Note the duration of the original permit | Duration recorded                                        |                 |
| 2    | Select **Copy** from the actions menu    | A new permit application is created                      |                 |
| 3    | Review the **Expiry Date** field         | Expiry date equals today's date plus the copied duration |                 |

---

## Rule: Replicate CVSE forms from original permit to copied permit

### TC-09 — CVSE form is copied when it still exists

**Preconditions:** User is logged in. A permit exists with CVSE Form 1, which still exists in the system.

| Step | Action                                                           | Expected Result                     | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created |                 |
| 2    | Review the CVSE forms on the new application                     | CVSE Form 1 is present              |                 |

---

### TC-10 — CVSE form is not copied when it no longer exists

**Preconditions:** User is logged in. A permit exists with CVSE Form 1, which has been removed from the system.

| Step | Action                                                           | Expected Result                     | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created |                 |
| 2    | Review the CVSE forms on the new application                     | CVSE Form 1 is not present          |                 |

---

### TC-11 — New default CVSE form is added to the copied permit

**Preconditions:** User is logged in. A permit exists without CVSE Form 2. CVSE Form 2 has since been added as a new default form.

| Step | Action                                                           | Expected Result                                | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ---------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created            |                 |
| 2    | Review the CVSE forms on the new application                     | CVSE Form 2 is present and selected by default |                 |
| 3    | Attempt to deselect CVSE Form 2                                  | CVSE Form 2 cannot be deselected               |                 |

---

### TC-12 — New non-default CVSE form is available but not pre-selected on the copied permit

**Preconditions:** User is logged in. A permit exists without CVSE Form 3. CVSE Form 3 has since been added as a non-default form.

| Step | Action                                                           | Expected Result                               | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | --------------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created           |                 |
| 2    | Review the CVSE forms on the new application                     | CVSE Form 3 is available but not pre-selected |                 |
| 3    | Select CVSE Form 3                                               | CVSE Form 3 can be selected                   |                 |

---

## Rule: Replicate commodity type from original permit to copied permit

### TC-13 — Commodity type is copied when it still exists

**Preconditions:** User is logged in. A permit exists with Commodity Type 1, which still exists in the system.

| Step | Action                                                           | Expected Result                     | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created |                 |
| 2    | Review the **Commodity Type** field                              | Commodity Type 1 is pre-selected    |                 |

---

### TC-14 — Commodity type and related fields are blank when commodity type no longer exists

**Preconditions:** User is logged in. A permit exists with Commodity Type 1, which has been removed from the system.

| Step | Action                                                           | Expected Result                         | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | --------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created     |                 |
| 2    | Review the **Commodity Type** field                              | Commodity Type 1 is not present         |                 |
| 3    | Review vehicle information                                       | No vehicle information is pre-populated |                 |
| 4    | Review loaded dimensions                                         | No loaded dimensions are pre-populated  |                 |

---

### TC-15 — Commodity type is copied under its new name when renamed

**Preconditions:** User is logged in. A permit exists with Commodity Type 1, which has since been renamed to Commodity Type X.

| Step | Action                                                           | Expected Result                     | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | ----------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created |                 |
| 2    | Review the **Commodity Type** field                              | Commodity Type X is pre-selected    |                 |

---

### TC-16 — New commodity type is available to select on the copied permit

**Preconditions:** User is logged in. A new Commodity Type 2 has been added to the system since the original permit was created.

| Step | Action                                                           | Expected Result                         | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------------------------- | --------------------------------------- | --------------- |
| 1    | Navigate to the permit and select **Copy** from the actions menu | A new permit application is created     |                 |
| 2    | Open the **Commodity Type** dropdown                             | Commodity Type 2 is available to select |                 |
