if Admin.where(email: "super@framgia-test.com").blank?
    Admin.create!(name: "Super Admin", email: "super@framgia-test.com", 
    	password: "foobar", password_confirmation: "foobar")
end

(1..10).each do |n|
  if User.where(email: "user-#{n+1}@framgia-test.com").blank?
	User.create!(name: "user #{n+1}", email: "user-#{n+1}@framgia-test.com", 
    	password: "password", password_confirmation: "password" )
  end
end

# Subject
(1..5).each do |n|
	Subject.create!( name: "name #{n}", total_questions: 30, time_limit: 30)
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
	ExamsSubject.create!(exam_id: exam.id, subject_id: 1, total_questions: 11 + rand(10),
                    time_limit: 20)
	ExamsSubject.create!(exam_id: exam.id, subject_id: 2, total_questions: 11 + rand(10),
                    time_limit: 20)
	ExamsSubject.create!(exam_id: exam.id, subject_id: 3, total_questions: 11 + rand(10),
                    time_limit: 20)
end
