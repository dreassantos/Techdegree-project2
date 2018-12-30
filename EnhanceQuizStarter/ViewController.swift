//  ViewController.swift
//  EnhanceQuizStarter - Brand to Generic Quiz
//  Created by Pasan Premaratne on 3/12/18.
//  Updated by Andrea S Santos 12/29/2018
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
        quizManager.loadSounds()
        displayQuestion()
    }
    
    func displayQuestion() {
        questionField.text = quizManager.getQuestionText() 
        playAgainButton.isHidden = true
        displayAnswers()
    }
    
    func displayAnswers() {
        var answers = quizManager.getAnswers()
        answers.shuffle() // Shuffle the array to place answers on random buttons.
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
    }
    
    func displayScore() {
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        playAgainButton.isHidden = false
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
        if quizManager.questionsAsked >= quizManager.questionsPerRound { // Ends the game
            displayScore()
        } else {
            displayQuestion() // Keep playing
        }
    }
    
    // MARK: - Button Actions
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Saves the string of the buttons title - if there is one
        guard let buttonText = sender.currentTitle else {return}
        // sends the button tile to be checked by the manager
        questionField.text = quizManager.checkAnswer(buttonText: buttonText)
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        quizManager.playAgain()
        nextRound() // to keep playing
    }
}
