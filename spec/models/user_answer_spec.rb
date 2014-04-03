require 'spec_helper'

describe UserAnswer do
  it "should have belongs to an answers" do
    answer = FactoryGirl.create(:answer)
    user_answer = FactoryGirl.create(:user_answer, answer_id: answer.id)
    expect(user_answer.answer).to eql(answer)
  end

  it "should have default checked equal nil" do
    user_answer = FactoryGirl.create(:user_answer)
    expect(user_answer.checked).to eql(nil)
  end
end
