Feature: AutomationExercise Login API Tests

  Background:
    * url baseUrl
    * def testEmail = 'karate_login_user_' + java.lang.System.currentTimeMillis() + '@test.com'
    * def testPassword = 'Test@12345'
    * def testName = 'KarateLoginUser'

  @POST @API-7
  Scenario: POST - Verify Login with Valid Details
    Given path '/api/createAccount'
    And form field name = testName
    And form field email = testEmail
    And form field password = testPassword
    And form field title = 'Mr'
    And form field birth_date = '10'
    And form field birth_month = '3'
    And form field birth_year = '1995'
    And form field firstname = 'Login'
    And form field lastname = 'Tester'
    And form field company = 'KarateLabs'
    And form field address1 = '789 Login Street'
    And form field address2 = ''
    And form field country = 'United States'
    And form field zipcode = '30003'
    And form field state = 'California'
    And form field city = 'Los Angeles'
    And form field mobile_number = '5551234567'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 201 }

    Given path '/api/verifyLogin'
    And form field email = testEmail
    And form field password = testPassword
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.message == 'User exists!'

    Given path '/api/deleteAccount'
    And form field email = testEmail
    And form field password = testPassword
    * retry until responseStatus == 200
    When method delete
    Then status 200

  @POST @API-8 @negative
  Scenario: POST - Verify Login Without Email Parameter (Bad Request)
    Given path '/api/verifyLogin'
    And form field password = 'anyPassword'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 400 }
    And match response.message == 'Bad request, email or password parameter is missing in POST request.'

  @DELETE @API-9 @negative
  Scenario: DELETE - DELETE To Verify Login (Method Not Supported)
    Given path '/api/verifyLogin'
    * retry until responseStatus == 200
    When method delete
    Then status 200
    And match response contains { responseCode: 405 }
    And match response.message == 'This request method is not supported.'

  @POST @API-10 @negative
  Scenario: POST - Verify Login with Invalid Details (User Not Found)
    Given path '/api/verifyLogin'
    And form field email = 'nonexistent_user_xyz@invalid.com'
    And form field password = 'wrongPassword123'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 404 }
    And match response.message == 'User not found!'
