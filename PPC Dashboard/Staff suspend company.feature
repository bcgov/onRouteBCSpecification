Feature: PC view suspend company
As PC I need to be able to view a suspended company profile in onRouteBC so that I can be informed of the companies status.

Staff = PC

@orv2-1880-1
Rule: Staff can turn on/off the suspend flag

  Scenario: 
    Given 
     When 
     Then 

@orv2-1880-2
Rule: On successful login a suspended CV Client is directed to a profile suspended page

@orv2-1880-3
Rule: PC 

@orv2-1880-4
Rule: Staff see indication of the CV Client suspended status on all page headers

@orv2-1880-5
Rule: Staff can input a reason for suspension

@orv2-1880-6
Rule: On successful save of reason for suspension the logged in user id and time and date are saved with the reason

@orv2-1880-7
Rule: On successfully turning the suspension on/off the CV Client is sent an email notification 

# When a Credit Account (CA) Holder is suspended any CA User of that account will not be able to use the CA Holders CA


