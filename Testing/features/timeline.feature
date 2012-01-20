Feature: The timeline is a feature that will be used on it's own and also as part of other pages. It will provide the links required to navigate around all events that have been created.

  Scenario: The timeline should show all events that exist in the store
    When Mo creates an event for 01/02/2003
    Given Mo creates an event for 01/01/1999
    Then Mo should see the events created in the timeline