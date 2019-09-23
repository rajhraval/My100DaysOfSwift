//
//  ViewController.swift
//  Project18
//
//  Created by RAJ RAVAL on 23/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // For Print Statement Explanation
        print(1, 2, 3, 4, 5, separator: "-")
        
        // For Assert Condition Explanation
        assert(1 == 1, "Math Failure!")
        //assert(1 == 2, "Math Failure") - It will Crash
        
        // For Break Point Explanation
        for i in 1...100 {
            print("Got number \(i)")
        }
    }


}

