import GameKit

struct QuizManager {
    func randomQuestion()-> QuestionProvider {
        let indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: Quiz().questions.count)
        let randomQuestionObject = Quiz().questions[indexOfSelectedQuestion]
        return randomQuestionObject
    }
}


