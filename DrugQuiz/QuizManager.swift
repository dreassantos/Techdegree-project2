import GameKit

class QuizManager {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var indexOfUsedQuestions:[Int] = []
    var questionsWrong:[String] = []
    let quiz = Quiz()
 
    /// Loads all of the games sounds
    func loadSounds(){
     
        startSound.loadSound(idNumber: &startSound.idNumber, soundName: startSound.soundName, soundType: startSound.soundType)
        correctSound.loadSound(idNumber: &correctSound.idNumber, soundName: correctSound.soundName, soundType: correctSound.soundType)
        wrongSound.loadSound(idNumber: &wrongSound.idNumber, soundName: wrongSound.soundName, soundType: wrongSound.soundType)
        //play the intro sound
        startSound.play(idNumber: startSound.idNumber)
    }
    
    /// Selects an unused random number to be set as our quiz index
    func randomQuestion() {
        //using a temp array to hold all of the used questions
        let tempSelectedIndex = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        if !(indexOfUsedQuestions.contains(tempSelectedIndex)){ //checks if the random number was already used
            indexOfUsedQuestions.append(tempSelectedIndex)
            indexOfSelectedQuestion = tempSelectedIndex // sets the index of the selected question if the index is not already used.
        } else { randomQuestion() } // if it was already used pick and test another number.
    }
    
    /// Returns the text for the question
    func getQuestionText() -> String {
        randomQuestion()
        let currentQustion = quiz.questions[indexOfSelectedQuestion].question
        return ("What is the generic name for \(currentQustion)?")
    }
    
    /// Retruns the array of possible answers for the current question
    func getAnswers() -> [String] {
        return (quiz.questions[indexOfSelectedQuestion].answerOptions)
    }
    
    /// Returns the end of quiz result text for the current game
    func getResultText() -> String {
        let score = Int ((Double(correctQuestions) / Double(questionsPerRound)) * 100) // Passing is 70%
        var result: String
        if score > 70
        {
            result = """
            You passed!
            Your score is \(score)%
            You got \(correctQuestions) out of \(questionsPerRound) correct!
            \(questionsToReview())
            """
    
        } else {
            result = """
            Keep Praticing!
            Your score is \(score)%
            You got \(correctQuestions) out of \(questionsPerRound) correct.
            
            
            \(questionsToReview())
            """
        }
        return (result)
    }
    
    func questionsToReview() -> String {
        var tempString: String = ""
        if !(questionsWrong.isEmpty){
           tempString = "Here are the generic drug names you should review:\n"
            for question in questionsWrong
            {
                tempString += "\n\(question)"
            }
        }
         return tempString
    }
    
    /// Returns a string: Checks the answer by comparing the buttons current displayed text to the quiz objects correct answer string
    func checkAnswer(buttonText: String) -> String {
        var correctStatus: Bool
        questionsAsked += 1
        let correctOption = quiz.questions[indexOfSelectedQuestion].correctAnswer // finds the int that represents the index of the correct string
        let correctAnswer = getAnswers()[correctOption] // the string of the correct answer
       
        if (buttonText.contains(correctAnswer)) { // if the buttons text and the correct answer match its correct
            correctSound.play(idNumber: correctSound.idNumber)
            correctQuestions += 1
            correctStatus = true
        } else{
            questionsWrong.append(buttonText)
            wrongSound.play(idNumber: wrongSound.idNumber)
            correctStatus = false
        }
        return (correctStatus ? "Correct" : "Wrong Answer" ) // Returns correct if true and wrong if false
    }
    
    /// Resets the variables used in the quiz - Helper method to the playAgain() method in ViewController 
    func playAgain(){
        questionsAsked = 0
        correctQuestions = 0
        startSound.play(idNumber: startSound.idNumber)
        indexOfUsedQuestions.removeAll()
        questionsWrong.removeAll()
    }
}
