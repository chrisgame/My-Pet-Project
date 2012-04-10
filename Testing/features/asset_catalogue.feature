Feature: An editor should be able to see all the assets, there details and where they are referenced

  Scenario: Editors should be able to see all assets that exist in the store on a single page
    Given Mo uploads an image asset with a filename of 'test1.jpeg'
    And Mo uploads an image asset with a filename of 'test2.jpeg'
    And Mo uploads an image asset with a filename of 'test3.jpeg'
    And Mo uploads an image asset with a filename of 'test4.jpeg'
    When Mo goes to '/asset-catalogue'
    Then Mo should see only the assets he uploaded earlier