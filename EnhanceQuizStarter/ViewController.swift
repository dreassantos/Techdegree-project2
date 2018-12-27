//  ViewController.swift
//  EnhanceQuizStarter
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var quizManager = QuizManager()

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
    
    func displayQuestion() {
        print("getting Question")
        questionField.text = quizManager.setQuestionText()
        print(questionField.text ?? String())
        playAgainButton.isHidden = true
        displayAnswers()
    }
    
    func displayAnswers(){
        let answers = quizManager.getAnswers()
         print("setting Answers")
        button1?.setTitle(answers[0], for: .normal)
        button2?.setTitle(answers[1], for: .normal)
        button3?.setTitle(answers[2], for: .normal)
        button4?.setTitle(answers[3], for: .normal)
    }
    
    func displayScore() {
        print("displaying score")
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        playAgainButton.isHidden = false
        questionField.text = quizManager.setResultText()
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else {return}
        questionField.text = quizManager.checkAnswer(buttonText: buttonText)
        quizManager.loadNextRound(delay: 2)
    }

    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        quizManager.playAgain()
    }
}




/*

 //
 //  ViewController.swift
 //  EnhanceQuizStarter
 //
 //  Created by Pasan Premaratne on 3/12/18.
 //  Copyright © 2018 Treehouse. All rights reserved.
 //
 
 import UIKit
 import GameKit
 import AudioToolbox
 
 class ViewController: UIViewController {
 
 // MARK: - Properties
 
 let questionsPerRound = 4
 var questionsAsked = 0
 var correctQuestions = 0
 var indexOfSelectedQuestion = 0
 
 var gameSound: SystemSoundID = 0
 
 let trivia: [[String : String]] = [
 ["Question": "Only female koalas can whistle", "Answer": "False"],
 ["Question": "Blue whales are technically whales", "Answer": "True"],
 ["Question": "Camels are cannibalistic", "Answer": "False"],
 ["Question": "All ducks are birds", "Answer": "True"]
 ]
 
 // MARK: - Outlets
 
 @IBOutlet weak var questionField: UILabel!
 @IBOutlet weak var trueButton: UIButton!
 @IBOutlet weak var falseButton: UIButton!
 @IBOutlet weak var playAgainButton: UIButton!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 loadGameStartSound()
 playGameStartSound()
 displayQuestion()
 }
 
 // MARK: - Helpers
 
 func loadGameStartSound() {
 let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
 let soundUrl = URL(fileURLWithPath: path!)
 AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
 }
 
 func playGameStartSound() {
 AudioServicesPlaySystemSound(gameSound)
 }
 
 func displayQuestion() {
 indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
 let questionDictionary = trivia[indexOfSelectedQuestion]
 questionField.text = questionDictionary["Question"]
 playAgainButton.isHidden = true
 }
 
 func displayScore() {
 // Hide the answer uttons
 trueButton.isHidden = true
 falseButton.isHidden = true
 
 // Display play again button
 playAgainButton.isHidden = false
 
 questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
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
 
 @IBAction func checkAnswer(_ sender: UIButton) {
 // Increment the questions asked counter
 questionsAsked += 1
 
 let selectedQuestionDict = trivia[indexOfSelectedQuestion]
 let correctAnswer = selectedQuestionDict["Answer"]
 
 if (sender === trueButton &&  correctAnswer == "True") || (sender === falseButton && correctAnswer == "False") {
 correctQuestions += 1
 questionField.text = "Correct!"
 } else {
 questionField.text = "Sorry, wrong answer!"
 }
 
 loadNextRound(delay: 2)
 }
 
 
 @IBAction func playAgain(_ sender: UIButton) {
 // Show the answer buttons
 trueButton.isHidden = false
 falseButton.isHidden = false
 
 questionsAsked = 0
 correctQuestions = 0
 nextRound()
 }
 }
 */
