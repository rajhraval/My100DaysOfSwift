//
//  ViewController.swift
//  Milestone2
//
//  Created by RAJ RAVAL on 22/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addingItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
    }

    @objc func addingItem() {
        let ac = UIAlertController(title: "Add Item", message: "What is on the list?", preferredStyle: .alert)
        ac.addTextField()
        
        let addingAction = UIAlertAction(title: "Add Item", style: .default) {
            [weak self, weak ac] _ in
            guard let itemAdded = ac?.textFields?[0].text else { return }
            self?.addItem(itemAdded)
        }
        ac.addAction(addingAction)
        present(ac, animated: true)
        
    }
    
    @objc func shareList() {
        let list = itemList.joined(separator: "\n")
        let av = UIActivityViewController(activityItems: ["Here are list of items: \n\(list)"], applicationActivities: [])
        av.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(av, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
    
    func addItem(_ myItem: String) {
        itemList.insert(myItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
}

