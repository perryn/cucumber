Feature: backgrounds
  In order to provide a context to my scenarios within a feature
  As a feature editor
  I want to write a background section in my features.

  Scenario: run a specific scenario with a background
    When I run cucumber -q features/background/passing_background.feature:9 --require features
    Then it should pass with
    """
    Feature: Passing background sample
    
      Background: 
        Given '10' cukes

      Scenario: another passing background
        Then I should have '10' cukes

    1 scenario (1 passed)
    2 steps (2 passed)
    
    """
  
  Scenario: run a feature with a background that passes
    When I run cucumber -q features/background/passing_background.feature --require features
    Then it should pass with
    """
    Feature: Passing background sample

      Background: 
        Given '10' cukes

      Scenario: passing background
        Then I should have '10' cukes

      Scenario: another passing background
        Then I should have '10' cukes

    2 scenarios (2 passed)
    4 steps (4 passed)
    
    """

  Scenario: run a feature with scenario outlines that has a background that passes
    When I run cucumber -q features/background/scenario_outline_passing_background.feature --require features
    Then it should pass with
    """
    Feature: Passing background with scenario outlines sample

      Background: 
        Given '10' cukes

      Scenario Outline: passing background
        Then I should have '<count>' cukes

        Examples: 
          | count |
          | 10    |

      Scenario Outline: another passing background
        Then I should have '<count>' cukes

        Examples: 
          | count |
          | 10    |

    2 scenarios (2 passed)
    4 steps (4 passed)

    """

  Scenario: run a feature with a background that fails
    When I run cucumber -q features/background/failing_background.feature --require features
    Then it should fail with
    """
    @after_file
    Feature: Failing background sample

      Background: 
        Given failing without a table
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `flunker'
          ./features/step_definitions/sample_steps.rb:16:in `/^failing without a table$/'
          features/background/failing_background.feature:5:in `Background:  : Given failing without a table'
        And '10' cukes

      Scenario: failing background
        Then I should have '10' cukes

      Scenario: another failing background
        Then I should have '10' cukes

    2 scenarios (1 failed, 1 skipped)
    6 steps (1 failed, 5 skipped)

    """
    And "examples/self_test/tmp/after.txt" should exist

  Scenario: run a feature with scenario outlines that has a background that fails
    When I run cucumber -q features/background/scenario_outline_failing_background.feature --require features
    Then it should fail with
    """
    Feature: Failing background with scenario outlines sample

      Background: 
        Given failing without a table
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `flunker'
          ./features/step_definitions/sample_steps.rb:16:in `/^failing without a table$/'
          features/background/scenario_outline_failing_background.feature:4:in `Background:  : Given failing without a table'

      Scenario Outline: failing background
        Then I should have '<count>' cukes

        Examples: 
          | count |
          | 10    |

      Scenario Outline: another failing background
        Then I should have '<count>' cukes

        Examples: 
          | count |
          | 10    |

    2 scenarios (1 failed, 1 skipped)
    4 steps (1 failed, 3 skipped)

    """

  Scenario: run a feature with a background that is unimplemented
    When I run cucumber -q features/background/missing_background.feature --require features
    Then it should pass with
    """
    Feature: Pending background sample

      Background: 
        Given missing

      Scenario: missing background
        Then I should have '10' cukes

      Scenario: another missing background
        Then I should have '10' cukes

    2 scenarios (2 undefined)
    4 steps (2 skipped, 2 undefined)

    """

  Scenario: background passes with first scenario but fails with second
    When I run cucumber -q features/background/failing_background_after_success.feature --require features
    Then it should fail with
    """
    Feature: Failing background after previously successful background sample

      Background: 
        Given passing without a table
        And '10' global cukes

      Scenario: passing background
        Then I should have '10' global cukes

      Scenario: failing background
        And '10' global cukes
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `flunker'
          ./features/step_definitions/sample_steps.rb:37:in `/^'(.+)' global cukes$/'
          features/background/failing_background_after_success.feature:5:in `Background:  : And '10' global cukes'
        Then I should have '10' global cukes

    2 scenarios (1 failed, 1 passed)
    6 steps (1 failed, 1 skipped, 4 passed)

    """

  Scenario: background with multline args
  When I run cucumber -q features/background/multiline_args_background.feature --require features
  Then it should pass with
    """
    Feature: Passing background with multiline args

      Background: 
        Given table
          | a | b |
          | c | d |
        And multiline string
          \"\"\"
            I'm a cucumber and I'm okay. 
            I sleep all night and I test all day
          \"\"\"

      Scenario: passing background
        Then the table should be
          | a | b |
          | c | d |
        Then the multiline string should be
          \"\"\"
            I'm a cucumber and I'm okay. 
            I sleep all night and I test all day
          \"\"\"

      Scenario: another passing background
        Then the table should be
          | a | b |
          | c | d |
        Then the multiline string should be
          \"\"\"
            I'm a cucumber and I'm okay. 
            I sleep all night and I test all day
          \"\"\"

    2 scenarios (2 passed)
    8 steps (8 passed)
    
    """

  Scenario: background with name
    When I run cucumber -q features/background/background_with_name.feature --require features
    Then it should pass with
    """
    Feature: background with name

      Background: I'm a background and I'm ok
        Given '10' cukes

      Scenario: example
        Then I should have '10' cukes

    1 scenario (1 passed)
    2 steps (2 passed)
    
    """

  @josephwilk
  Scenario: run a scenario showing explicit background steps --explicit-background
