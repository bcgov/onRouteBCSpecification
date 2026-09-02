@orv2-5506 https://moti-imb.atlassian.net/browse/ORV2-5506
Feature: As a user, I need the system to ensure the Tandem Steer Axle is a minimum of 40% of the Tandem or Tridem Drive Axle Weight, so that I can ensure the permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 23: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5506
Rule: Tandem steer legal maximum is 13,600 kg for non-PME truck tractor/truck and non-picker truck tractor vehicles

Rule: Tandem steer legal maximum is 15,200 kg for with-PME Truck Tractors with PME, Trucks with PME, and Picker Truck Tractors

Rule: Tandem steer legal maximum is 17,000 kg for non-PME truck tractor/truck and non-picker truck tractor vehicles and 17,000 kg for with-PME (Truck Tractors with PME, Trucks with PME, and Picker Truck Tractors)

Rule: Apply the 40% tandem steer ratio when operating at "Permit Weights" (> legal max < permit max) for tandem steer/tandem drive and tandem steer/tridem drive vehicles

  Scenario Outline: Tandem steer ratio passes for tandem drive at Permit Weights
    Given the vehicle has a tandem steer axle and a tandem drive axle
    And the vehicle type is <vehicleType>
    And the tandem steer legal maximum is <tandemSteerLegalMax> kg
    And the operating condition is operating at "Permit Weights"
    And the tandem drive axle weight is <tandemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description            | vehicleType | tandemSteerLegalMax | tandemDriveAxleWeight | steerAxleWeight |
      | Pass at 40% boundary   | non-PME     | 13600               | 17000                 | 6800            |
      | Pass above 40%         | with-PME    | 15200               | 17000                 | 7000            |

  Scenario Outline: Tandem steer ratio fails for tandem drive at Permit Weights
    Given the vehicle has a tandem steer axle and a tandem drive axle
    And the vehicle type is <vehicleType>
    And the tandem steer legal maximum is <tandemSteerLegalMax> kg
    And the operating condition is operating at "Permit Weights"
    And the tandem drive axle weight is <tandemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 40% of Axle Unit Y axle unit Weight."

    Examples:
      | description           | vehicleType | tandemSteerLegalMax | tandemDriveAxleWeight | steerAxleWeight |
      | Fail below 40%        | non-PME     | 13600               | 17000                 | 6799            |
      | Fail well below 40%   | with-PME    | 15200               | 17000                 | 5000            |

  Scenario Outline: Tandem steer ratio passes for tridem drive at Permit Weights
    Given the vehicle has a tandem steer axle and a tridem drive axle
    And the vehicle type is <vehicleType>
    And the tandem steer legal maximum is <tandemSteerLegalMax> kg
    And the operating condition is operating at "Permit Weights"
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description            | vehicleType | tandemSteerLegalMax | tridemDriveAxleWeight | steerAxleWeight |
      | Pass at 40% boundary   | non-PME     | 13600               | 20000                 | 8000            |
      | Pass above 40%         | with-PME    | 15200               | 20000                 | 8500            |

  Scenario Outline: Tandem steer ratio fails for tridem drive at Permit Weights
    Given the vehicle has a tandem steer axle and a tridem drive axle
    And the vehicle type is <vehicleType>
    And the tandem steer legal maximum is <tandemSteerLegalMax> kg
    And the operating condition is operating at "Permit Weights"
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 40% of Axle Unit Y axle unit Weight."

    Examples:
      | description           | vehicleType | tandemSteerLegalMax | tridemDriveAxleWeight | steerAxleWeight |
      | Fail below 40%        | non-PME     | 13600               | 20000                 | 7999            |
      | Fail well below 40%   | with-PME    | 15200               | 15000                 | 5000            |

The following pseudo-code logic is for the **40% weight distribution rule** and the four primary tandem-steer scenarios identified in **Appendix B** of the *Commercial Transport Regulations*.

### **Pseudo-Code: The 40% Rule & Legal Maximums**

```pseudo
// Logic for Tandem Steer Power Units
// References: CTR Appendix B and CTPM Chapter 5.3.2, 5.3.4, and 5.3.9

IF vehicle.steer_axle_type == "Tandem Steer" THEN

    // STEP 1: Identify the unique Steering Axle Unit Weight Maximum (Legal)
    // Limits are based strictly on rear drive configuration and PME status
    
    IF vehicle.drive_axle_type == "Tandem Drive" THEN
        // Scenarios 1 & 2: Tandem drive units (with or without PME)
        max_legal_steer = 17000
        
    ELSE IF vehicle.drive_axle_type == "Tridem Drive" THEN
        IF vehicle.has_PME == TRUE THEN
            // Scenario 4: Tridem drive with Permanently Mounted Equipment (Trucks with PME, Truck Tractors with PME, Picker Truck Tractors)
            max_legal_steer = 15200
        ELSE
            // Scenario 3: Standard tridem drive without PME
            max_legal_steer = 13600
        END IF
    END IF

    // STEP 2: Apply the 40% Weight Distribution Rule
    // Condition: Applies when "Loaded" (including towing a trailer) or at "Permit Weights"
    
    IF vehicle.is_loaded == TRUE OR vehicle.operating_weight_mode == "Permit Weights" THEN
        
        // Calculate the minimum required weight (40% of actual drive axle unit weight)
        min_required_steer = 0.40 * vehicle.actual_drive_axle_unit_weight

        IF vehicle.actual_steer_axle_unit_weight < min_required_steer THEN
            REJECT_OPERATION("Axle Unit X must be a minimum of 40% of Axle Unit Y axle unit Weight.")
        END IF

    END IF
END IF
```

### **Logic Overview**
*   **The 40% Baseline:** This remains the standard distribution requirement for all tandem-steer configurations paired with tandem or tridem drives. It ensures the steering axles carry a proportionate share of the load to maintain stability and traction.
*   **Regulatory Maximums:** The code enforces the specific legal limits from the Appendix B weight table:
    *   **17,000 kg** for tandem drive configurations.
    *   **15,200 kg** for tridem drive configurations with PME (e.g., concrete pumpers or picker trucks).
    *   **13,600 kg** for tridem drive configurations without PME (standard trucks or tractors).