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
    
    
    // MARK: - Button Actions
    @IBAction func checkAnswer(_ sender: UIButton) { //activates when an answer option is clicked
        // Saves the string of the buttons title - if there is one
        guard let buttonText = sender.currentTitle else {return}
        // Sends the button tile to be checked by the manager
        resultTextField.isHidden = false
        resultTextField.text = quizManager.checkAnswer(buttonText: buttonText)
        guard let result = resultTextField.text else {return}
        // Changes the button color based on the result
        if result.contains("Correct") {
            sender.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
            resultTextField.textColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        } else {
            
            resultTextField.textColor = UIColor.gray
            sender.backgroundColor = UIColor.gray
        }
        let correctAnswer = quizManager.getCorrectAnswer()
        let buttons = [button1,button2,button3,button4]
        for button in buttons{
            guard let tempButtonText = button?.currentTitle else {return}
            if tempButtonText.contains(correctAnswer)
            {
                button!.backgroundColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
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
