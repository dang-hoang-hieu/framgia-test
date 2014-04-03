FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end  
  factory :level do
    sequence(:level)  { |n| n }
  end

  factory :answer do
    sequence(:name)  { |n| "answer #{n}" }
    correct_answer true
  end

  factory :question do
    sequence(:name)  { |n| "question #{n}" }
    level_id 1
    subject_id 1
  end

  factory :subject do
    sequence(:name)  { |n| "subject #{n}" }
    total_questions 30
    time_limit 30

    questions do
      5.times.map { FactoryGirl.create(:question) }
    end
  end

  factory :exam do
    sequence(:name)  { |n| "exam #{n}" }

    exams_subjects do
      2.times.map do
        subject = FactoryGirl.create(:subject)
        FactoryGirl.create(:exams_subject, exam_id: id, subject_id: subject.id)
      end
    end
  end  

  factory :exams_subject do
    sequence(:subject_id)  { |n| n }
    sequence(:exam_id)  { |n| n }
    time_limit 30
    total_questions 30
  end
  
  factory :user_answer do
    answers_sheet_detail_id 1
    answer_id 1
    checked nil
  end

  factory :answers_sheet_detail do
    answers_sheet_id 1
    question_id 1

    user_answers do
      2.times.map do
        answer = FactoryGirl.create(:answer, question_id: question_id)
        FactoryGirl.create(:user_answer, answers_sheet_detail_id: id, answer_id: answer.id, checked: nil)
      end
    end
  end

  factory :answers_sheet do
    examination_id nil
    subject_id nil
    status 1
    result 0

    answers_sheet_details do
      2.times.map do
        question = FactoryGirl.create(:question)
        FactoryGirl.create(:answers_sheet_detail, answers_sheet_id: id, question_id: question.id)
      end
    end
  end

  factory :examination do
    user_id 1
    exam_id nil
    subject_id nil
    passed false

    answers_sheets do
      2.times.map do
        FactoryGirl.create(:answers_sheet, examination_id: id, status: 0, result: 0)
      end
    end
  end
end