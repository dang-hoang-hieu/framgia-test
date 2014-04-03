require 'spec_helper'

describe AnswersSheet do
  it "should relate to 1 subject" do
  	subject = FactoryGirl.create(:subject)
    answers_sheet = FactoryGirl.create(:answers_sheet, subject_id: subject.id)
    expect(answers_sheet.subject).to eql(subject)
  end

  it "should relate to 1 examination" do
    examination = FactoryGirl.create(:examination)
    answers_sheet = FactoryGirl.create(:answers_sheet, examination_id: examination.id)
    expect(answers_sheet.examination).to eql(examination)
  end

  it "should have many answers_sheet details" do
  	answers_sheet = FactoryGirl.create(:answers_sheet)
  	expect(answers_sheet.answers_sheet_details.count).to be > 1
  end

  it "should editable when time limit is supplied" do
  	answers_sheet = FactoryGirl.create(:answers_sheet)
  	expect(answers_sheet.editable?(100)).to be_true
  end

  it "should not editable when time limit less than time passed" do
  	answers_sheet = FactoryGirl.create(:answers_sheet)
  	expect(answers_sheet.editable?(-1)).to be_false
  end
  
  it "should calculate correct answer when save and got result 0" do
    examination = FactoryGirl.create(:examination)
    answers_sheet = FactoryGirl.create(:answers_sheet, examination_id: examination.id)
    answers_sheet.save
    expect(answers_sheet.result).to eql(0)
  end

  it "should calculate correct answer when save and got result" do
    examination = FactoryGirl.create(:examination)
    answers_sheet = FactoryGirl.create(:answers_sheet, examination_id: examination.id)
    answers_sheet.answers_sheet_details.each do |answers_sheet_detail|
      answers_sheet_detail.user_answers.each do |user_answer|
        user_answer.checked = user_answer.answer.id if user_answer.answer.correct_answer.present?
        user_answer.save
      end
    end
    answers_sheet.save
    expect(answers_sheet.result).to be > 0
  end  
end

