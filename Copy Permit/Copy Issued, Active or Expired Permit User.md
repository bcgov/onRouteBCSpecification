# Copy Issued, Active or Expired Permit User

**Jira:** [ORV2-4978](https://moti-imb.atlassian.net/browse/ORV2-4978)  
**Users:** PC, SA, TRAIN, CTPO, CA, PA

---

## Rule: Users can copy a permit that is Active or Expired

### TC-01 — Copy is available for an Active permit

**Preconditions:** User is logged in. A permit exists with status **Active**.

| Step | Action                        | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | ----------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the Active permit | Permit details are displayed                         |                 |
| 2    | Observe the available actions | The **Copy** option is available in the actions menu |                 |

---

### TC-02 — Copy is available for an Expired permit

**Preconditions:** User is logged in. A permit exists with status **Expired**.

| Step | Action                         | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | ------------------------------ | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the Expired permit | Permit details are displayed                         |                 |
| 2    | Observe the available actions  | The **Copy** option is available in the actions menu |                 |

---

### TC-03 — Copy is not available for a TPS Synced permit

**Preconditions:** User is logged in. A permit exists with status **TPS Synced**.

| Step | Action                            | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | --------------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the TPS Synced permit | Permit details are displayed                             |                 |
| 2    | Observe the available actions     | The **Copy** option is not available in the actions menu |                 |

---

### TC-04 — Copy is not available for a Revoked permit

**Preconditions:** User is logged in. A permit exists with status **Revoked**.

| Step | Action                         | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ------------------------------ | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the Revoked permit | Permit details are displayed                             |                 |
| 2    | Observe the available actions  | The **Copy** option is not available in the actions menu |                 |

---

### TC-05 — Copy is not available for a Void permit

**Preconditions:** User is logged in. A permit exists with status **Void**.

| Step | Action                        | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ----------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the Void permit   | Permit details are displayed                             |                 |
| 2    | Observe the available actions | The **Copy** option is not available in the actions menu |                 |

---

## Rule: Users are directed to the new application after copying

### TC-06 — User is directed to a new application after copying an Active permit

**Preconditions:** User is logged in. A permit exists with status **Active**.

| Step | Action                                         | Expected Result                                              | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------- | ------------------------------------------------------------ | --------------- |
| 1    | Navigate to the Active permit                  | Permit details are displayed                                 |                 |
| 2    | Select **Copy** from the actions menu          | A new permit application is created                          |                 |
| 3    | Observe the page after copying                 | User is redirected to the new permit application             |                 |
| 4    | Review the new application's permit type       | Permit type is pre-populated from the original permit        |                 |
| 5    | Review the new application's contact details   | Contact details are pre-populated from the original permit   |                 |
| 6    | Review the new application's vehicle details   | Vehicle details are pre-populated from the original permit   |                 |
| 7    | Review the new application's commodity details | Commodity details are pre-populated from the original permit |                 |
| 8    | Review the new application number              | Application number is a new unique value                     |                 |
| 9    | Review the new application status              | Status is **In Progress**                                    |                 |

---

### TC-07 — User is directed to a new application after copying an Expired permit

**Preconditions:** User is logged in. A permit exists with status **Expired**.

| Step | Action                                         | Expected Result                                              | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------- | ------------------------------------------------------------ | --------------- |
| 1    | Navigate to the Expired permit                 | Permit details are displayed                                 |                 |
| 2    | Select **Copy** from the actions menu          | A new permit application is created                          |                 |
| 3    | Observe the page after copying                 | User is redirected to the new permit application             |                 |
| 4    | Review the new application's permit type       | Permit type is pre-populated from the original permit        |                 |
| 5    | Review the new application's contact details   | Contact details are pre-populated from the original permit   |                 |
| 6    | Review the new application's vehicle details   | Vehicle details are pre-populated from the original permit   |                 |
| 7    | Review the new application's commodity details | Commodity details are pre-populated from the original permit |                 |
| 8    | Review the new application number              | Application number is a new unique value                     |                 |
| 9    | Review the new application status              | Status is **In Progress**                                    |                 |
