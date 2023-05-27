title PayBC Sequence

bottomparticipants
fontawesome5solid f4df "CV Client / Browser" as CV
fontawesome5brands f395 "onRouteBC" as ORBC
fontawesome5solid f1c0 "Database" as DB
fontawesome5solid f09d PayBC

CV->ORBC: Select 'Credit Card' as\npayment type
ORBC-->>CV: Send redirect to PayBC
CV->PayBC: Supply amount and invoice number to PayBC
note over CV,PayBC: This is automatically sent by the browser, does not involve any user actoin
PayBC-->>CV: Present payment details screen
CV->PayBC: Supply payment details (CC number, etc)
PayBC->PayBC: Process payment
note over PayBC: Assume successful\npayment in this diagram
PayBC-->>CV: Send redirect to ORBC, including transaction details
CV->ORBC: Supply transaction details
note over CV,ORBC: Does not involve user interaction, \nautomatically sent by the browser
ORBC->ORBC: Validate transaction\ndetails
note over ORBC: Not sure how this will be done,\nbut we need to ensure the message\nhas not been tampered with.
ORBC->>DB: Save transaction details for permit