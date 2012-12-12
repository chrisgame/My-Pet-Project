Feature: Users should be able to a view of assets on a time table to allow them to search by time and image for an article

  Scenario: Editors should be able to see all assets arranged by the created date on calendar style view
    Given Mo uploads an image asset with a filename of 'test2.jpg'
    And Mo uploads an image asset with a filename of 'test3.jpg'
    And Mo uploads an image asset with a filename of 'test4.jpg'
    When Mo goes to '/gallery/timeline'
    Then Mo should see only the assets he uploaded earlier
