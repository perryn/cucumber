Feature: Cucumber --work-in-progress switch
  In order to ensure that feature scenarios do not pass until they are expected to
  Developers should be able to run cucumber in a mode that
            - will fail if any scenario passes completely
            - will not fail otherwise

  
  Scenario: Allow Failing Scenarios
    When I run cucumber -q features/work_in_progress/failing.feature -w --require features
    Then it should pass 
    And the output should contain
      """  
      1 scenario (1 failed)
      1 step (1 failed)
      """
  Scenario: Allow Unimplemented Scenarios
    When I run cucumber -q features/work_in_progress/unimplemented.feature -w --require features
    Then it should pass 
    And the output should contain
      """    
      1 scenario (1 undefined)
      1 step (1 undefined)
      """
      
  Scenario: Allow Pending Scenarios
    When I run cucumber -q features/work_in_progress/pending.feature -w --require features
    Then it should pass 
    And the output should contain
    """
    1 scenario (1 pending)
    1 step (1 pending)
    """ 
  
  Scenario: Do not allow Passing Scenarios 
    When I run cucumber -q features/work_in_progress/passing.feature -w --require features
    Then it should fail
    And the output should contain
    """
    1 scenario (1 passed)
    1 step (1 passed)
    
    Some scenarios passed, but the --work-in-progress switch was used
    (::) passed scenarios (::)

    features/work_in_progress/passing.feature:3:in `Scenario: Passing'
    """     

  
  Scenario: should work with a scenario outline 
    When I run cucumber -q features/work_in_progress/outline.feature -w --require features
    Then it should fail
    And the output should contain
    """
    2 scenarios (1 failed, 1 passed)
    2 steps (1 failed, 1 passed)
    
    Some scenarios passed, but the --work-in-progress switch was used
    (::) passed scenarios (::)
    
    features/work_in_progress/outline.feature:8:in `Scenario Outline: Outline : |passes|'
    """

  Scenario: any passing scenarios fail entire run
    When I run cucumber -q features/work_in_progress -w --require features
    Then it should fail
    And the output should contain
    """
    6 scenarios (2 failed, 1 undefined, 1 pending, 2 passed)
    6 steps (2 failed, 1 undefined, 1 pending, 2 passed)
    
    Some scenarios passed, but the --work-in-progress switch was used
    (::) passed scenarios (::)

    features/work_in_progress/outline.feature:8:in `Scenario Outline: Outline : |passes|'

    features/work_in_progress/passing.feature:3:in `Scenario: Passing'
    """
  
