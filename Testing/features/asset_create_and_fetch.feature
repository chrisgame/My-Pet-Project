Feature: Once an assets has been uploaded it should be able to be retrieved from a public url

  Scenario: Upload a new asset and then retrieve it from a public url
    Given a post request is made on '/upload' with an image asset with a filename of 'test.jpeg' a response code of '200' should be returned
    When a get request is made on the store with the following '/images/test.jpeg' the same image asset should be returned with a response code of '200'
    When Joe goes to '/images/test.jpeg' the same image asset should be displayed