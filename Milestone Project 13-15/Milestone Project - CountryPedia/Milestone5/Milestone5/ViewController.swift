//
//  ViewController.swift
//  Milestone5
//
//  Created by RAJ RAVAL on 18/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadCountries()
    }
    
    func loadCountries() {
        if let fileURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
            if let data = try? Data(contentsOf: fileURL) {
                parseJSON(json: data)
            } else {
                print("Data not loaded")
                print("Some problem I suppose")
            }
        }
    }
    
    func parseJSON(json: Data) {
        let jsonDecoder = JSONDecoder()
        if let jsonCountries = try? jsonDecoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
            print(countries)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

