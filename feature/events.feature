Feature: Events are able to created, deleted and searched for.

  Scenario: when a put request is made to '/event/yyyymmdd' a 200 should be returned
    Given i make a put request on '/event/1999/01/01' with a payload of
"""
:pageTitle: Test Page Title
:body:
  h1_1: Heading 1
  image_1:
    :src: "/store/images/photos/thumbs/DSCF0107.jpg"
    :alt: Image 1 alt tag
    :id: Image id
    :width: 1024
  p_1: "Paragraph 1 text"
"""
    And i make a get request on '/event/1999/01/01'
    Then the page title should be 'Test Page Title'
    And the next element should be a h1 containing 'Heading 1'
    And the next element should be a img with the following attributes
    |alt|Image 1 alt tag|
    |id |Image id                                           |
    |src|/store/images/photos/thumbs/DSCF0107.jpg|
    |width|1024                                                  |
    And the next element should be a p containing 'Paragraph 1 text'