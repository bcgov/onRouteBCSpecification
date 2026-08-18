@orv2-5935 https://moti-imb.atlassian.net/browse/ORV2-5935
Feature: As a user, I want to be able to select the axle type for each axle unit in the ASW table, so that I can ensure my permit application is compliant with the minimum number of wheels per axle for each axle type.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Background: This is an update to the ASW Table to change the "No. of Axles" column to a drop down with the following options: Single, Tandem, Tridem. The column header will be renamed to "Axle Type". The "No. of Wheels" column will be automatically populated based on the selected Axle Type for each axle unit based on the minimum allowances for Axle Unit 1 (steer) and Axle Unit 2 and beyond (drive and trailer(s)). User may optionally choose to view an updated info box with information about Axle Unit and Axle Group. Axle type violations will remain the same.

@orv2-5935-1
Rule: The "No. of Axles" column header in the ASW Table is named "Axle Type"

@orv2-5935-2
Rule: The "No. of Axles" column in the ASW Table is a drop down with the following options: Single, Tandem, Tridem

@orv2-5935-3
Rule: User can tab into the "Axle Type" column in the ASW Table and select an option from the drop down using the keyboard arrow keys and enter key to select the option

@orv2-5935-4
Rule: Axle Type defaults to "Single" for all axle units

  Scenario: Axle Type defaults to Single for all axle units
    Given a user has added a truck tractor power unit
     Then the Axle Type for all axle units is defaulted to "Single"

@orv2-5935-5
Rule: The "No. of Wheels" column in the ASW Table is automatically populated based on the selected Axle Type for each axle unit based on the minimum allowances for Axle Unit 1 (steer) and Axle Unit 2 and beyond (drive and trailer(s))

 # See ASW No. of Wheels per Axle feature for the specific allowances for each axle type.

  Scenario: No. of Wheels auto-populates based on Axle Type selection
    Given a user has added a truck tractor power unit
      And they change the Axle Type for an axle unit 2 to "Tandem"
     When they choose to calculate or continue to the next step #or tab?
     Then the No. of Wheels for Axle Unit 2 is automatically populated with "4"

@orv2-5935-6
Rule: User may optionally choose to view an info box with information about Axle Unit and Axle Group

 # See: UI Design for the updated info box content and diagram and tool-tip placement

  Scenario: Show an info box with information about Axle Unit and Axle Group
    Given a user has added a truck tractor power 
     When they choose to view the info box for an axle unit
     Then they see an info box with information about Axle Unit and Axle Group


# Notes
No. of Axles change to drop down instead of numbers e.g., 1 to Single
	- Column header name: Axle Type
	- Default to "Single"
	- Options for all axle units: Single, Tandem, Tridem
	- Support tabbing behaviour as tire size
	- Info-box
		- Top have of the diagram only and the? only axle unit
	- Review and confirm new design 
	- Keep violations the same
- Default No. of Wheels based on the axle type selection
	- Axle Unit 1 allowances
	- Axle unit 2 and beyond allowances
- Axle Unit info box updates 