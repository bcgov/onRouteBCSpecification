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

# Notes: