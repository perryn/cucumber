Feature: In Progress Rake task
  In order to easily see the status of features that are in progress
  As a developer and CI server administrator
  I want a convenient rake task to run all the currently in progress features

  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/step_definitions/steps.rb" with:
      """
      def flunker
        raise "FAIL"
      end

      Given /^passing$/ do
      end

      Given /^failing$/ do
        flunker
      end
      
      Given /^pending$/ do
        pending "foo"
      end
      
      """
    And a file named "Rakefile" with:
      """
      $LOAD_PATH.unshift(CUCUMBER_LIB)
      require 'cucumber/rake/task'

      Cucumber::Rake::InProgressTask.new()
      
      """


  Scenario: should fail if any scenarios pass (as that means they should be in regression)
    Given a file named "features/passing_in_progress.feature" with:
      """
      Feature: Sample

        @in_progress
        Scenario: passing
          Given passing
      """
    When I run rake in_progress
    Then it should fail
    And the output should contain
      """
      1 scenario (1 passed)
      1 step (1 passed)
      """

  Scenario: should pass if there are failing or undefined scenarios
    Given a file named "features/failing_in_progress.feature" with:
      """
      Feature: Sample
        
        @in_progress
        Scenario: failing
          Given failing
          
        @in_progress
        Scenario: missing
          Given missing
      """
    When I run rake in_progress
    Then it should pass
    And the output should contain
      """
      2 scenarios (1 failed, 1 undefined)
      2 steps (1 failed, 1 undefined)
      """
          
        
  Scenario: regression suite should not run scenarios unless marked as still in progress
    Given a file named "features/undefined_regression.feature" with:
      """
        Feature: Sample
            
          Scenario: passing
            Given passing
              
          @in_progress
          Scenario: failing
            Given failing
      """
    When I run rake in_progress 
    Then it should pass
    And the output should contain
      """
      1 scenario (1 failed)
      1 step (1 failed)
      """ 
