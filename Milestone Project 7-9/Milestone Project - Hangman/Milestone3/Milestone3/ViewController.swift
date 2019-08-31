//
//  ViewController.swift
//  Milestone3
//
//  Created by RAJ RAVAL on 31/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var letterButtons = [UIButton]()
    var hintLabel: UILabel!
    var answerLabel: UILabel!
    var hangmanLabel: UILabel!
    var scoreLabel: UILabel!
    
    var level = 1
    var score = 0

    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        hintLabel = UILabel()
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = "I am the hint, which is going to help you!"
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont.systemFont(ofSize: 48)
        view.addSubview(hintLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.text = "???????"
        answerLabel.textAlignment = .center
        answerLabel.font = UIFont.systemFont(ofSize: 64)
        view.addSubview(answerLabel)
        
        hangmanLabel = UILabel()
        hangmanLabel.translatesAutoresizingMaskIntoConstraints = false
        hangmanLabel.text = "--------"
        hangmanLabel.textAlignment = .center
        hangmanLabel.font = UIFont.systemFont(ofSize: 48)
        view.addSubview(hangmanLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(scoreLabel)
        
        let buttonsView = UILabel()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 100),
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            hintLabel.topAnchor.constraint(equalTo: answerLabel.topAnchor, constant: 300),
            hintLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            hangmanLabel.topAnchor.constraint(equalTo: hintLabel.topAnchor, constant: 100),
            hangmanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: hangmanLabel.topAnchor, constant: 60),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.heightAnchor.constraint(equalToConstant: 100),
            buttonsView.widthAnchor.constraint(equalToConstant: 800),
            buttonsView.topAnchor.constraint(equalTo: submit.topAnchor, constant: 100),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10)
            
            ])
        
        let width = 150
        let height = 80
        
        for row in 0..<9 {
            for column in 0..<1 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 52)
                letterButton.setTitle("W", for: .normal)
                
                let frame = CGRect(x: row * height, y: 160 * column, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.layer.borderWidth = 1
                buttonsView.layer.borderColor = UIColor.gray.cgColor
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                
            }
        }
    }

}

