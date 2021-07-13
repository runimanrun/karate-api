Feature: User Functionality

  Background: :
    * def schemaPosts = read('../data/schemaPosts.json')
    * def schemaPostsComment = read('../data/schemaPostsComment.json')
    * def generator =
    """
    function(){
      var userId = Math.floor(Math.random() * 100);
      var title = Math.random().toString(36).substring(7);
      var body = Math.random().toString(36).substring(2);
      return { userId: userId, title: title, body: body};
    }
    """
    * header Content-type = "application/json; charset=UTF-8"
    * url "https://jsonplaceholder.typicode.com"

  Scenario: Get Posts
    Given path "/posts"
    When method GET
    Then status 200
    And match response[0] == schemaPosts
    And match response[*].title contains 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit'
    And match response[*].body contains 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'

  Scenario: Create Posts
    Given path "/posts"
    * def data = call generator
    And request { userId: '#(data.userId)', title: '#(data.title)' , body: '#(data.body)'}
    When method POST
    Then status 201
    And match response == schemaPosts
    And match response.userId == data.userId
    And match response.title == data.title
    And match response.body == data.body

  Scenario: Get Posts Comment
    Given path "/posts/1/comments"
    When method GET
    Then status 200
    And match response[0] == schemaPostsComment
    And match response[*].name contains 'id labore ex et quam laborum'
    And match response[*].email contains 'Eliseo@gardner.biz'
