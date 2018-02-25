
  Feature: Search Gem "Acceptance Testing"
  
    Scenario: Search Gem "Acceptance Testing"
      When the user opens the site "rubygems.org"
      And input for search "acceptance_testing"
      And press "enter"
      Then the gem will open "acceptance_testing"
