//
//  ViewController.swift
//  Milestone3
//
//  Created by RAJ RAVAL on 31/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var wordLabel: UILabel!
    var scoreLabel: UILabel!
    var guessLabel: UILabel!
    var letterButtons = [UIButton]()
    var letterAlphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var score = 0
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.text = "????????"
        wordLabel.font = UIFont.systemFont(ofSize: 34)
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont.systemFont(ofSize: 18)
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        guessLabel = UILabel()
        guessLabel.translatesAutoresizingMaskIntoConstraints = false
        guessLabel.text = "Guesses: 0/7"
        guessLabel.font = UIFont.systemFont(ofSize: 18)
        guessLabel.textAlignment = .left
        view.addSubview(guessLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        buttonsView.layer.borderWidth = 1
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            
            guessLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            guessLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonsView.heightAnchor.constraint(equalToConstant: 350),
            buttonsView.widthAnchor.constraint(equalToConstant: 375),
            buttonsView.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
        
        let height = 80
        let width = 40
        
        for row in 0..<4 {
            for column in 0..<5 {
                let alphabetButton = UIButton(type: .system)
                alphabetButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                for i in letterAlphabets {
                    alphabetButton.setTitle(i, for: .normal)
                }
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                alphabetButton.frame = frame
                
                buttonsView.addSubview(alphabetButton)
                letterButtons.append(alphabetButton)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

