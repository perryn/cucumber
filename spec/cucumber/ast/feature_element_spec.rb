require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/step_mother'
require 'cucumber/ast'

module Cucumber
  describe FeatureElement do
    include FeatureElement

    describe "with multiline names" do
      it "should select the longest line as the text length" do
        @keyword = "key"  
        @name = "short\nvery longer\ntiny"
        text_length.should == 11 + Ast::Step::INDENT - 1
      end
      
      it "should add keyword to first lines length" do
        @keyword = "key"  
        @name = "short\nvery longer\ntiny"
        
        first_line_length.should == (@keyword.jlength) + (first_line_name_length = 5)
      end
    end
    
    describe "with empty name" do
      it "should only return the length of the keyword" do
        @name = ""
        @keyword = "key"
        
        text_length.should == 3
      end
    end

    it "should support checking if its name matches a list of regexps" do
      @name = 'test'
      matches_scenario_names?([/es/]).should be_true
    end
    
    it "should generate a backtrace including keyword ,name and line" do
       @keyword = "key"  
       @name = "name"
       @line = "2"
       @feature = "mock feature"
       @feature.should_receive(:backtrace_line).with("key name","2").and_return("full line")
       backtrace_line.should eql("full line")
    end
    
    it "should be able to generate a backtrace with extra name info and overridden line" do
       @keyword = "key"  
       @name = "name"
       @line = "2"
       @feature = "mock feature"
       @feature.should_receive(:backtrace_line).with("key name : extra name","3").and_return("full line")
       backtrace_line("extra name", "3").should eql("full line")
    end
    
    it "should generate an empty backtrace if there is no feature" do
       @keyword = "key"  
       @name = "name"
       @line = "2"
       backtrace_line.should be_nil
    end
    
    
  end
end

