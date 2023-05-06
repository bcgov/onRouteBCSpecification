## Next Actions/Notes
- Research mobile testing emulators
- Are there desktop emulators we could use and do they support versions?
- Ask Peter re OSX versioning - A. OSX devices are unmanaged
- Discuss with Dev team re the possibility of story completion to BVT within a sprint
- Bryan Lane will engage IMB for testing practice in the new process
	- cadence, when do you test?, continuous testing?

## Intro


## QA Environments
Test: https://onroutebc-test-frontend.apps.silver.devops.gov.bc.ca/

UAT: https://onroutebc-uat-frontend.apps.silver.devops.gov.bc.ca/

### Automation Tools
- 
### Operating Systems
#### Desktop
- Windows 10 Enterprise
- OSX Monterey, Ventura
#### Mobile
- Android
- IOS
- IpadOS
### Web Browsers (latest version, including security updates)
- Chrome
- Safari
- Edge
- Firefox

## Process

### Sizes
#### Small (Unit)
Testing smallest pieces of software to ensure they behave as expected

#### Medium (Component)
Testing multiple portions of software 

#### Large (End_to_end)
Verify the whole system meets business goals
- Persona journeys

### Types

#### UX/UI Testing
Assessing developed front end UX/UI against HiFi Design (Prototype)
Verify:
- Meets Government UI standards
- Tab stops?
- UI elements (e.g. drop down behaviour, hover behaviour)
- Static messages

#### Functional
Comparing software functions and features with desired system behaviour state changes Gherkin scenarios (onRouteBC Specification)
Verify:
- Positive and negative scenarios
- Cross-browser and operating system

##### BVT
Using onRouteBC Specifications as test cases and includes the review of underlying transactions (e.g., database writes) as well as the assessment of the correct application of business process, policy and regulation.
- Completed by technical and SME staff
- Bugs are tracked in JIRA and processed during backlog refinement activities
- Black box and white box

##### UAT
Can use onRouteBC Specifications as test cases or not. End users test a release candidate or production to ensure it meets usability needs.
- Completed by end users (e.g. CV Clients, PPC Staff) 
- Triaged with product team (UX Design, PO, BA)
- Usability testing (User research)
- Operational acceptance (can you complete a business process task)
- Feedback tracked in JIRA as story stubs and processed during backlog refinement activities
- Black box
- Beta testing?

##### Integration (Medium)
Verify communication and interaction between components to find interface defects


##### Smoke
- Post release high-level functional

#### Non-Functional
##### Performance
- System time out
- Use under load
- System recovery

##### Code Review
Using onRouteBC Specifications as test cases and comparing against dev complete feature prior to merging to the test branch.
- Completed by Dev
- Black box and white box

##### Security
- Log on and off
- Authorization
- 
##### Vulnerability
- Attack simulation

## People and Schedule

```mermaid
sequenceDiagram

title Testing Sequence (In Sprint 2)

autonumber
participant d as Dev
participant x as UX/UI
participant b as BVT
participant u as UAT

note over d: Sprint 1 Dev Complete
loop Corrections/Bug Reports
	d-->x: Test Sprint 1 Dev Complete
end
x-->>b: UX/UI Test Complete
loop Corrections/Bug Reports
	b-->d: Test Sprint 1 Dev Complete
end	
b-->>u: BVT Test Complete
loop Corrections/Bug Reports
	b-->u: Test Sprint 1 Dev Complete
end	
```

| Test Type | People                | When and What                            | Data | Manual or Automated? |
| --------- | --------------------- | ---------------------------------------- | ---- | -------------------- |
| UX/UI     | UX Designers and Devs | Testing Dev complete from prior Sprint   |      | Manual               |
| BVT       | IMB and SMES          | Testing Dev complete from prior Sprint   |      | Manual               |
| UAT       | Users and SMES        | Testing BVT complete from current Sprint |      | Manual               |
|           |                       |                                          |      |                      |

## Corrections
- UX/UI fix prior to BVT?
- Bug reports assume fixing at a later date
- JIRA Bug issue creation

## Future Updates
- aligning version control and traceability
- 
