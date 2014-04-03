require 'spec_helper'

describe Subject do
  before { @subject = FactoryGirl.create(:subject) }
  subject { @subject }

  it { should respond_to( :name )}
  it { should respond_to( :total_questions )}
  it { should respond_to( :time_limit )}
  it { should be_valid }
  
  it "should have 5 questions" do
  	subject = FactoryGirl.create(:subject)
    expect(subject.questions.count).to eql(5)    
    expect(subject.total_questions).to eql(30)
    expect(subject.time_limit).to eql(30 * 60)
  end

  it "should get total_questions by exam_id" do
    exam = FactoryGirl.create(:exam)
    subject = exam.exams_subjects.first.subject
    total_questions = subject.retrieve_total_questions exam.id
    expect(total_questions).to eql(exam.exams_subjects.first.total_questions)
  end
end
