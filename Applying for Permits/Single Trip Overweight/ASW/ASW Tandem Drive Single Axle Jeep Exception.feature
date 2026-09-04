@orv2-5905 https://moti-imb.atlassian.net/browse/ORV2-5905
Feature: As a user I need the system to understand that a Tandem Drive with Single Axle Jeep with the axle group spreads 2.4 m to 3.0 m or over 3.0 m to 3.7 can break bridge formula up to a permit maximum of 28,000 and 29,000kg respectively.

users = PC, SA, TRAIN, CTPO, CA, PA

@orv2-5905-1
Rule: Tandem Drive with a Single Axle Jeep with specific inter-axle spacing and axle spread ranges have unique permittable weight maximum allowances

  Preconditions:
    - Vehicle configuration is Tandem Drive tractor with Single Axle Jeep
    - Two axle units are being evaluated for combined weight capacity
    - Violation status is based on axle spread and inter-axle spacing ranges

  Scenario: Tandem Drive Single Axle Jeep with 2.40m-3.00m spread and 1.20m-3.00m spacing permits 28,000kg
    Given the axle unit spread is between 2.40m and 3.00m
      And the inter-axle spacing is between 1.20m and 3.00m
     When the system validates the combined two axle units weight limit
     Then the maximum permitted combined weight is 28,000kg

  Scenario: Tandem Drive Single Axle Jeep with 3.01m-3.70m spread and 3.01m-3.50m spacing permits 29,000kg
    Given the axle unit spread is between 3.01m and 3.70m
      And the inter-axle spacing is between 3.01m and 3.50m
     When the system validates the combined two axle units weight limit
     Then the maximum permitted combined weight is 29,000kg

@orv2-5905-2
Rule: Tandem Drive Single Axle Jeep with specific axle spread ranges override bridge formula permittable weight maximum allowances

  Preconditions:
    - Vehicle configuration is Tandem Drive tractor with Single Axle Jeep
    - Bridge formula calculation = [30 × wheelbase (cm)] + 18,000
    - These configurations exceed bridge formula limits and are permitted as policy exceptions
    - Maximum permitted weights override standard bridge formula restrictions

  Scenario: Bridge formula calculation at 2.40m spread shows 25,200kg but exception permits 28,000kg
    Given a Tandem Drive Single Axle Jeep configuration with 2.40m (240cm) wheelbase
     When the system calculates bridge formula weight limit: (30 × 240) + 18,000
     Then the standard bridge formula result is 25,200kg
      And the system recognizes this configuration qualifies for policy exception
     Then the maximum permitted combined weight overrides to 28,000kg
      And the bridge formula exception is applied

  Scenario: Bridge formula calculation at 3.00m spread shows 27,000kg but exception permits 29,000kg
    Given a Tandem Drive Single Axle Jeep configuration with 3.00m (300cm) wheelbase
     When the system calculates bridge formula weight limit: (30 × 300) + 18,000
     Then the standard bridge formula result is 27,000kg
      And the system recognizes this configuration qualifies for policy exception
     Then the maximum permitted combined weight overrides to 29,000kg
      And the bridge formula exception is applied

# Notes:


 Under British Columbia’s heavy-haul permit guidelines, the combination of a **Tandem Drive tractor and a Single-Axle Jeep** is granted a highly specific policy exception. This exception allows the unit to carry weights that exceed standard Bridge Formula calculations. 

 The specific policy frameworks, weight caps, and the physical reasoning behind how they "break" the Bridge Formula are outlined below:

 ### **1. The Core Policy References**
 The rules governing this specific combination are documented across two separate chapters of the *Commercial Transport Procedures Manual* (CTPM):

 *   **Chapter 6 (Section 6.3.2.B.iv - Permittable Overload Weights Table):** This table lists the exception explicitly:
     *   **28,000 kg** weight limit for spreads of **2.4 m to 3.0 m**.
     *   **29,000 kg** weight limit for spreads of **over 3.0 m to 3.7 m**.
 *   **Chapter 5 (Section 5.3.12.I - Jeeps, Table i):** This section lists the spacing slightly differently under the *Single plus Multi-Axle Jeep Combinations* table:
     *   **28,000 kg** weight limit for interaxle spacings of **1.2 m to 3.0 m**.
     *   **29,000 kg** weight limit for interaxle spacings of **3.01 m to 3.5 m**.

 ### **2. Spacing vs. Spread: A Terminology Discrepancy**
 There is a minor terminological discrepancy between the two chapters in the manual:
 *   **Chapter 6** terms this longitudinal dimension as an **"axle spread"**.
 *   **Chapter 5** and the **Heavy Haul Quick Reference Chart** term it as an **"interaxle spacing"**.

 In field operations, this is measured as the **interaxle spacing**—specifically, the distance between the center of the tractor's rear-most drive axle and the center of the single jeep axle. 

 ---

 ### **3. How this Policy "Breaks" the Bridge Formula**
 Under standard B.C. heavy-haul guidelines, any group of axles must comply with the standard **Bridge Formula** to protect infrastructure:
 \\[\text{Maximum Permitted Weight (kg)} = [30 \times \text{wheelbase (cm)}] + 18,000\\]

 If the Ministry did not provide this dedicated policy exception, a tandem drive and single jeep unit would be restricted as follows:

 *   **At a 2.4 m (240 cm) spacing:** 
     *   *Standard Bridge Formula:* \\((30 \times 240) + 18,000 = \mathbf{25,200\text{ \textbf{kg}}}\\).
     *   *Policy Exception Weight:* **\\(28,000\text{ \textbf{kg}}\\)**.
     *   *The Benefit:* The policy overrides the formula to grant an extra **\\(2,800\text{ \textbf{kg}}\\)** of hauling capacity.
 *   **At a 3.0 m (300 cm) spacing:** 
     *   *Standard Bridge Formula:* \\((30 \times 300) + 18,000 = \mathbf{27,000\text{ \textbf{kg}}}\\).
     *   *Policy Exception Weight:* **\\(29,000\text{ \textbf{kg}}\\)**.
     *   *The Benefit:* The policy overrides the formula to grant an extra **\\(2,000\text{ \textbf{kg}}\\)** of hauling capacity.

 ### **4. Mandatory Operating Conditions**
 To legally utilize these elevated permit weights, the vehicle combination must adhere to these structural constraints:
 *   **Equal Load Distribution:** If the tractor drive group and the jeep axle group have an equal number of axles, the two groups must be load-equalized to within **1,000 kg** of one another.
 *   **Weight Maximization:** You must maximize the tandem drive axle group weight first (up to its permit limit) before transferring or allocating weight to the jeep axle.
 *   **Exclusion of Steering Axle:** The steering axle of the tractor is strictly excluded from these group weight calculations, and no overweight allowance is permitted on the steering axle when loaded.
