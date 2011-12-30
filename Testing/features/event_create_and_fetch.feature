Feature: Events are able to created, deleted and searched for.

  Scenario: when a put request is made to the event url a get to the same url should return the content of the same event
    Given i make a put request on '/event/1999/01/01' with the following payload a '200' should be returned
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
    And i make a get request on '/event/1999/01/01' a '200' should be returned
    Then the page title should be 'Test Page Title'
    And the next element should be a h1 containing 'Heading 1'
    And the next element should be a img with the following attributes
    |alt|Image 1 alt tag|
    |id |Image id                                           |
    |src|/store/images/photos/thumbs/DSCF0107.jpg|
    |width|1024                                                  |
    And the next element should be a p containing 'Paragraph 1 text'

  Scenario: when two put requests are made to the event url for the same month both should be returned when a get is made to the event url with the year and the month
    Given i make a put request on '/event/1999/01/01' with the following payload a '200' should be returned
"""
:pageTitle: Test Page Title
:body:
  h1_1: Event 1
  image_1:
    :src: "/store/images/photos/thumbs/1.jpg"
    :alt: Image 1 alt tag
    :id: Image id 1
    :width: 1234
  p_1: "Paragraph 1 text"
"""
  And i make a put request on '/event/1999/01/02' with the following payload a '200' should be returned
"""
:pageTitle: Test Page Title
:body:
  h1_1: Event 2
  image_1:
    :src: "/store/images/photos/thumbs/2.jpg"
    :alt: Image 2 alt tag
    :id: Image id 2
    :width: 4567
  p_1: "Paragraph 2 text"
"""
  And i make a get request on '/event/1999/01' a '200' should be returned
  Then the page title should be 'The events of January 1999'
  And the next element should be a h1 containing 'Event 1'
  And the next element should be a img with the following attributes
  |alt|Image 1 alt tag|
  |id |Image id 1       |
  |src|/store/images/photos/thumbs/1.jpg|
  |width|1234                                  |
  And the next element should be a p containing 'Paragraph 1 text'
  And the next element should be a h1 containing 'Event 2'
  And the next element should be a img with the following attributes
  |alt|Image 2 alt tag|
  |id |Image id 2       |
  |src|/store/images/photos/thumbs/2.jpg|
  |width|4567                                  |
  And the next element should be a p containing 'Paragraph 2 text'