class AnswersSheet < ActiveRecord::Base
  belongs_to :examination
  belongs_to :subject
  has_many   :answers_sheet_details, dependent: :destroy
  accepts_nested_attributes_for :answers_sheet_details
  before_update :calculate_correct_answer, if: :have_answers_sheet_detail?
  after_update :calculate_result
  before_create :set_status_to_pending, unless: :have_answers_sheet_detail?  
  PENDING = 0
  SUCCESS = 1
  ASSERTED = 2

  def editable? time_limit
    time_passed = Time.now.to_i - created_at.to_i
    time_passed < time_limit
  end

  def generate_questions
    number_questions = get_total_questions

    question_ids = Question.find_by_subject(subject_id).ids
    questions = Question.find(question_ids.shuffle.take(number_questions))
    questions.each do |q|
      detail = self.answers_sheet_details.build(question_id: q.id)
      detail.question.answers.each do |answer|
        detail.user_answers.build(answer_id: answer.id)
      end
    end
  end
 
  def get_total_questions
    self.subject.total_questions self.examination.exam_id
  end

  private
  def calculate_correct_answer
    correct_num = 0
    self.answers_sheet_details.each do |detail|
      if self.status.to_i != ASSERTED
        user_answers    = detail.user_answers.pluck :checked
        correct_answers = detail.question.answers.correct_answers.ids
          
        correct_num += 1 if user_answers == correct_answers
      else
        correct_num += 1 if detail.correct.to_i > 0
      end
    end
    self.result = correct_num
  end
  
  private
  def calculate_result
    self.examination.calculate_result [SUCCESS, ASSERTED]
  end

  private
  def have_answers_sheet_detail?
    self.answers_sheet_details.size > 0
  end

  private
  def set_status_to_pending    
    self.status = PENDING
  end 
end
