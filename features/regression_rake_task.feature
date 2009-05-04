Feature: Regression Rake task
  In order to easily distinguish between completed features and in progress work
  As a developer and CI server administrator
  I want a convenient rake task to run a regression suite

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

      Cucumber::Rake::RegressionTask.new()
      
      """


  
  Scenario: should pass if all steps pass or are explicitly pending
    Given a file named "features/passing_regression.feature" with:
      """
      Feature: Sample

        Scenario: passing
          Given passing

        Scenario: pending
          Given pending
      """
    When I run rake regression
    Then it should pass
    And the output should contain
      """
      2 scenarios (1 pending, 1 passed)
      2 steps (1 pending, 1 passed)
      """

  Scenario: should not pass if there are failures
    Given a file named "features/failing_regression.feature" with:
      """
      Feature: Sample

        Scenario: failing
          Given failing
      """
    When I run rake regression
    Then it should fail
    And the output should contain
      """
      1 scenario (1 failed)
      1 step (1 failed)
      """
          
  Scenario: regression suite should break when step refactoring acidentally causes steps to become undefined again
    Given a file named "features/undefined_regression.feature" with:
      """
        Feature: Sample

          Scenario: missing
            Given missing
      """
    When I run rake regression 
    Then it should fail
    And the output should contain
      """
      1 scenario (1 undefined)
      1 step (1 undefined)
      """ 
        
  Scenario: regression suite should not run scenarios marked as still in progress
    Given a file named "features/undefined_regression.feature" with:
      """
        Feature: Sample
            
          Scenario: passing
            Given passing
              
          @in_progress
          Scenario: failing
            Given failing
      """
    When I run rake regression 
    Then it should pass
    And the output should contain
      """
      1 scenario (1 passed)
      1 step (1 passed)
      """ 
            