Feature: Staff Manage Queue queue List
As staff I need to be able to see a list of permit applications submitted for review by CV Clients, so that I can assist them with completing their permit applications and approving issuance.

Staff = SA, PC, CTPO, Trainee

@orv2-2398-1
Rule: Staff can see a queue list of applications submitted for review

  Scenario: applications are in queue
    Given applications are in the queue
     When staff view the queue list
     Then they see the following information about the applications:
       | information           | description                                                                        |
       | Application #         | the onRouteBC generated application number                                         |
       | Permit Type           | the permit type acronym                                                            |
       | Plate                 | the plate number of the permit application vehicle                                 |
       | Company Name          | the company name of the CV Client that submitted the permit application            |
       | Permit Start Date     | the start date chosen int he permit application                                    |
       | Time in Queue (hh:mm) | the elapsed time since the permit application was submitted                        |
       | Claimed By            | the IDIR username of staff user that is actively processing the permit application |

  Scenario: no applications in the queue
    Given there are no applications in the queue
     When staff choose to view the queue list
     Then they see "No records found."

@orv2-2398-2
Rule: Staff can see the elapsed time the submitted application has been in the queue

  Scenario: new 5 minute elapsed
    Given application A1-72303011-028 is submitted at 13:30
     When staff view A1-72303011-028 in the queue list 5 minutes later
     Then A1-72303011-028 time in queue is 00:05

  # Scenario: new 24h elapsed
    Given application A1-72303011-028 is submitted at 13:30
     When staff choose to view the queue 5 minutes after A1-72303011-028 is submitted
     Then A1-72303011-028 time in queue is 00:05

@orv2-2398-3
Rule: The time in queue is counted until the application is approved or rejected

@orv2-2398-4
Rule: The queue list is sorted by the elapsed time in the queue oldest at the top in descending order

  Scenario: applications are in queue
    Given applications submitted in the following order:
      | A1-72303011-028 | 1st |
      | A2-00408617-873 | 2nd |
      | A8-30815429-164 | 3rd |
     When staff view the queue list
     Then they see queue the application as:
      | A1-72303011-028 | 1st |
      | A2-00408617-873 | 2nd |
      | A8-30815429-164 | 3rd |

@orv2-2398-5
Rule: Staff may update the queue list to show its current state manually

  Scenario: manual update
     When staff choose to update the queue list
     Then the queue list is updated

@orv2-2398-6
Rule: The queue list is updated every 30 seconds to reflect its current state

  Scenario: viewing the queue list
    Given the queue list has the following submitted applications:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:22                 |
      | A2-00408617-873 | 01:07                 |
      | A8-30815429-164 | 00:05                 |
      And staff are viewing the queue list 
     When the queue is updated 30 seconds later
     Then staff see the following:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:52                 |
      | A2-00408617-873 | 01:37                 |
      | A8-30815429-164 | 00:35                 |

@orv2-2398-7
Rule: Staff may claim an application to review

  Scenario: claim a non claimed
    Given A1-72303011-028 is not claimed
     When staff claim A1-72303011-028
     Then they are directed to review and confirm details
      And attestations are unavailable

  Scenario: claim a claimed
    Given A1-72303011-028 is claimed
     When staff claim A1-72303011-028
     Then they see "Claimed Application This application is already claimed by IDIR username. Would you like to claim it instead?"
      And IDIR username is the IDIR username of the staff member that is actively processing A1-72303011-028

  Scenario: cancel claim claimed
    Given staff choose to claim A1-72303011-028
      And A1-72303011-028 is claimed by staff member B
     When they choose not to claim A1-72303011-028
     Then they are directed to the queue list
      And A1-72303011-028 remains claimed by staff member B

@orv2-2398-8
Rule: Claimed applications are shown in their own list

  Scenario: some applications claimed
    Given the queue list has the following submitted applications:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:22                 |
      | A2-00408617-873 | 01:07                 |
      | A8-30815429-164 | 00:05                 |
     When the following applications are claimed:
      | A1-72303011-028 |
      | A2-00408617-873 |
     Then staff see the claimed list as follows:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:22                 |
      | A2-00408617-873 | 01:07                 |

  Scenario: all Applications claimed
    Given the queue list has the following submitted applications:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:22                 |
      | A2-00408617-873 | 01:07                 |
      | A8-30815429-164 | 00:05                 |
     When the following applications are claimed:
      | A1-72303011-028 |
      | A2-00408617-873 |
      | A8-30815429-164 |
     Then staff see the claimed list as follows:
      | Application #   | Time in Queue (hh:mm) |
      | A1-72303011-028 | 01:22                 |
      | A2-00408617-873 | 01:07                 |
      | A8-30815429-164 | 00:05                 |

@orv2-2398-9
Rule: The staff queue lists (queued and claimed) are paginated at 25 items by default






