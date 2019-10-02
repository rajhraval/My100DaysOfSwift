//
//  ViewController.swift
//  Project2
//
//  Created by RAJ RAVAL on 09/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))
        
        remind()
        
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
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { finished in
            sender.transform = .identity
            self.checkAnswer(answer: sender.tag)
        }
        
    }
    
    func checkAnswer(answer: Int) {
        var title:String
        
        if answer == correctAnswer {
            title = "Correct"
            score += 1
            totalAnswer += 1
            if totalAnswer == 10 {
                let bc = UIAlertController(title: "Final Score : \(score)", message: "Do you want to replay?", preferredStyle: .alert)
                bc.addAction(UIAlertAction(title: "Replay", style: .default, handler: askQuestion))
                present(bc, animated: true)
                score = 0
                totalAnswer = 0
            } else {
                let ac = UIAlertController(title: title, message: "Your Score is \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            }
        } else {
            title = "Wrong"
            score -= 1
            totalAnswer += 1
            let rc = UIAlertController(title: title, message: "It is flag of \(countries[answer].uppercased())", preferredStyle: .alert)
            rc.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(rc, animated: true)
        }
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current Score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func remind() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                self.callNotification()
            } else {
                print("Notifications Failed")
            }
        }
    }
    
    func callNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.delegate = self
        
        let playGame = UNNotificationAction(identifier: "playGame", title: "Play the game!", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "game", actions: [playGame], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "Let's Crack It!"
        content.body = "Can you beat your own high score?"
        content.categoryIdentifier = "game"
        content.sound = .default
        
        let timeInterval = 86400
        
        for i in 1...7 {
    
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval * i), repeats: true)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
            
            print("I triggered notification")
        }
        
        center.setNotificationCategories([category])
        
    }
    
}

