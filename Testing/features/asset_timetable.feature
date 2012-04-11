Feature: Users should be able to a view of assets on a time table to allow the to search by time and image for an article

  Scenario: Editors should be able to see all assets arranged by the created date on calendar style view
    Given Mo uploads an image asset with a filename of 'test1.jpeg'
    And Mo uploads an image asset with a filename of 'test2.jpeg'
    And Mo uploads an image asset with a filename of 'test3.jpeg'
    And Mo uploads an image asset with a filename of 'test4.jpeg'
    When Mo goes to '/asset-timetable'
    Then Mo should see only the assets he uploaded earlier