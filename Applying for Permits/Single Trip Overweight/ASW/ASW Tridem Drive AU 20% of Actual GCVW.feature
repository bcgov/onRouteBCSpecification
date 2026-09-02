@ORV2-5374 https://moti-imb.atlassian.net/browse/ORV2-5374
Feature: As a user, I need the system to check that the Drive Axle weight is high enough for supported power unit vehicle sub-types. The minimum required weight is whichever is lower: 20% of actual GCVW, 23000 kg for tandem, or 28000 kg for tridem.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 15 and 16: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@ORV2-5374-1
Rule: This trigger applies only when the power unit vehicle sub-type is one of the following:
  | powerUnitVehicleSubtype |
  | Truck                   |
  | Truck Tractor           |
  | Truck with PME          |
  | Truck Tractor with PME  |
  | Picker Truck Tractor    |

@ORV2-5374-2
Rule: For these vehicle sub-types, the tandem drive axle unit weight must meet the required minimum. The required minimum is the lower of 20% of actual GCVW or 23000 kg.

  Scenario Outline: Tandem drive axle unit meets threshold
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the actual GCVW is <gcvw> kg
    And the tandem drive axle unit weight is <tandemDriveAxleUnitWeight> kg
    When the user chooses to calculate or continue with the permit application
    Then they do not see a tandem drive axle unit threshold error
     And they can continue the permit application

    Examples:
      | description                                | powerUnitVehicleSubtype | gcvw   | tandemDriveAxleUnitWeight |
      | Boundary pass at 20% threshold             | Truck                   | 100000 | 20000                     |
      | Pass above 20% threshold when 20% is lower | Truck Tractor           | 100000 | 20500                     |
      | Boundary pass at 23000 cap threshold       | Truck with PME          | 130000 | 23000                     |
      | Boundary pass at capped threshold          | Truck Tractor with PME  | 150000 | 23000                     |
      | Boundary pass with picker truck tractor    | Picker Truck Tractor    | 110000 | 22000                     |

  Scenario Outline: Tandem drive axle unit is below threshold
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the actual GCVW is <gcvw> kg
    And the tandem drive axle unit weight is <tandemDriveAxleUnitWeight> kg
    When the user chooses to calculate or continue with the permit application
    Then they see "Drive Axle must be a minimum 20% of the GCVW."
     And the axle unit 2 "Axle Unit Weight (kg)" field is indicated with a red border
     And they cannot continue the permit application

    Examples:
      | description                         | powerUnitVehicleSubtype | gcvw   | tandemDriveAxleUnitWeight |
      | Fail just below 20% threshold       | Truck                   | 100000 | 19999                     |
      | Fail just below 23000 cap threshold | Truck Tractor           | 130000 | 22999                     |
      | Fail just below capped threshold    | Truck with PME          | 150000 | 22999                     |
      | Fail well below computed threshold  | Truck Tractor with PME  | 90000  | 15000                     |
      | Fail with picker truck tractor      | Picker Truck Tractor    | 110000 | 21999                     |

  Scenario Outline: Tandem drive axle unit meets or misses the 20% threshold using derived GCVW from axle unit weights
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the steer axle unit weight is <steerAxleUnitWeight> kg
    And the tandem drive axle unit weight is <tandemDriveAxleUnitWeight> kg
    And the remaining axle unit weights total <otherAxleUnitWeightsTotal> kg
    When the user chooses to calculate or continue with the permit application
    Then the calculated actual GCVW is <gcvw> kg
     And the tandem drive axle unit threshold result is <result>

    Examples:
      | description                         | powerUnitVehicleSubtype | steerAxleUnitWeight | tandemDriveAxleUnitWeight | otherAxleUnitWeightsTotal | gcvw   | result  |
      | boundary pass at 20 percent         | Truck                   | 8000                | 20000                     | 72000                     | 100000 | valid   |
      | just below 20 percent                | Truck                   | 8000                | 19999                     | 72001                     | 100000 | invalid |
      | cap branch pass at 23000            | Truck Tractor           | 9000                | 23000                     | 97000                     | 129000 | valid   |
      | cap branch just below 23000         | Truck Tractor           | 9000                | 22999                     | 97001                     | 129000 | invalid |
      | another valid distribution same GCVW | Truck with PME          | 10000               | 23000                     | 87000                     | 120000 | valid   |

  Scenario Outline: Tandem drive axle threshold using derived actual GCVW from axle unit weights
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And steer axle unit weight is <steerAxleUnitWeight> kg
    And tandem drive axle unit weight is <tandemDriveAxleUnitWeight> kg
    And all remaining axle unit weights total <otherAxleUnitsWeightTotal> kg
    And the actual GCVW is the sum of all axle unit weights
    When the user chooses to calculate or continue with the permit application
    Then the calculated actual GCVW is <gcvw> kg
     And tandem drive axle unit threshold result is <result>

    Examples:
      | description                             | powerUnitVehicleSubtype | steerAxleUnitWeight | tandemDriveAxleUnitWeight | otherAxleUnitsWeightTotal | gcvw   | result  |
      | 20 percent branch boundary pass         | Truck                   | 8000                | 20000                     | 72000                     | 100000 | valid   |
      | 20 percent branch just below boundary   | Truck Tractor           | 8001                | 19999                     | 72000                     | 100000 | invalid |
      | 23000 cap branch boundary pass          | Truck with PME          | 10000               | 23000                     | 97000                     | 130000 | valid   |
      | 23000 cap branch just below boundary    | Truck Tractor with PME  | 10001               | 22999                     | 97000                     | 130000 | invalid |

@ORV2-5374-3
Rule: For these vehicle sub-types, the tridem drive axle unit weight must meet the required minimum. The required minimum is the lower of 20% of actual GCVW or 28000 kg.

  Scenario Outline: Tridem drive axle unit meets threshold
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the actual GCVW is <gcvw> kg
    And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg
    When the user chooses to calculate or continue with the permit application
    Then they do not see a tridem drive axle unit threshold error
     And they can continue the permit application

    Examples:
      | description                                | powerUnitVehicleSubtype | gcvw   | tridemDriveAxleUnitWeight |
      | Boundary pass at 20% threshold             | Truck                   | 100000 | 20000                     |
      | Pass above 20% threshold when 20% is lower | Truck Tractor           | 100000 | 20500                     |
      | Boundary pass at 28000 cap threshold       | Truck with PME          | 150000 | 28000                     |
      | Boundary pass at capped threshold          | Truck Tractor with PME  | 160000 | 28000                     |
      | Boundary pass with picker truck tractor    | Picker Truck Tractor    | 120000 | 24000                     |

  Scenario Outline: Tridem drive axle unit is below threshold
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the actual GCVW is <gcvw> kg
    And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg
    When the user chooses to calculate or continue with the permit application
    Then they see "Drive Axle must be a minimum 20% of the GCVW."
     And the axle unit 2 "Axle Unit Weight (kg)" field is indicated with a red border
     And they cannot continue the permit application

    Examples:
      | description                         | powerUnitVehicleSubtype | gcvw   | tridemDriveAxleUnitWeight |
      | Fail just below 20% threshold       | Truck                   | 100000 | 19999                     |
      | Fail just below 28000 cap threshold | Truck Tractor           | 150000 | 27999                     |
      | Fail just below capped threshold    | Truck with PME          | 160000 | 27999                     |
      | Fail well below computed threshold  | Truck Tractor with PME  | 90000  | 15000                     |
      | Fail with picker truck tractor      | Picker Truck Tractor    | 120000 | 23999                     |

  Scenario Outline: Tridem drive axle unit meets or misses the 20% threshold using derived GCVW from axle unit weights
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And the steer axle unit weight is <steerAxleUnitWeight> kg
    And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg
    And the remaining axle unit weights total <otherAxleUnitWeightsTotal> kg
    When the user chooses to calculate or continue with the permit application
    Then the calculated actual GCVW is <gcvw> kg
     And the tridem drive axle unit threshold result is <result>

    Examples:
      | description                         | powerUnitVehicleSubtype | steerAxleUnitWeight | tridemDriveAxleUnitWeight | otherAxleUnitWeightsTotal | gcvw   | result  |
      | boundary pass at 20 percent         | Truck                   | 8000                | 20000                     | 72000                     | 100000 | valid   |
      | just below 20 percent                | Truck                   | 8000                | 19999                     | 72001                     | 100000 | invalid |
      | cap branch pass at 28000            | Truck Tractor           | 9000                | 28000                     | 97000                     | 134000 | valid   |
      | cap branch just below 28000         | Truck Tractor           | 9000                | 27999                     | 97001                     | 134000 | invalid |
      | another valid distribution same GCVW | Truck with PME          | 10000               | 28000                     | 82000                     | 120000 | valid   |

  Scenario Outline: Tridem drive axle threshold using derived actual GCVW from axle unit weights
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
    And steer axle unit weight is <steerAxleUnitWeight> kg
    And tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg
    And all remaining axle unit weights total <otherAxleUnitsWeightTotal> kg
    And the actual GCVW is the sum of all axle unit weights
    When the user chooses to calculate or continue with the permit application
    Then the calculated actual GCVW is <gcvw> kg
     And tridem drive axle unit threshold result is <result>

    Examples:
      | description                             | powerUnitVehicleSubtype | steerAxleUnitWeight | tridemDriveAxleUnitWeight | otherAxleUnitsWeightTotal | gcvw   | result  |
      | 20 percent branch boundary pass         | Truck                   | 8000                | 20000                     | 72000                     | 100000 | valid   |
      | 20 percent branch just below boundary   | Truck Tractor           | 8001                | 19999                     | 72000                     | 100000 | invalid |
      | 28000 cap branch boundary pass          | Truck with PME          | 9000                | 28000                     | 123000                    | 160000 | valid   |
      | 28000 cap branch just below boundary    | Truck Tractor with PME  | 9001                | 27999                     | 123000                    | 160000 | invalid |

# Notes: