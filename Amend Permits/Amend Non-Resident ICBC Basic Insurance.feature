Feature: Amend Non-Resident ICBC Basic Insurance (Single Trip and QTRLY)

Staff = SA, PC, CTPO, Trainee

Note: Non-resident ICBC Basic Insurance (Single Trip and QTRLY) amending permit applications share rules and scenarios with new applications (e.g., mandatory fields, province/sate error) and common amend permit applications (e.g., reason for amendment, revision history).

@orv2-4211-1
Rule: staff can amend all contact information except company email
     
@orv2-4211-7
Rule: staff can amend all vehicle information except vehicle type and recall an allowable vehicle from inventory

@orv2-4211-8
Rule: staff can change the third party liability

  Scenario: increase CPV single trip
    Given single trip permit A has a CPV of $84 (general goods)
     When staff change third party liability to dangerous goods
     Then permit A NPV is $89
     And they can add the APA to the shopping cart

  Scenario: decrease CPV single trip
    Given single trip permit A has a CPV of $89 (dangerous goods)
     When staff change third party liability to general goods
     Then permit A NPV is $84
      And they can continue to refund to multiple payment methods

  Scenario: increase CPV qrtly
    Given single trip permit A has a CPV of $843 (general goods)
     When staff change third party liability to dangerous goods
     Then permit A NPV is $899
     And they can add the APA to the shopping cart

  Scenario: decrease CPV qrtly
    Given single trip permit A has a CPV of $899 (dangerous goods)
     When staff change third party liability to general goods
     Then permit A NPV is $843
      And they can continue to refund to multiple payment methods  

@orv2-4211-9
Rule: if staff amend results in the NPV being equal to the CPV ($0 amend) they can continue to refund to multiple payment methods

@orv2-4211-10
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

# See Amend Permit Date and Duration Rules Staff:
@orv2-4211-4
Rule: staff can forward start date to a maximum of 60 days from today (the date and time the amend is initiated)
@orv2-4211-5     
Rule: staff can backdate the start date within the calendar quarter for a qrtly permit
@orv2-4211-11
Rule: staff can backdate the start date to any past date for a single trip permit
@orv2-4211-2
Rule: staff can extend duration up to the maximum 30 days for a single trip permit
@orv2-4211-3
Rule: staff can reduce duration for a single trip permit up to a maximum of 30 days for a single trip permit
@orv2-4211-6
Rule: staff are notified when start date an/or expiry date are in the past