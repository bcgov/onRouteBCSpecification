# GARMs Return Codes

## Return Codes
- E0001 - Weigh scale account not found
- E0002 - Weigh scale account is inactive
- E0003 - Weigh scale account on Hold
- E1739 - Weigh scale account has exceeded negative allowed amount
  - E0004 returned in SoapUI Ignore number?
- E9999 - Serious Error

## Test Environment Setup
- TPS Test
  - SA Role
- eGARMS Test
  - eGARMS account maintenance
  - Revenue Supervisor Role
- eGARMS list of known accounts to use for testing

## Tests
1. Does eGARMS send credit limit and account balance data with a return code?
   1. Return data with all return codes?
      1. get the credit limit and balance are returned with a return code
2. Inactive account with a balance
   1. What is returned?
3. Over limit using the 9-11 trick?
   1. Send file to GARMs with large transaction
4. Does eGARMS return multiple errors at once?
   1. Only get one code at a time
   2. WS0001 Reduce negative limit
      1. 10000 - not accepted by eGARMS
      2. 11217 - accepted by eGARMS
      3. SoapUI receives immediate
      4. Negative account limit reached not sent
   3. WS0001 Change to Inactive
      1. Not accepted E0624 CANNOT UPDATE THE ACTIVE INDICATOR WHEN BALANCE NOT EQUAL TO ZERO
   4. WS0360 Inactive + over limit
      1. Set account in eGARMS to inactive - E0624 CANNOT UPDATE THE ACTIVE INDICATOR WHEN BALANCE NOT EQUAL TO ZERO
   5. WS0017 Inactive + over limit
      1. Set account in eGARMS to inactive
      2. Soap receives 
         1. Inactive
         2. Negative Limit 0.00
   6. Hold + over limit
5. How does eGARMS prioritize return codes if there are more than one?
   1. Get what we get and show what is received
6. Is eGARMS the source of truth for credit account status or is it TPS?
   1. Is inactive E0002 - Weigh scale account is inactive - Closed in TPS?
      1. Staff update both eGARMS and TPS with close account
   2. Is hold E0003 - Weigh scale account on Hold - Hold in TPS?
   3. Is E1739 - Weigh scale account has exceeded negative allowed amount - over credit limit?
7. Can we still send a transaction from onRoute to eGARMS when a return code is received?
   1. Post Transaction to eGARMS accounts
      1. likely won't accept until a payment is made
      2. WS0360 - exceeded limit
         1. post transactions to eGARMS via credit file
            1. payment against permit - reduces balance of account
            2. refund against on a permit increases balance of account
            3. payment against account
         2. can do this through eGARMS by FIN manually (receive cheque) and via online banking
      3. WS0017 - inactive
      4. check eGARMS reports the next day
         1. Is it possible to get access to these report?
            1. Melanie Richardson?
   2. All return codes?
  
## Refunds
- eGARMs and TPS sync issues with regards to refunds
- Do we need to go to eGARMs to do refund screens (RTMPM) need to handle eGARMS return codes?
  
- E0001 Sample:
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<soap:Body>
<SendResponse xmlns="http://tempuri.org/">
<SendResult>
<return_code>E0001</return_code>
<account_balance>0</account_balance>
<negative_limit>0</negative_limit>
<account_balance_timestamp/>
<message>Weigh scale account not found</message>
</SendResult>
</SendResponse>
</soap:Body>
</soap:Envelope>
 
- wsdl url: [https://test.egarms.gov.bc.ca/SecuredWS/wsadetail.asmx?wsdl](https://test.egarms.gov.bc.ca/SecuredWS/wsadetail.asmx?wsdl "https://test.egarms.gov.bc.ca/securedws/wsadetail.asmx?wsdl") use it in browser with username as IDIR\TROREGD 
  - Garima can share password privately with whosoever needs it
- GARM connectivity information: [https://moti-imb.atlassian.net/browse/ORV2-4011](https://moti-imb.atlassian.net/browse/ORV2-4011 "https://moti-imb.atlassian.net/browse/orv2-4011")



- TPS Test
	- Julie has the same role as in TPS Office (Revenue Supervisor)
- eGARMS Test
	- TrishaB equivalent role in TPS Test (Revenue Supervisor) and eGARMS