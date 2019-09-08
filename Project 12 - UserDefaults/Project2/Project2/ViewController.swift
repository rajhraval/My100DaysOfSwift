//
//  ViewController.swift
//  Project2
//
//  Created by RAJ RAVAL on 09/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))
        
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: "highScore")
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = (countries[correctAnswer].uppercased())
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title:String
        var message: String
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct Answer!"
            message = "Your Score is \(score)"
            if score > highScore {
                save()
                highScore = score
                message = "New High Score!"
            }
        } else {
            score -= 1
            title = "Wrong!"
            message = "This is the flag of \(countries[sender.tag].uppercased())"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current Score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
    }
    
}

