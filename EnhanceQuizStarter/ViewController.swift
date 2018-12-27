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
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
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
