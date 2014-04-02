class Examination < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :answers_sheets, dependent: :destroy
  belongs_to :subject

  LOWEST_RESULT_TO_PASS = 0.5
  PENDING = 0
  
  def remove_trash
    unless self.exam_id? || self.answers_sheets.present?
      self.destroy
    end
  end

  def being_taken?
    passed.nil?
  end

  def calculate_result status = PENDING
    self.passed = true

    answers_sheets_taken = AnswersSheet.where(examination_id: id, status: status)
    total_answers_sheets = self.exam.try(:exams_subjects) 
    if answers_sheets_taken.count == total_answers_sheets.try(:count)
      answers_sheets_taken.each do |answers_sheet|
        total_mark = answers_sheet.answers_sheet_details.count
        if (answers_sheet.result.to_f / total_mark) < LOWEST_RESULT_TO_PASS
          self.passed = false
          break
        end
      end
    else
      self.passed = false
    end

    self.save
  end
end
