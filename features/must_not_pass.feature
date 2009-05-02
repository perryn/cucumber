Feature: Cucumber --must_not_pass switch
  In order to ensure that feature scenarios do not pass until they are expected to
  Developers should be able to run cucumber in a mode that
            - will fail if any scenario passes completely
            - will not fail otherwise

  
  Scenario: Allow Failing Scenarios
    When I run cucumber -q features/must_not_pass/failing.feature --must-not-pass --require features
    Then it should pass 
    And the output should contain
      """  
      1 scenario (1 failed)
      1 step (1 failed)
      """
  Scenario: Allow Unimplemented Scenarios
    When I run cucumber -q features/must_not_pass/unimplemented.feature --must-not-pass --require features
    Then it should pass 
    And the output should contain
      """    
      1 scenario (1 undefined)
      1 step (1 undefined)
      """
      
  Scenario: Allow Pending Scenarios
    When I run cucumber -q features/must_not_pass/pending.feature --must-not-pass --require features
    Then it should pass 
    And the output should contain
    """
    1 scenario (1 pending)
    1 step (1 pending)
    """ 
  
  Scenario: Do not allow Passing Scenarios 
    When I run cucumber -q features/must_not_pass/passing.feature --must-not-pass --require features
    Then it should fail
    And the output should contain
    """
    1 scenario (1 passed)
    1 step (1 passed)
    """     
  
  Scenario: should work with a scenario outline 
    When I run cucumber -q features/must_not_pass/outline.feature --must-not-pass --require features
    Then it should fail
    And the output should contain
    """
    2 scenarios (1 failed, 1 passed)
    2 steps (1 failed, 1 passed)
    """

  Scenario: any passing scenarios fail entire run
    When I run cucumber -q features/must_not_pass --must-not-pass --require features
    Then it should fail
    And the output should contain
    """
    6 scenarios (2 failed, 1 undefined, 1 pending, 2 passed)
    6 steps (2 failed, 1 undefined, 1 pending, 2 passed)
    """
  
