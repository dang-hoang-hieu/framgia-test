require 'spec_helper'

describe AnswersSheetDetail do
  it "should have question" do
  	question = FactoryGirl.create(:question)
    answers_sheet_detail = FactoryGirl.create(:answers_sheet_detail, question_id: question.id)
    expect(answers_sheet_detail.question).to eql(question)
  end

  it "should have 2 user answers" do
  	answers_sheet_detail = FactoryGirl.create(:answers_sheet_detail)
  	expect(answers_sheet_detail.user_answers.count).to eql(2)
  end

  it "should have 2 user answers related to this" do
  	answers_sheet_detail = FactoryGirl.create(:answers_sheet_detail)
  	expect(answers_sheet_detail.user_answers.first.answers_sheet_detail_id).to eql(answers_sheet_detail.id)
  end
  
  it "should check correct after find" do
  	question = FactoryGirl.create(:question)
  	answer = FactoryGirl.create(:answer, question_id: question.id)

    answers_sheet_detail = FactoryGirl.create(:answers_sheet_detail, question_id: question.id)
    user_answer = FactoryGirl.create(:user_answer, answers_sheet_detail_id: answers_sheet_detail.id, answer_id: answer.id, 
    	checked: nil)
    answers_sheet_detail = AnswersSheetDetail.find answers_sheet_detail.id
    expect(answers_sheet_detail.correct).to be_false
  end
end
