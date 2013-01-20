Feature: The timeline is a feature that will be used on it's own and also as part of other pages. It will provide the links required to navigate around all events that have been created.

  Scenario: The timeline should show all events that exist in the store
    Given Mo creates an event for 01/01/1999
    When Mo creates an event for 01/02/2003
    Then Mo should see the events created in the timeline

  Scenario: Clicking a title in the article should take you to the correct article
    Given Mo creates an event for 01/01/1999
    And Mo is on the timeline page
    When Mo clicks on the title for the event on 01/01/1999
    Then Mo should be taken to the article for the event on 01/01/1999