Feature: AutomationExercise Account API Tests

  Background:
    * url baseUrl
    * def testEmail = 'karate_test_user_' + java.lang.System.currentTimeMillis() + '@test.com'
    * def testPassword = 'Test@12345'
    * def testName = 'KarateTestUser'

  @POST @PUT @DELETE @API-11 @API-13 @API-12
  Scenario: POST - Create Account, PUT - Update Account & DELETE - Delete Account

    # Step 1: POST - Create a new user account (API 11)
    Given path '/api/createAccount'
    And form field name = testName
    And form field email = testEmail
    And form field password = testPassword
    And form field title = 'Mr'
    And form field birth_date = '15'
    And form field birth_month = '6'
    And form field birth_year = '1990'
    And form field firstname = 'Karate'
    And form field lastname = 'Tester'
    And form field company = 'KarateLabs'
    And form field address1 = '123 Karate Street'
    And form field address2 = 'Suite 100'
    And form field country = 'United States'
    And form field zipcode = '10001'
    And form field state = 'New York'
    And form field city = 'New York'
    And form field mobile_number = '1234567890'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 201 }
    And match response.message == 'User created!'

    # Step 2: PUT - Update the user account (API 13)
    Given path '/api/updateAccount'
    And form field name = testName + '_updated'
    And form field email = testEmail
    And form field password = testPassword
    And form field title = 'Mr'
    And form field birth_date = '20'
    And form field birth_month = '8'
    And form field birth_year = '1992'
    And form field firstname = 'KarateUpdated'
    And form field lastname = 'TesterUpdated'
    And form field company = 'KarateLabsUpdated'
    And form field address1 = '456 Updated Street'
    And form field address2 = 'Suite 200'
    And form field country = 'Canada'
    And form field zipcode = '20002'
    And form field state = 'Ontario'
    And form field city = 'Toronto'
    And form field mobile_number = '9876543210'
    * retry until responseStatus == 200
    When method put
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.message == 'User updated!'

    # Step 3: DELETE - Delete the user account (API 12)
    Given path '/api/deleteAccount'
    And form field email = testEmail
    And form field password = testPassword
    * retry until responseStatus == 200
    When method delete
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.message == 'Account deleted!'
