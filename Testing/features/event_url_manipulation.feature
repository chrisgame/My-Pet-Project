Feature: Users can manipulate the url to request subsets of events

  Scenario: When a request is made for events from a particular month only events from that month should be returned
    Given Mo creates two events for the month of October
    And Mo creates two events for the month of November
    When Joe requests events in the month of October
    Then Joe should be returned only the two events created for the month of October

  Scenario: When a request is made for events from a particular year only events from that year should be returned
    Given Mo creates two events for the year of 1999
    And Mo creates two events for the year of 1996
    When Joe requests events in the year of 1999
    Then Joe should be returned only the two events created in the year 1999

  Scenario: When a request is made for events that only contains a month and a day the user should be prompted to use the year month day format
    Given Joe requests events from october 3rd
    Then Joe should see a message that states 'Events may be requested by year, year and month or year month day'

  Scenario: When a request is made for events that only contains a year and a day the user should be prompted to use the year month day format
    Given Joe requests events from 1999 on the 3rd
    Then Joe should see a message that states 'Events may be requested by year, year and month or year month day'

