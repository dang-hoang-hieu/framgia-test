require 'spec_helper'

describe Exam do
  before { @exam = FactoryGirl.create(:exam) }
  subject { @exam }

  it { should respond_to(:name)}
  it { should be_valid }
  
  it "should not be valid when name nil" do
    exam = FactoryGirl.create(:exam)
    exam.name = ""
    expect(exam).not_to be_valid
  end

  it "should have 2 exams_subjects" do
  	exam = FactoryGirl.create(:exam, name: "exam 9")
    expect(exam.exams_subjects.count).to eql(2)   
    expect(exam.name).to eql("exam 9")
  end

  it "should have 2 subjects" do
  	exam = FactoryGirl.create(:exam)
    expect(exam.subjects.count).to eql(2)
  end

  it "should have same exam id" do
  	exam = FactoryGirl.create(:exam)
    expect(exam.exams_subjects.first.exam_id).to eql(exam.id)
  end
end
