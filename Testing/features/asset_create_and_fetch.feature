#Feature: Once an assets has been uploaded it should be able to be retrieved from a public url
#
#  Scenario: Upload an asset and then retrieve it from a public url
#    Given a put request is made on '/images/thumbnail' with an image asset a response code of '200' should be returned
#    When a get request is made on the store with the following '/images/thumbnail' the same image asset should be returned with a response code of '200'
