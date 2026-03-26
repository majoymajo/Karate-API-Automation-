Feature: AutomationExercise Products API Tests

  Background:
    * url baseUrl

  @GET @API-1
  Scenario: GET - Get All Products List
    Given path '/api/productsList'
    * retry until responseStatus == 200
    When method get
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.products == '#array'
    And match response.products == '#notnull'
    And match each response.products contains { id: '#number', name: '#string', price: '#string', brand: '#string', category: '#notnull' }

  @POST @API-2 @negative
  Scenario: POST - POST To All Products List (Method Not Supported)
    Given path '/api/productsList'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 405 }
    And match response.message == 'This request method is not supported.'

  @GET @API-3
  Scenario: GET - Get All Brands List
    Given path '/api/brandsList'
    * retry until responseStatus == 200
    When method get
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.brands == '#array'
    And match response.brands == '#notnull'

  @PUT @API-4 @negative
  Scenario: PUT - PUT To All Brands List (Method Not Supported)
    Given path '/api/brandsList'
    * retry until responseStatus == 200
    When method put
    Then status 200
    And match response contains { responseCode: 405 }
    And match response.message == 'This request method is not supported.'

  @POST @API-5
  Scenario: POST - Search Product by Name
    Given path '/api/searchProduct'
    And form field search_product = 'top'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 200 }
    And match response.products == '#array'
    And match response.products == '#notnull'

  @POST @API-6 @negative
  Scenario: POST - Search Product Without Parameter (Bad Request)
    Given path '/api/searchProduct'
    * retry until responseStatus == 200
    When method post
    Then status 200
    And match response contains { responseCode: 400 }
    And match response.message == 'Bad request, search_product parameter is missing in POST request.'
