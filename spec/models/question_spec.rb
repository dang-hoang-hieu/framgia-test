require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.create(:question) }
  subject { @question }

  it { should respond_to( :name )}
  it { should respond_to( :level_id )}
  it { should respond_to( :subject_id )}
  it { should be_valid}
  
  it "should have 3 answers" do
  	question = FactoryGirl.create(:question)
    expect(question.answers.count).to eql(3)    
    expect(question.answers.first.correct_answer).not_to be_nil
    expect(question.answers.last.name).not_to be_nil
  end
end
