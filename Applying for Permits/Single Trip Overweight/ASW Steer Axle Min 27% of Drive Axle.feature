@ORV2-5366 https://moti-imb.atlassian.net/browse/ORV2-5366
Feature: As a user, I need the system to ensure a single steer axle is a minimum of 27% of the tridem drive axle weight, so that I can ensure the permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 14: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@ORV2-5366
Rule: a single steer axle must be a minimum of 27% of tridem drive axle weight

    Scenario Outline: Single steer axle weight meets the minimum 27% requirement
    Given the vehicle has a single steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Boundary pass at exactly 27% | 20000                 | 5400            |
      | Pass above 27% threshold     | 20000                 | 6000            |
      | Boundary pass at exactly 27% | 18000                 | 4860            |

    Scenario Outline: Single steer axle weight is below the minimum 27% requirement
    Given the vehicle has a single steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 27% of Axle Unit Y axle unit Weight."

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Fail just below 27% boundary | 20000                 | 5399            |
      | Fail just below 27% boundary | 18000                 | 4859            |
      | Fail well below 27%          | 15000                 | 4000            |

# Notes:
The **27% rule** is a fundamental weight distribution requirement for **single steer and tridem drive** vehicle configurations. The 27% rule ensures that a single steering axle maintains enough weight for safe control when paired with a heavy tridem drive unit.

### **Pseudo-Code Logic: 27% Rule, step 1 is relevant to this feature. Includes other checks for illustrative purposes**

```pseudo
// Logic for Single Steer / Tridem Drive Vehicles
// References: CTR Appendix B, Chapter 5.3.11, and Chapter 6.3.2

IF vehicle.axle_configuration == "Single Steer / Tridem Drive" THEN

    // STEP 1: Basic Weight Distribution (Fundamental Requirement)
    // The steering axle must carry at least 27% of the tridem drive axle weight at all times.
    min_steer_ratio = 0.27
    required_steer_weight = min_steer_ratio * vehicle.tridem_drive_axle_unit_weight

    IF vehicle.steer_axle_weight < required_steer_weight THEN
        REJECT_OPERATION("Axle Unit X must be a minimum of 27% of Axle Unit Y axle unit Weight.")
    END IF

    // STEP 2: Overweight Permit Validation (Bridge Formula)
    // Trigger: Drive axle weights exceeding 25,500 kg (up to 28,000 kg)
    IF vehicle.operating_weight_mode == "Permit Weights" AND vehicle.tridem_drive_axle_unit_weight > 25500 THEN
        
        // 1. Re-verify 27% ratio for permit weights
        IF vehicle.steer_axle_weight < required_steer_weight THEN
            REJECT_PERMIT("Axle Unit X must be a minimum of 27% of Axle Unit Y axle unit Weight.")
        END IF

        // 2. Steering Tire Capacity Check
        // Tire loading must not exceed 100 kg per 1.0 cm of tire width.
        // Example: To carry 7,560 kg (27% of 28,000 kg), a minimum 381mm (15") tire is required.
        max_tire_capacity = vehicle.steer_tire_width_cm * 100 * vehicle.number_of_steer_tires
        
        IF vehicle.steer_axle_weight > max_tire_capacity THEN
            REJECT_PERMIT("Steering tire width insufficient for requested weight (Max 100kg/cm).")
        END IF

    END IF

    // STEP 3: Integrated Dimension Check (Appendix B Compliance)
    IF vehicle.is_standard_appendix_b THEN
        IF vehicle.tridem_drive_axle_spread < 2.4 OR vehicle.tridem_drive_axle_spread > 2.8 THEN
            REJECT_OPERATION("Tridem drive axle spread must be between 2.4m and 2.8m.")
        END IF
    END IF

END IF
```

### **Summary of Logic Components**
*   **The Configuration Trigger:** The logic isolates vehicles with a **single steering axle** and a **tridem drive unit** (three engine-driven axles).
*   **The Ratio Requirement:** It enforces a steering-to-drive ratio of **0.27:1**. This means if the tridem drive unit is at its legal maximum of 24,000 kg, the steer axle must carry at least 6,480 kg.
*   **The Permit Overload Trigger:** The rule becomes a critical checkpoint for overweight permits when the drive group exceeds **25,500 kg**. At these weights, the steering axle must support a proportionate increase to ensure steering stability.
*   **The Tire Width Check:** Because the 27% rule often pushes steering axle weights toward 8,000 kg or 9,000 kg, the logic includes a check for **tire width** (standard 100 kg/cm rule) to ensure the rubber can legally support the weight required by the ratio.