Feature: Cucumber command line
  In order to write better software
  Developers should be able to execute requirements as tests

  Scenario: Run single failing scenario with default diff enabled
    When I run cucumber -q features/failing_expectation.feature
    Then it should fail with
      """
      Feature: Failing expectation

        Scenario: Failing expectation
          Given failing expectation
            expected: "that",
                 got: "this" (using ==)
            Diff:
            @@ -1,2 +1,2 @@
            -that
            +this
             (Spec::Expectations::ExpectationNotMetError)
            ./features/step_definitions/sample_steps.rb:63:in `/^failing expectation$/'
            features/failing_expectation.feature:4:in `Scenario: Failing expectation : Given failing expectation'

      1 scenario (1 failed)
      1 step (1 failed)

      """

  Scenario: Run single failing scenario with diff output disabled
    When I run cucumber -q --no-diff features/failing_expectation.feature
    Then it should fail with
      """
      Feature: Failing expectation

        Scenario: Failing expectation
          Given failing expectation
            expected: "that",
                 got: "this" (using ==) (Spec::Expectations::ExpectationNotMetError)
            ./features/step_definitions/sample_steps.rb:63:in `/^failing expectation$/'
            features/failing_expectation.feature:4:in `Scenario: Failing expectation : Given failing expectation'

      1 scenario (1 failed)
      1 step (1 failed)

      """

