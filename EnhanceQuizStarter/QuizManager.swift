import GameKit

class QuizManager {
    
    let questionsPerRound = 4
    var questionsAsked = 6
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    let quiz = Quiz()
    
    //selects a random number to be used as our quiz index
    func randomQuestion() {
        print("Finding Random Index")
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
    }
    
    ///sets the text for the question
    func setQuestionText() -> String {
        print("setting up the question")
        randomQuestion()
        let currentQustion = quiz.questions[indexOfSelectedQuestion].question
        return ("What is the generic name for \(currentQustion)")
    }
    
    ///Retruns the array of possible answers for the current question
    func getAnswers() -> [String] {
         print("getting answers array")
        return (quiz.questions[indexOfSelectedQuestion].answerOptions)
    }
    
    ///sets the result text for the current game
    func setResultText() -> String {
          print("getting Text for results")
        return ("Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!")
    }
    
    ///Checks the answer by comparing the buttons current displayed text to the quiz objects correct answer
    func checkAnswer(buttonText: String) -> String {
          print("Checking Answer")
        var correctStatus: Bool
        questionsAsked += 1
        let correctOption = quiz.questions[indexOfSelectedQuestion].correctAnswer
        let correctAnswer = getAnswers()[correctOption]
       
        if (buttonText.contains(correctAnswer)) {
            QuizSounds(soundName: "correct" , soundType: "wav").play()
            correctStatus = true
        } else{
            QuizSounds(soundName: "wrong" , soundType: "wav").play()
            correctStatus = false
        }
        return (correctStatus ? "Correct" : "Wrong Answer" )
    }
    
    ///Delays the next round
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            print("finishing time delay")
            self.nextRound()
        }
    }
    
    func nextRound() {
        print("Starting nextRound")
        if questionsAsked >= questionsPerRound {
            print("Game Over")
            ViewController().displayScore()
        } else {
            print("Keep playing")
            print("Loading next question")
            ViewController().displayQuestion()
        }
    }
    
    ///logic for if the play again button is clicked.
    func playAgain() {
        questionsAsked = 0
        correctQuestions = 0
        QuizSounds(soundName: "GameSound" , soundType: "wav").play()
        nextRound()
        print("Inside of play again")
    }
}
