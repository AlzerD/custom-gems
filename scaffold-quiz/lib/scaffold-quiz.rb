class ScaffoldQuiz
	# Method to return the quiz type that the user should attempt
	def self.get_quiz(topic)
		puts "The topic_id passed is #{topic.id}"
		@quizzes = Quiz.where(topic_id: topic.id).order(:id).map(&:id)
		puts "Here's the quizzes"
		puts @quizzes.inspect
		@quiz_attempts = QuizAttempt.where(quiz_id: @quizzes).order(:id)
		puts "Here's the quiz attempts"
		puts @quiz_attempts.inspect		
		@quiz_attempts_ids = @quiz_attempts.map(&:quiz_id)
		puts "Here's the ids of the quizes attempted"
		puts @quiz_attempts_ids.inspect	
		
		@to_do = @quizzes - @quiz_attempts_ids
		puts "Here's the to_do ids"
		puts @to_do.inspect
		if @quiz_attempts.empty?
			return @quizzes[0]
		else
			# If the last quiz attempted was passed return the level of the next quiz to be attempted
			# Note the user will not be able to start a new quiz attempt if all quizzes are complete (see subject/show view)
			if (@quiz_attempts[-1].passed == true)
				return @to_do[0]		
			# if the last quiz attempted was failed return it's level so it can be completed again	
			else
				return @quiz_attempts[-1].quiz_id
			end 			
		end
	end
end