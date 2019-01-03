//  ViewController.swift
//  EnhanceQuizStarter - Brand to Generic Quiz
//  Created by Pasan Premaratne on 3/12/18.
//  Updated by Andrea S Santos 1/2/19
//  Copyright © 2018 Treehouse. All rights reserved.
import UIKit
import Foundation
class ViewController: UIViewController {
    
    var quizManager = QuizManager()
    
    // MARK: - Outlets
    // StackViews
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var threeQuestionStack: UIStackView!
    @IBOutlet weak var fourthQuestionStack: UIStackView!
    // Text Fields
    @IBOutlet weak var timerTextField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var resultTextField: UILabel!
    // Buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        quizManager.loadSounds()
        displayQuestion()
    }
   
    // Methods for displaying content
    func displayQuestion() {
        //starts the timer
        if timerIsRunning == false {
        startTimer()
        }
        playAgainButton.isHidden = true
        nextQuestionButton.isHidden = true
        resultTextField.isHidden = true
        questionField.text = quizManager.getQuestionText()
        displayAnswers()
    }
    
    func displayAnswers() {
        var answers = quizManager.getAnswers()
        answers.shuffle() // Shuffle the array to place answers on random buttons.
        let amountOfAnswerOptions = answers.count
        //show 3 options
        //threeQuestionStack.isHidden = false
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        //only load the forth option if the array has 4 options
        if amountOfAnswerOptions == 3 {
            fourthQuestionStack.isHidden = true
        } else {
            fourthQuestionStack.isHidden = false
            button4.setTitle(answers[3], for: .normal)
        }
    }
    
    func displayScore() {
        //Hides stacks & buttons & result text - Hides all 4 question options becasue they are nested
        topStackView.isHidden = true
        nextQuestionButton.isHidden = true
        resultTextField.isHidden = true
        playAgainButton.isHidden = false
        //Displays the end of game results
        questionField.text = quizManager.getResultText()
    }
    
    //Methods for buttons
    func getButtonsArray() -> [UIButton] {
        let buttonsArray = [button1,button2,button3,button4]
        return buttonsArray as! [UIButton]
    }
    
    /// Displays the correct answer, appends to the questions wrong array, plays the wrong answer selected sound.
    func invalidSelection(){
        quizManager.checkAnswerSounds(correctStatus: false)
        let answer = quizManager.getCorrectAnswer()
        let buttons = getButtonsArray()
        for button in buttons {
            guard let buttonText = button.currentTitle else {return}
            if buttonText.contains(answer){
                button.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
            }
        }
    }
    
    func resetButtonColors(){
        let buttons = getButtonsArray()
        for button in buttons{
            button.backgroundColor = UIColor(red: 83/225.0, green: 116/225.0, blue: 251/255.0, alpha: 1.0)
        }
    }

    func changeButtonStatus(buttonStatus: Bool){
        let buttons = getButtonsArray()
        for button in buttons{
            button.isEnabled = buttonStatus
        }
    }
    
    //Loading
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
    
    func nextRound() {
        quizManager.questionsAsked += 1 
        resultTextField.isHidden = true

        if quizManager.questionsAsked >= quizManager.questionsPerRound {
            // Ends the game
            displayScore()
        } else {
            // Makes buttons useable again
            changeButtonStatus(buttonStatus: true)
            resetButtonColors()
            displayQuestion()
        }
    }

    // Timer Methods
    // Timer Variables
    var timeLeft = 15 // Lightning rounds starts with 15 seconds
    var timer = Timer()
    var timerIsRunning = false
    
    func startTimer(){
        timerTextField.isHidden = false
        timerIsRunning = true
        timerTextField.text = nil
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        //stop the timer from becomming negative
        if timeLeft < 1 { // cant put == 0 because if it glitches to -1 it will keep going.
            timer.invalidate()
            invalidSelection()
            resetTimer()
            nextQuestionButton.isHidden = false
        } else {
            timeLeft -= 1
            timerTextField.text = "You have \(timeLeft) second left!"
        }
    }
    
    func resetTimer(){
        timer.invalidate()
        timeLeft = 15
        timerTextField.isHidden = true
        timerIsRunning = false
    }
    
    
    //MARK - Actions
    @IBAction func checkAnswer(_ sender: UIButton) {
    //after a button is clicked make butons unusable
    changeButtonStatus(buttonStatus: false)
    resetTimer()
    //check if the answer is correct
    let correctAnswer = quizManager.getCorrectAnswer()
    guard let sendersText = sender.currentTitle else {return}
    if sendersText.contains(correctAnswer){
        quizManager.checkAnswerSounds(correctStatus: true)
        resultTextField.text = "Correct"
        resultTextField.textColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        sender.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
    } else {
        // If user did not select the correct answer
        resultTextField.text = "Sorry, wrong answer"
        resultTextField.textColor = UIColor.gray
        sender.backgroundColor = UIColor.gray
        invalidSelection()
    }
    // Display button to advance to the next round
    nextQuestionButton.isHidden = false
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        topStackView.isHidden = false
        quizManager.playAgain()
        nextRound() // to keep playing
    }
}

