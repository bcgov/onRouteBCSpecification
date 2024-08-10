Feature: CV Client apply for single trip oversize (STOS) permit 

CV Client = CA, PA

@orv2-2254-40
Rule: The start date must not exceed 14 days from the application submission date


@orv2-2254-41
Rule: CV Client can only submit an STOS application for review

  Scenario: submit complete application
    Given a cv client has completed a permit application
     When they submit the application for review 
     Then it is an application in review
      And they are directed to "Applications in Review"

