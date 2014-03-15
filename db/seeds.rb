if User.where(email: "super@framgia-test.com").blank?
    User.create!(name: "Super Admin", email: "super@framgia-test.com", 
    	password: "foobar", password_confirmation: "foobar", admin: true )
end

(1..10).each do |n|
	User.create!(name: "user #{n+1}", email: "user-#{n+1}@framgia-test.com", 
    	password: "password", password_confirmation: "password" )
end

# Subject
(1..10).each do |n|
	Subject.create!( subject: "subject #{n+1}")
end

# Level
(1..5).each do |n|
	Level.create!(level: "level #{n+1}")
end

# generate Question Types
QuestionType.create!(question_type: "Single choices")
QuestionType.create!(question_type: "Multiple choices")
QuestionType.create!(question_type: "Text")

# prepare for generate question and answers
subjects 			 = Subject.all(limit: 3)
levels   			 = Level.all(limit: 3)
question_types = QuestionType.all  

answer_list = Array.new

# generate questions and answers
subjects.each do |subject|
	levels.each do |level|
		question_types.each do |type|
			(1..10).each do

				unless type.question_type == "Text"
					answer_list.clear
					(0..3).each do |n|
						answer_list[n] = Faker::Lorem.sentence(2)	
					end
						
					q = Question.create!(question: "#{Faker::Lorem.sentence(4)}?",
								subject_id: subject.id, 
								level_id: level.id, 
								question_type_id: type.id,
								answer_list: answer_list.to_json)
				end	

				case type.question_type
				when "Single choices"	
					correct_answer = {:"#{type.id}" => (rand(4) + 1)}
					Answer.create!(question_id: q.id, answer: correct_answer.to_json)
				when "Multiple choices"
					correct_answer = {:"#{type.id}" => (1..4).to_a.shuffle.take(rand(4) + 1)}
					Answer.create!(question_id: q.id, answer: correct_answer.to_json)
				else
					q = Question.create!(question: "#{Faker::Lorem.sentence(4)}?",
								subject_id: subject.id, 
								level_id: level.id, 
								question_type_id: type.id,
								answer_list: "")
					correct_answer = Faker::Lorem.sentence(8)
					Answer.create!(question_id: q.id, answer: correct_answer)
				end

			end
		end
	end
end

# generate users' practices
users    = User.all
subjects = Subject.all(limit: 3)
result = Hash.new
users.each do |user|
	5.times do
		subjects.each do |subject|
			result.clear
			question_ids = (1..100).to_a.shuffle.take(30)
			question_ids.each do |q_id|
				result[q_id] = [true, false].sample
			end
			
	    Practice.create!(user_id: user.id, subject_id: subject.id, status: 1,
	      result: result.to_json)	
		end		
	end
end

# generate exams
(1..10).each do |n|
	exam = Exam.create!(exam: "Exam #{n + 1}", total_questions: 31 + rand(10),
	 				time_limit: 20)
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 1)
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 2)
	ExamsSubjects.create!(exam_id: exam.id, subject_id: 3)
end

# generate exams result
users = User.all
exams = Exam.all(limit: 4)
result = Hash.new
users.each do |user|
	exams.each do |exam|
		result.clear
		question_ids = (1..100).to_a.shuffle.take(exam.total_questions)
		question_ids.each do |q_id|
			result[q_id] = [true, false].sample
		end		
		ExamResult.create!(user_id: user.id, exam_id: exam.id, status: 1, 
			result: result.to_json)	
	end	
end

