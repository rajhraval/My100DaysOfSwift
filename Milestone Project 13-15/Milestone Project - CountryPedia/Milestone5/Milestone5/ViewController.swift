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
        //loadCountries()
        let countryItems = Bundle.main.decode(Countries.self, from: "countries.json")
        countries = countryItems.results
        
    }
    
//    func loadCountries() {
//        if let fileURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
//            if let data = try? Data(contentsOf: fileURL) {
//                parseJSON(json: data)
//            } else {
//                print("Data not loaded")
//                print("Some problem I suppose")
//            }
//        }
//    }
//
//    func parseJSON(json: Data) {
//        let jsonDecoder = JSONDecoder()
//        if let jsonCountries = try? jsonDecoder.decode(Countries.self, from: json) {
//            countries = jsonCountries.results
//            print(countries)
//            tableView.reloadData()
//        }
//    }
    
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
        let country = countries[indexPath.row]
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
                vc.countryItem = country
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // Fallback on earlier versions
            print("Version Error")
        }
    }
    
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found from - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be an invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
        
    }
}
