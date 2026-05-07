# Staff Copy Single Trip Oversize Permit Application

**Jira:** [ORV2-4728](https://moti-imb.atlassian.net/browse/ORV2-4728)  
**Users:** PC, SA, TRAIN, CTPO

---

## Rule: Contact information does not contain first name, last name, and primary phone from the copied permit application (same as staff new application behaviour)

### TC-01 — Staff contact information fields are not carried over from the original permit application

**Preconditions:** Staff is logged in. A permit application exists with first name, last name, and primary phone populated in the contact information.

| Step | Action                                                    | Expected Result                                                                          | Pass(P)/Fail(F) |
| ---- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit application                        | Permit application details are displayed                                                 |                 |
| 2    | Select **Copy** from the actions menu                     | A new permit application is created                                                      |                 |
| 3    | Observe the page after copying                            | Staff are redirected to the new permit application                                       |                 |
| 4    | Review the **First Name** field in contact information    | Field is blank or populated from staff profile, not from the original permit application |                 |
| 5    | Review the **Last Name** field in contact information     | Field is blank or populated from staff profile, not from the original permit application |                 |
| 6    | Review the **Primary Phone** field in contact information | Field is blank or populated from staff profile, not from the original permit application |                 |
