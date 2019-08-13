//
//  ViewController.swift
//  Milestone1
//
//  Created by RAJ RAVAL on 13/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                flags.append(item)
            }
        }
        print(flags)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        let imageString = flags[indexPath.row]
        cell.imageView?.image = UIImage(named: imageString)
        cell.textLabel?.text = flags[indexPath.row].replacingOccurrences(of: "@3x.png", with: "").uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

