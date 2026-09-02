@orv2-5727 https://onroutebc.atlassian.net/browse/ORV2-5727
Feature: As staff I need to be able to review and confirm my STOW permit application details so that I can add it to the shopping cart.

Staff = PC, SA, TRAIN, CTPO

# Notes
 # see User Review and Confirm STOW.feature for user review and confirm details

# Application Submission
 @orv2-5727-1
 Rule: Staff can add a STOW permit application to the shopping cart

 @orv2-5727-2
 Rule: Staff can add a STOW permit application to the cart that has violations and policy validation warnings

 @orv2-5727-3
 Rule: Staff see a warning modal if the application has violations and policy validation warnings when they choose to add to cart

   Scenario: permit application has policy validation warnings and staff choose to continue
     Given permit application has policy validation warnings
      When staff choose to add to cart
      Then they see: "Application has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit application and would like to add it to the cart. Cancel Add to Cart"

   Scenario: cancel add to cart
     Given permit application has policy validation warnings
       And they are at the warning modal
      When staff choose to cancel
      Then they are directed back to the review and confirm page

   Scenario: choose to add to cart
     Given permit application has policy validation warnings
       And they are at the warning modal
      When staff choose to add to cart
      Then they are directed to the shopping cart page