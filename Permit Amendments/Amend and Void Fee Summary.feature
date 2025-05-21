Feature: Amend and Void Fee Summary

Staff = PC, SA, TRAIN, CTPO

This feature spec describes the enhanced fee summary exclusive to amend and void workflows. staff can amend a permit but only SA can void a permit. It leverages the same information used in the refund to multiple payment methods feature (current permit value and new permit value). This feature illustrates the effect changes made to the permit will have on the credit or debit. 

@orv2-4301-1
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at amend and void fee summary

  Scenario: > CPV +km 
    Given the CPV is $100
     When staff add 200 km to total distance
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $114 |
       | Total                | $14  |

  Scenario: < CPV -km
    Given the CPV is $100
      And the total km is 1429
     When staff reduce total distance to 1200 km
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $84  |
       | Total                | -$16 |

  Scenario: = CPV $0 amend
    Given the CPV is $100
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $100 |
       | Total                | $0   |

  Scenario: < CPV void 
    Given the CPV is $100
     When SA initiate a void
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $0 |
       | Total                | -$100  |

