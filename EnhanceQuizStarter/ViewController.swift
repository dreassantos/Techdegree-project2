//  ViewController.swift
//  EnhanceQuizStarter
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    //let quizSound = QuizSounds(soundName: String, soundType: String)
    let quizManager = QuizManager()
    var randomQuizObject: QuestionProvider = QuestionProvider(question: " ", answerOptions: [""], correctAnswer: 0)

//    init(question:String, answerOptions:[String], correctAnswer: Int){
//        self.randomQuizObject = QuestionProvider(question:question, answerOptions: answerOptions, correctAnswer: correctAnswer)
//    }


    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        QuizSounds(soundName: "GameSound" , soundType: "wav").play()
        displayQuestion()
    }
    
    // MARK: - Helpers
    func displayScore() {
        // Hide the answer buttons
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
    
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked >= questionsPerRound {// this was == which created a bug. if you click 5 times the game never ends. 
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    // MARK: - Actions
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        QuizSounds(soundName: "GameSound" , soundType: "wav").play()
        nextRound()
    }
    
    //Places the questions into the quiz
    func displayQuestion() {
        randomQuizObject = quizManager.randomQuestion()
        questionField.text = "What is the generic name for \(randomQuizObject.question)"
        playAgainButton.isHidden = true
        displayAnswers(answers: randomQuizObject.answerOptions)
    }
    
    func displayAnswers(answers: [String]){
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = randomQuizObject.correctAnswer
        if((sender.currentTitle?.elementsEqual(randomQuizObject.answerOptions[correctAnswer]))!){
            correctQuestions += 1
            questionField.text = "Correct!"
                    QuizSounds(soundName: "correct" , soundType: "wav").play()
        } else {
            questionField.text = "Sorry, wrong answer!"
                    QuizSounds(soundName: "wrong" , soundType: "wav").play()
        }
        loadNextRound(delay: 2)
    }
}

