require File.dirname(__FILE__) + '/../../spec_helper'

module Cucumber
  module Ast

    describe OutlineTable::ExampleCells  do

      it "should generate a backtrace line by passing cell contents and line to scenario outline " do
        cell_one = "stub cell"
        cell_one.stub!(:value).and_return("cell one")
        cell_one.stub!(:line).and_return("4")
        cell_two = "stub cell"
        cell_two.stub!(:value).and_return("cell two")
        cells =[cell_one, cell_two]

        example_cells = OutlineTable::ExampleCells.new(nil, cells)
        @scenario_outline = "mock outline"
        @scenario_outline.stub!(:step_invocations).and_return(nil)
        example_cells.create_step_invocations!(@scenario_outline)
        @scenario_outline.should_receive(:backtrace_line).with("|cell one|cell two|","4").and_return("result")
        example_cells.backtrace_line.should eql("result")
      end

    end
  end
end
