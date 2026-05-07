# ORV2-4903 Credit Account History Test Cases

**Jira:** [ORV2-4903](https://moti-imb.atlassian.net/browse/ORV2-4903)  
**Users:** FIN

---

## Rule: Added and removed users synced from TPS/GARMS update account history with a unique history record for each user

### TC-01 - Add user from TPS/GARMS with claimed client number

**Preconditions:** FIN user is logged in. Credit account A exists and has no users in onRouteBC. User 1 exists in TPS/GARMS with onRouteBC client number 123.

| Step | Action                                                                 | Expected Result                                                                                                                        | FIN (P/F) |
| ---- | ---------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Add user 1 to TPS/GARMS credit account A and trigger sync to onRouteBC | User 1 is added to onRouteBC credit account A                                                                                          |           |
| 2    | Open account history for credit account A                              | New record exists with IDIR = no data, Date = migration timestamp, Reason = "onRouteBC Client No.: 123", Action = "Account User Added" |           |

---

### TC-02 - Remove user from TPS/GARMS with claimed client number

**Preconditions:** FIN user is logged in. Credit account A exists and has user 1 in onRouteBC. User 1 has onRouteBC client number 123.

| Step | Action                                                                      | Expected Result                                                                                                                          | FIN (P/F) |
| ---- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Remove user 1 from TPS/GARMS credit account A and trigger sync to onRouteBC | User 1 is removed from onRouteBC credit account A                                                                                        |           |
| 2    | Open account history for credit account A                                   | New record exists with IDIR = no data, Date = migration timestamp, Reason = "onRouteBC Client No.: 123", Action = "Account User Removed" |           |

---

### TC-03 - Add user from TPS/GARMS when user has not claimed client number

**Preconditions:** FIN user is logged in. Credit account A exists and has no users in onRouteBC. User 1 exists in TPS/GARMS and has not claimed onRouteBC client number.

| Step | Action                                                                 | Expected Result                                                                                                                                | FIN (P/F) |
| ---- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Add user 1 to TPS/GARMS credit account A and trigger sync to onRouteBC | User 1 is added to onRouteBC credit account A                                                                                                  |           |
| 2    | Open account history for credit account A                              | New record exists with IDIR = no data, Date = migration timestamp, Reason = "onRouteBC Client No.: Not Claimed", Action = "Account User Added" |           |

---

### TC-04 - Add user from TPS/GARMS when holder has not claimed client number

**Preconditions:** FIN user is logged in. Credit account A exists and has no users in onRouteBC. Credit account holder has not claimed onRouteBC client number.

| Step | Action                                                                 | Expected Result                                                                                                                                | FIN (P/F) |
| ---- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Add user 1 to TPS/GARMS credit account A and trigger sync to onRouteBC | User 1 is added to onRouteBC credit account A                                                                                                  |           |
| 2    | Open account history for credit account A                              | New record exists with IDIR = no data, Date = migration timestamp, Reason = "onRouteBC Client No.: Not Claimed", Action = "Account User Added" |           |

---

## Rule: Adding or removing a user in onRouteBC updates account history with a unique history record for the user

### TC-05 - Add user directly in onRouteBC

**Preconditions:** FIN user is logged in with IDIR user1. Credit account A exists and has no users in onRouteBC. User 1 has onRouteBC client number 123.

| Step | Action                                      | Expected Result                                                                                                                      | FIN (P/F) |
| ---- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| 1    | Add user 1 to credit account A in onRouteBC | User 1 is added to onRouteBC credit account A                                                                                        |           |
| 2    | Open account history for credit account A   | New record exists with IDIR = user1, Date = migration timestamp, Reason = "onRouteBC Client No.: 123", Action = "Account User Added" |           |

---

### TC-06 - Remove user directly in onRouteBC

**Preconditions:** FIN user is logged in with IDIR user1. Credit account A exists and has user 1 in onRouteBC. User 1 has onRouteBC client number 123.

| Step | Action                                           | Expected Result                                                                                                                        | FIN (P/F) |
| ---- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Remove user 1 from credit account A in onRouteBC | User 1 is removed from onRouteBC credit account A                                                                                      |           |
| 2    | Open account history for credit account A        | New record exists with IDIR = user1, Date = migration timestamp, Reason = "onRouteBC Client No.: 123", Action = "Account User Removed" |           |

---

## Rule: Removing multiple users at one time creates a unique account history record for each removed user with the same date/time

### TC-07 - Bulk remove users creates one record per user

**Preconditions:** FIN user is logged in as IDIR user1. Credit account A has 3 users in onRouteBC with unique client numbers 123, 456, and 789. System date/time is set to 2026-01-01 10:00:00.

| Step | Action                                                            | Expected Result                                                                                                                                                                                         | FIN (P/F) |
| ---- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1    | Remove all users from credit account A in onRouteBC in one action | All 3 users are removed from onRouteBC credit account A                                                                                                                                                 |           |
| 2    | Open account history for credit account A                         | Three new records exist with Date = 2026-01-01 10:00:00 and Action = "Account User Removed", with unique Reasons: "onRouteBC Client No.: 123", "onRouteBC Client No.: 456", "onRouteBC Client No.: 789" |           |

---

## Rule: A warning message is shown when attempting to add a suspended user

### TC-08 - Suspended user cannot be added

**Preconditions:** FIN user is logged in. User 1 exists and is suspended in onRouteBC. Credit account A is available for user management.

| Step | Action                                                           | Expected Result                                                                                     | FIN (P/F) |
| ---- | ---------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------- |
| 1    | Attempt to add suspended user 1 to credit account A in onRouteBC | Warning appears: "Client is suspended A suspended client cannot be added as a Credit Account User." |           |
| 2    | Check account user list after warning                            | User 1 is not added to the credit account                                                           |           |
