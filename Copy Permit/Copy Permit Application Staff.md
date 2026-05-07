# Copy Permit Application Staff

**Jira:** [ORV2-4978](https://moti-imb.atlassian.net/browse/ORV2-4978)  
**Users:** PC, SA, TRAIN, CTPO

---

## Rule: Staff act as company upon copying a permit from global search results

### TC-01 — Staff are acting as the company associated with the copied permit

**Preconditions:** Staff is logged in and not acting as a company. A permit exists issued to Company A.

| Step | Action                                 | Expected Result                     | Pass(P)/Fail(F) |
| ---- | -------------------------------------- | ----------------------------------- | --------------- |
| 1    | Search for the permit in global search | Permit is found in results          |                 |
| 2    | Select **Copy** from the actions menu  | A new permit application is created |                 |
| 3    | Review the active company context      | Staff are now acting as Company A   |                 |

---

## Rule: Staff are directed to the copied permit application when copying from global search results

### TC-02 — Staff are redirected to the new copied permit application

**Preconditions:** Staff is logged in. A permit exists issued to Company A.

| Step | Action                                 | Expected Result                                           | Pass(P)/Fail(F) |
| ---- | -------------------------------------- | --------------------------------------------------------- | --------------- |
| 1    | Search for the permit in global search | Permit is found in results                                |                 |
| 2    | Select **Copy** from the actions menu  | A new permit application is created                       |                 |
| 3    | Observe the page after copying         | Staff are redirected to the new copied permit application |                 |

---

## Rule: Staff can copy an Active or Expired permit from global search when not acting as a company

### TC-03 — Copy is available for an Active permit

**Preconditions:** Staff is logged in and not acting as a company. A permit exists with status **Active**.

| Step | Action                        | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | ----------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the Active permit | Permit details are displayed                         |                 |
| 2    | Observe the available actions | The **Copy** option is available in the actions menu |                 |

---

### TC-04 — Copy is available for an Expired permit

**Preconditions:** Staff is logged in and not acting as a company. A permit exists with status **Expired**.

| Step | Action                         | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | ------------------------------ | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the Expired permit | Permit details are displayed                         |                 |
| 2    | Observe the available actions  | The **Copy** option is available in the actions menu |                 |

---

### TC-05 — Copy is not available for ineligible permit statuses

**Preconditions:** Staff is logged in and not acting as a company.

| Step | Action                                          | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ----------------------------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Navigate to a permit with status **TPS Synced** | Permit details are displayed                             |                 |
| 2    | Observe the available actions                   | The **Copy** option is not available in the actions menu |                 |
| 3    | Navigate to a permit with status **Revoked**    | Permit details are displayed                             |                 |
| 4    | Observe the available actions                   | The **Copy** option is not available in the actions menu |                 |
| 5    | Navigate to a permit with status **Void**       | Permit details are displayed                             |                 |
| 6    | Observe the available actions                   | The **Copy** option is not available in the actions menu |                 |

---

## Rule: Staff can copy any permit application but not rejected ones

### TC-06 — Staff can copy a permit application started by staff

**Preconditions:** Staff is logged in. A permit application exists that was started by staff and is not rejected.

| Step | Action                                              | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | --------------------------------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the permit application started by staff | Permit application details are displayed             |                 |
| 2    | Observe the available actions                       | The **Copy** option is available in the actions menu |                 |

---

### TC-07 — Staff can copy a permit application started by a CV Client

**Preconditions:** Staff is logged in. A permit application exists that was started by a CV Client and is not rejected.

| Step | Action                                                    | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | --------------------------------------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the permit application started by a CV Client | Permit application details are displayed             |                 |
| 2    | Observe the available actions                             | The **Copy** option is available in the actions menu |                 |

---

### TC-08 — Staff cannot copy a rejected permit application

**Preconditions:** Staff is logged in. A permit application exists with status **Rejected**.

| Step | Action                                           | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ------------------------------------------------ | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the rejected permit application      | Permit application details are displayed                 |                 |
| 2    | Observe the available actions                    | The **Copy** option is not available in the actions menu |                 |
