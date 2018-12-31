//  ViewController.swift
//  EnhanceQuizStarter - Brand to Generic Quiz
//  Created by Pasan Premaratne on 3/12/18.
//  Updated by Andrea S Santos 12/29/2018
//  Copyright © 2018 Treehouse. All rights reserved.
import UIKit

class ViewController: UIViewController {
    
    var quizManager = QuizManager()
    
    // MARK: - Outlets
    // StackViews
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var threeQuestionStack: UIStackView!
    @IBOutlet weak var fourthQuestionStack: UIStackView!
    // Text Fields
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

    func displayQuestion() {
        questionField.text = quizManager.getQuestionText()
        playAgainButton.isHidden = true
        nextQuestionButton.isHidden = true
        resultTextField.isHidden = true
        displayAnswers()
    }
    
    func displayAnswers() {
        var answers = quizManager.getAnswers()
        answers.shuffle() // Shuffle the array to place answers on random buttons.
        let amountOfAnswerOptions = answers.count
        threeQuestionStack.isHidden = false
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
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
        resultTextField.isHidden = true
        if quizManager.questionsAsked >= quizManager.questionsPerRound {
            // Ends the game
            displayScore()
        } else {
            // Makes buttons useable again
            button1.isEnabled = true
            button2.isEnabled = true
            button3.isEnabled = true
            button4.isEnabled = true
            resetButtonColors()
            displayQuestion()
        }
    }
    
    func resetButtonColors(){
        button1.backgroundColor = UIColor(red: 83/225.0, green: 116/225.0, blue: 251/255.0, alpha: 1.0)
        button2.backgroundColor = UIColor(red: 83/225.0, green: 116/225.0, blue: 251/255.0, alpha: 1.0)
        button3.backgroundColor = UIColor(red: 83/225.0, green: 116/225.0, blue: 251/255.0, alpha: 1.0)
        button4.backgroundColor = UIColor(red: 83/225.0, green: 116/225.0, blue: 251/255.0, alpha: 1.0)
    }
    
    //MARK - Actions
     @IBAction func checkAnswer(_ sender: UIButton) {
        //after a button is clicked make butons unusable
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        //get the correct answer
        let correctAnswer = quizManager.getCorrectAnswer()
        guard let sendersText = sender.currentTitle else {return}
        if sendersText.contains(correctAnswer){
            quizManager.checkAnswerSounds(correctStatus: true)
            resultTextField.text = "Correct"
            resultTextField.textColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
            sender.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        } else {
            // If user did not select the correct answer
            quizManager.checkAnswerSounds(correctStatus: false)
            resultTextField.text = "Sorry, wrong answer"
            resultTextField.textColor = UIColor.gray
            sender.backgroundColor = UIColor.gray
            //find the button with the correct answer
                let buttons = [button1,button2,button3,button4]
                for button in buttons{
                    guard let buttonText = button?.currentTitle else {return} //buttonText to the current Text
                    if buttonText.contains(correctAnswer)
                    {
                        button!.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
                    }
                }
        }
        // After checking for result make buttons unclickable
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
        // Display button to advance to the next round
        nextQuestionButton.isHidden = false
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        loadNextRound(delay: 1)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        topStackView.isHidden = false
        quizManager.playAgain()
        nextRound() // to keep playing
    }
}
