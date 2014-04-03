require 'spec_helper'

describe Examination do
  before { @examination = FactoryGirl.create(:examination) }
  subject { @examination }

  it { should respond_to( :user_id )}
  it { should respond_to( :exam_id )}
  it { should respond_to( :subject_id )}
  it { should respond_to( :passed )}
  it { should be_valid }
  
  it "should have 3 answers sheets" do
  	examination = FactoryGirl.create(:examination)
    expect(examination.answers_sheets.count).to eql(2)
  end

  it "calculate result should got result false" do
  	examination = FactoryGirl.create(:examination)
  	examination.calculate_result
  	expect(examination.passed).to eql(false)
  end

  it "calculate result should got result true" do
    exam = FactoryGirl.create(:exam)  	
  	examination = FactoryGirl.create(:examination, exam_id: exam.id)
    examination.answers_sheets.map do |answers_sheet|
      answers_sheet.status = 1
      answers_sheet.answers_sheet_details.map do |answers_sheet_detail|
        answers_sheet_detail.user_answers.map do |user_answer|
          user_answer.checked = user_answer.answer_id
          user_answer.save
        end
      end
      answers_sheet.save
    end

    examination.calculate_result
    expect(examination.reload.passed).to eql(true)
  end
end
