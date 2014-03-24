if Admin.where(email: "super@framgia-test.com").blank?
    Admin.create!(name: "Super Admin", email: "super@framgia-test.com", 
    	password: "foobar", password_confirmation: "foobar")
end

(1..10).each do |n|
	User.create!(name: "user #{n+1}", email: "user-#{n+1}@framgia-test.com", 
    	password: "password", password_confirmation: "password" )
end

# Subject
(1..5).each do |n|
	Subject.create!( name: "name #{n}")
end

# Level
(1..3).each do |n|
	Level.create!(level: n)
end

# prepare for generate question and answers
subjects 			 = Subject.all(limit: 3)
levels   			 = Level.all(limit: 3)

# generate questions and answers
subjects.each do |subject|
	levels.each do |level|	
			(1..20).each do						
					q = Question.create!(name: "#{Faker::Lorem.sentence(4)}?",
								subject_id: subject.id, 
								level_id: level.id)

					(rand(5) + 1).times do 
						Answer.create!(question_id: q.id, 
							name: "#{Faker::Lorem.sentence(rand(6) + 2)}?", 
							correct_answer: [true, false, false].sample )
					end
			end
	end
end

# generate exams
(1..3).each do |n|
	exam = Exam.create!(name: "Exam #{n}")
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 1, total_questions: 11 + rand(10),
                    time_limit: 20)
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 2, total_questions: 11 + rand(10),
                    time_limit: 20)
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 3, total_questions: 11 + rand(10),
                    time_limit: 20)
end

# generate answers sheets
users = User.all
exam_ids = Exam.ids.take(3)
subject_ids = Subject.ids.take(3)

users.each do |user|
	if [true, false].sample # fake exam
      exam_ids.shuffle.take(2).each do |exam_id|
    	sheet = AnswersSheet.create!(user_id: user.id, exam_id: exam_id, 
    		status: 1)
    	result = 0
    	sheet.exam.subjects.each do |subject|
    		# get question base on subject
    		number_questions = rand(10) + 11
    		number_correct   = 0
    		subject.questions.shuffle.take(number_questions).each do |question|    			
    			answer_detail = AnswersSheetDetail.create!(
    				answers_sheet_id: sheet.id, 
    				question_id: question.id)
    			answers = question.answers
    			answers.each do |answer|
    				if answer.correct_answer && [true, true, false].sample
    					UserAnswer.create!(
    						answers_sheet_detail_id: answer_detail.id,
    						answer_id: answer.id)
    					number_correct += 1
    				end
    			end
    		end
    		result = number_correct
    	end
    	sheet.update_attributes(result: result)
      end
	else # fake practice
        subject_ids.shuffle.take(2).each do |subject_id|
            sheet = AnswersSheet.create!(user_id: user.id, 
          	  subject_id: subject_id, status: 1)
            result = 0
            number_questions = rand(10) + 11
    	    number_correct   = 0
            subject = sheet.subject
            subject.questions.shuffle.take(number_questions).each do |question|
    			answer_detail = AnswersSheetDetail.create!(
    				answers_sheet_id: sheet.id, 
    				question_id: question.id)
    			answers = question.answers
    			answers.each do |answer|
    				if answer.correct_answer && [true, false].sample
    					UserAnswer.create!(
    						answers_sheet_detail_id: answer_detail.id,
    						answer_id: answer.id)
    					number_correct += 1
    				end
    			end
    		end
    		result = number_correct
    		sheet.update_attributes(result: result)
        end
	end
end

