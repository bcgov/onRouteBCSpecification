@orv2- https://moti-imb.atlassian.net/browse/ORV2-5874
Feature: As a user I need the system to validate permittable axle spreads so that STOW applications comply 

Sources: 
 - onRouteBC Data Overweight Dimension Set (OWDS): https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881EFCEC-9462-46D8-A908-1E7DF42F113A%7D&file=Over%20Weight%20Dimension%20Set.xlsx&action=default&mobileredirect=true

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@
Rule: 

# Notes:
 - Spread Axle Tandem (S.7.24 CTAR) 18,200 kg for both reducible, non-reducible loads and fixed equipment provided either one of the axles does not exceed 11,000 kg #nextaction 

 - Concrete pumper trucks: Tandem Steer Axle Spread: By permit, these specialized vehicles are authorized to use a "Wide Spread" tandem steer axle group with a spread of up to 2.2 m (standard limit is 1.85 m)
  - *Oilfield Exploration bed trucks only

 - 5.3.9 Picker Trucks and Picker Truck Tractor Semi-Trailers - check the whole table and confirm in the OWDS
  - Tridem Drive Axle Spread: Can be permitted up to 3.1 m (compared to the standard legal maximum of 2.8 m).
  - Wheelbase Constraints: To unlock these wider spreads, the vehicle must meet increased minimum wheelbase requirements:
      - 2.8 m to <3.0 m spread: Requires a minimum 7.3 m wheelbase.
      - 3.0 m to 3.1 m spread: Requires a minimum 7.4 m wheelbase
 - 5.3.8.F. Service Rigs
  - Service Rigs & Rathole Augers
   - Tridem Drive Axle Spread: Just like picker trucks, these configurations can be permitted a drive axle spread up to 3.1 m.
   - Wheelbase Constraints: Spreads over 2.8 m are restricted to oil exploration vehicles and require matching wheelbases:
       - 2.8 m to <3.0 m spread: Requires a minimum 7.8 m wheelbase.
       - 3.0 m to 3.1 m spread: Requires a minimum 7.9 m wheelbase

 When operating under overweight or specialized permits in British Columbia, the standard legal axle spreads defined in Table I (Appendix A) are often modified or upgraded to accommodate heavy, non-reducible, or specialized configurations. 

 The permit-allowed axle spread rules that are distinct from Table I include:

 ### 1. Spread Tandem Axles (Weight Upgrade)
 *   The Difference: Under standard legal limits, a semi-trailer operating with a spread tandem axle (a spread of 1.85 m to 3.07 m) is treated as a single axle and restricted to a total group weight of 9,100 kg. 
 *   By Permit: Under an overload permit (for both reducible, non-reducible, and fixed equipment loads), the allowable weight is upgraded to 18,200 kg for the group (provided no single axle within the group exceeds 11,000 kg).

 ### 2. Stinger-Steered Automobile Transporters (Extended Configuration)
 *   Tandem Axle Spread: While standard tandem axle groups are legally restricted to 1.85 m in Table I, stinger-steered auto transporters operating under an extended combination permit can have an axle spread of between 1.2 m and 3.07 m.

 ### 3. Concrete Pumpers & Telescopic Conveyor Trucks
 *   Tandem Steer Axle Spread: By permit, these specialized vehicles are authorized to use a "Wide Spread" tandem steer axle group with a spread of up to 2.2 m (standard limit is 1.85 m).
 *   Tridem Drive Axle Spread: For oilfield exploration concrete pumpers, the tridem drive group spread can be permitted up to 3.1 m (standard legal drive limit is 2.8 m).

 ### 4. Picker Trucks & Picker Truck Tractors (with PME / Heavy Front Cranes)
 *   Tridem Drive Axle Spread: Can be permitted up to 3.1 m (compared to the standard legal maximum of 2.8 m). 
 *   Wheelbase Constraints: To unlock these wider spreads, the vehicle must meet increased minimum wheelbase requirements:
     *   2.8 m to <3.0 m spread: Requires a minimum 7.3 m wheelbase.
     *   3.0 m to 3.1 m spread: Requires a minimum 7.4 m wheelbase.

 ### 5. Service Rigs & Rathole Augers
 *   Tridem Drive Axle Spread: Just like picker trucks, these configurations can be permitted a drive axle spread up to 3.1 m. 
 *   Wheelbase Constraints: Spreads over 2.8 m are restricted to oil exploration vehicles and require matching wheelbases:
     *   2.8 m to <3.0 m spread: Requires a minimum 7.8 m wheelbase.
     *   3.0 m to 3.1 m spread: Requires a minimum 7.9 m wheelbase.

 ### 7. Manufactured/Modular Homes & Houseboats (Attached Axles)
 *   The 5-Axle Exception: Under permit, these structures are allowed to be transported on frames with up to five (5) axles in a single group. 
 *   The Group Spread Cap: The axles must be equally spaced, and the total group spread must remain within the conventional tridem axle spread limit of not more than 3.7 m and not less than 2.4 m. (If only two axles are used, the spread is capped at 1.85 m).

 ### 9. Wheeler & Platform Trailer Axle Groups
 *   16 Wheeler Axle Group (Tandem): Longitudinal axle spread is restricted to a minimum of 1.0 m and a maximum of 1.85 m.
 *   24 Wheeler Axle Group (Tridem): Longitudinal axle spread is permitted to be a minimum of 2.4 m and a maximum of 3.7 m.

 ### 1. Heavy-Haul Lowbeds with Auxiliary Axles (Jeeps & Boosters)
 These configurations are designed to distribute the weight of massive, non-reducible loads under single-trip permits:
 *   Flip-Up / Flip-Over Boosters: When flipped down, the booster axle must be equally spaced with the trailer axles, forming a tridem group with a maximum axle spread of 3.7 m. This temporarily converts a tandem trailer into a tridem to legally carry the heavy-haul weights allowed under a single-trip permit.
 *   Permit-Weight Jeeps (Single, Tandem, Tridem): These front dollies are permitted up to 11,000 kg (single), 23,000 kg (tandem), and 28,000 kg (tridem). Tandem and tridem jeeps must maintain a standard heavy-haul axle spread of 1.0 m to 1.85 m (tandem) or 2.4 m to 3.1 m (tridem).
 *   Permit-Weight Boosters (Single, Tandem, Tridem): Positioned at the rear of the lowbed, they are permitted up to 11,000 kg (single—requires \\(\ge 4.2\\) m spacing), 23,000 kg (tandem—spread 1.0 m to 1.85 m), and 28,000 kg (tridem—spread 2.4 m to 3.1 m; only allowed with a tridem lowbed).

 ### 2. Wheeler & Platform Trailer Axle Groups
 These heavy-duty hydraulic and dual-lane units are utilized for loads exceeding standard trailer limits (frequently over 85,000 kg GCVW):
 *   Standard 16 Wheeler (Tandem): Features two "wheeler lines" (8 tires per line) with an axle spread of 1.0 m to 1.85 m. Under a single-trip permit, it is allowed up to 31,000 kg.
 *   Standard 24 Wheeler (Tridem): Features three wheeler lines with a spread of 2.4 m to 3.7 m. Allowed up to 40,000 kg under a single-trip permit.
 *   Wide Wheelers: Single-trip permit weights are scaled based on the "Clear Gap" between the left and right tire tracks. Axle group limits range from 33,000 kg up to 47,000 kg (tandem) and 40,000 kg to 52,000 kg (tridem) as the gap increases up to and beyond 2.5 metres.
 *   Platform Trailers: Require a minimum longitudinal spacing of 1.5 m between single axle lines to qualify for a single-trip permit weight of 14,000 kg per line.

 ### 3. Expando Semi-Trailers & Steering Dollies
 These trailers adjust their physical dimensions to accommodate long, heavy objects (such as bridge girders or vessel hulls):
 *   Expando Semi-Trailers: To handle exceptionally long non-reducible loads, these trailers can extend their wheelbase so that the kingpin to the center of the last axle (KPLA) reaches up to 18.3 m.
 *   Manned and Remotely Steered Trailers: Required under single-trip permits for loads exceeding 31 m (remotely steered) or 36 m (manned steering). They allow non-reducible loads to navigate tight turns while maintaining stable weight distribution across their steering axle groups.

 ### 4. Manufactured / Modular Homes (Attached Axles)
 *   Maximum Axle Count & Spacing: To transport large structural sections on their own running gear, single-trip overweight permits allow up to five (5) attached axles.
 *   Group Spread: These axles must be equally spaced. The total group spread is restricted to the conventional tridem spread of 2.4 m to 3.7 m (or a maximum of 1.85 m if only two axles are used) to safely negotiate bridge decks.

 ### 5. The Reducible Load "Single-Trip Only" Exceptions
 While overweight permits are strictly reserved for non-reducible cargo, the Ministry allows two highly specific exceptions exclusively for single-trip permits on reducible loads:
 *   The 3,500 kg "Two-Component" Rule: If a load consists of only two large components, and removing one would leave the vehicle severely underweight, a single-trip permit may grant a small overload of up to 3,500 kg across the axles or gross weight.
 *   Unattached Machine Attachments: A single-trip permit can include up to two unattached pieces (such as secondary buckets, blades, or rippers) that belong to the primary machine being hauled on the trailer.
