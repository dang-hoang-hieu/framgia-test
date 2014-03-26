class ExamsController < ApplicationController
  before_action :signed_in_user
  
  def index
    @exams = current_user.exams
  end

  def show
    @exam = Exam.find params[:id]

    @answers_sheets_to_edit = AnswersSheet.find_all_by_exam_id params[:id]
    started_exam_subject_ids = @answers_sheets_to_edit
      .collect { |answers_sheet| answers_sheet.subject_id }
    @not_started_exam_subjects = @exam.subject_ids - started_exam_subject_ids
    @exam_subjects_pending = Subject.find @not_started_exam_subjects
  end
end
