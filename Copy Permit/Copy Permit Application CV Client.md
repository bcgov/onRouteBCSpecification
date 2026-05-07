# Copy Permit Application CV Client

**Jira:** [ORV2-4969](https://moti-imb.atlassian.net/browse/ORV2-4969)  
**Users:** CA, PA

---

## Rule: A CV Client cannot copy a permit application started by staff

### TC-01 — Copy is not available when permit application was started by staff

**Preconditions:** CV Client is logged in. A permit application exists that was started by staff.

| Step | Action                                              | Expected Result                                          | Pass(P)/Fail(F) |
| ---- | --------------------------------------------------- | -------------------------------------------------------- | --------------- |
| 1    | Navigate to the permit application started by staff | Permit application details are displayed                 |                 |
| 2    | Observe the available actions                       | The **Copy** option is not available in the actions menu |                 |

---

### TC-02 — Copy is available when permit application was started by a CV Client

**Preconditions:** CV Client is logged in. A permit application exists that was started by a CV Client.

| Step | Action                                                    | Expected Result                                      | Pass(P)/Fail(F) |
| ---- | --------------------------------------------------------- | ---------------------------------------------------- | --------------- |
| 1    | Navigate to the permit application started by a CV Client | Permit application details are displayed             |                 |
| 2    | Observe the available actions                             | The **Copy** option is available in the actions menu |                 |
