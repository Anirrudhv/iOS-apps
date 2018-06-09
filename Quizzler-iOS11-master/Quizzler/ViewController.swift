//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedanswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstquestion = allQuestions.list[0]
        questionLabel.text = firstquestion.question
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1
        {
            pickedanswer = true
        }
        else {
            pickedanswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        

    }
    
    
    func updateUI() {
      scoreLabel.text = "Your score is \(score)"
       progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {
        if questionNumber < 13{
        questionLabel.text = allQuestions.list[questionNumber].question
            updateUI()
    }
        else
        {
            let alert = UIAlertController(title: "Isnt it awesome you guys", message: "You finished", preferredStyle: .alert)
            let restartaction = UIAlertAction(title: "Restart", style: .default, handler:{ (UIAlertAction) in
                self.startOver()})
            alert.addAction(restartaction)
            present(alert, animated: true,completion: nil)
        }
    }
    
    func checkAnswer() {
        let correctanswer = allQuestions.list[questionNumber].answer
        
        if correctanswer == pickedanswer
        {
            ProgressHUD.showSuccess("You got it")
            score += 1
            
        }
        else{
            ProgressHUD.showError("Oops")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
       
    }
    

    
}
