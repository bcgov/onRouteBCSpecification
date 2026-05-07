# Copy Permit Application User

**Jira:** [ORV2-4969](https://moti-imb.atlassian.net/browse/ORV2-4969)  
**Users:** PC, SA, TRAIN, CTPO, CA, PA

---

## Rule: A user cannot copy a rejected permit application

### TC-01 — Copy is not available for a rejected permit application

**Preconditions:** User is logged in. A permit application exists with status **Rejected**.

| Step | Action                                      | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | ------------------------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the rejected permit application | Permit application details are displayed                 |                 |
| 2    | Observe the available actions               | The **Copy** option is not available in the actions menu |                 |

---

## Rule: Users are directed to the new application after copying

### TC-02 — User is directed to a new application pre-populated with copied permit application data

**Preconditions:** User is logged in. A permit application exists that is eligible for copying.

| Step | Action                                         | Expected Result                                                          | Pass(P)/Fail(F) |
| ---- | ---------------------------------------------- | ------------------------------------------------------------------------ | --------------- |
| 1    | Navigate to the eligible permit application    | Permit application details are displayed                                 |                 |
| 2    | Select **Copy** from the actions menu          | A new permit application is created                                      |                 |
| 3    | Observe the page after copying                 | User is redirected to the new permit application                         |                 |
| 4    | Review the new application's permit type       | Permit type is pre-populated from the original permit application        |                 |
| 5    | Review the new application's contact details   | Contact details are pre-populated from the original permit application   |                 |
| 6    | Review the new application's vehicle details   | Vehicle details are pre-populated from the original permit application   |                 |
| 7    | Review the new application's commodity details | Commodity details are pre-populated from the original permit application |                 |
| 8    | Review the new application number              | Application number is a new unique value                                 |                 |
| 9    | Review the new application status              | Status is **In Progress**                                                |                 |
