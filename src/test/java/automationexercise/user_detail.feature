Feature: AutomationExercise User Detail API Tests

  Background:
    * url baseUrl
    * def testEmail = 'karate_detail_user_' + java.lang.System.currentTimeMillis() + '@test.com'
    * def testPassword = 'Test@12345'
    * def testName = 'KarateDetailUser'

  @GET @API-14
  Scenario: GET - Get User Account Detail by Email
    # Pre-requisite: Create an account first
    Given path '/api/createAccount'
    And form field name = testName
    And form field email = testEmail
    And form field password = testPassword
    And form field title = 'Mrs'
    And form field birth_date = '5'
    And form field birth_month = '12'
    And form field birth_year = '1988'
    And form field firstname = 'Detail'
    And form field lastname = 'Tester'
    And form field company = 'KarateLabs'
    And form field address1 = '321 Detail Avenue'
    And form field address2 = 'Apt 50'
    And form field country = 'Canada'
    And form field zipcode = '40004'
    And form field state = 'Quebec'
    And form field city = 'Montreal'
    And form field mobile_number = '5559876543'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 201 }

    # API 14: Get user detail by email
    Given path '/api/getUserDetailByEmail'
    And param email = testEmail
    * retry until responseStatus == 200
    When method get
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.user == '#notnull'
    And match response.user contains { name: '#string', email: '#string' }

    # Cleanup: Delete the created account
    Given path '/api/deleteAccount'
    And form field email = testEmail
    And form field password = testPassword
    * retry until responseStatus == 200
    When method delete
    Then status 200
