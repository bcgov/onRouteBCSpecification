Feature: Generate revised permit number
   As staff I need to ensure a permit application revision number is generated when an amended permit is completed so that each application can be identified individually.

Rule: A revision suffix is added to a permit that has been amended
 
  Scenario Outline: Permit is amended
    Given a permit is amended 
     When  the permit amendment is finished 
     Then the <permit number> is appended with a revision suffix after a "-"
      And the suffix increments by 1 for each subsequent <revision>

     Examples:
       | revision        | permit number with suffix |
       | first revision  | P2-00408617-873-R1        |
       | second revision | P2-00408617-873-R2        |
       | third revision  | P2-00408617-873-R3        |

