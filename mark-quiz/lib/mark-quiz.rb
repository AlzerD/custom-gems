class MarkQuiz
	def self.check_quiz(quiz, quiz_attempt)
		puts "The quiz_id passed is #{quiz.id}"
		puts "The quiz_attempt_id passed is #{quiz_attempt.id}"

		@user_answers = UserAnswer.where(quiz_attempt_id: quiz_attempt).order(:id)
		puts "The user answers are"
		puts @user_answers.inspect
		puts "The number of answers is #{@user_answers.count}"


		puts "The quiz questions are:"
		puts quiz.question.inspect

		@quiz_answers = Answer.where(question_id: quiz.question, correct: true).order(:id)
		puts "The answers are"
		puts @quiz_answers

		index = 0
		points = 0
		while index < @user_answers.count
			puts "@user_answers[index].answer_id: #{@user_answers[index].answer_id}"
			puts "@quiz_answers[index].id: #{@quiz_answers[index].id}"
			# If the user got the question right
			if @user_answers[index].answer_id == @quiz_answers[index].id
				@user_answers[index].points = @quiz_answers[index].question.points
				@user_answers[index].correct = true
				points += @quiz_answers[index].question.points
				@user_answers[index].save		
			# If the user got the question wrong	
			else
				@user_answers[index].points = 0
				@user_answers[index].correct = false
				@user_answers[index].save					
			end
			index += 1	
		end	

		quiz_attempt.points = points
		if points >= quiz.pass_points
			quiz_attempt.passed = true
		else
			quiz_attempt.passed = false
		end
		quiz_attempt.save

	end
end