//
//  ViewController.swift
//  Project22
//
//  Created by RAJ RAVAL on 04/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var distanceReadingTwo: UILabel!
    @IBOutlet var circleView: UIView!
    @IBOutlet var circleViewTwo: UIView!
    //    var circleView: UIView!
//    var circleViewTwo: UIView!
    
    var locationManager: CLLocationManager?
    var showAlert = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        circleView.layer.cornerRadius = 128
        circleView.backgroundColor = .gray

        circleViewTwo.layer.cornerRadius = 128
        circleViewTwo.backgroundColor = .gray

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        
        //Create the Same for another Beacon
        
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        let beaconIdentity = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconIdentity)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.distanceReading.text = "Far"
                self.circleView.backgroundColor = .blue
                self.circleViewTwo.backgroundColor = .blue
                self.circleView.transform = CGAffineTransform(scaleX: 0.25, y: 1)
                self.circleViewTwo.transform = CGAffineTransform(scaleX: 0.25, y: 1)
            case .near:
                self.distanceReading.text = "Near"
                self.circleView.backgroundColor = .orange
                self.circleViewTwo.backgroundColor = .orange
                self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 1)
                self.circleViewTwo.transform = CGAffineTransform(scaleX: 0.5, y: 1)
            case .immediate:
                self.distanceReading.text = "Right Here"
                self.circleView.backgroundColor = .red
                self.circleViewTwo.backgroundColor = .red
                self.circleView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.circleViewTwo.transform = CGAffineTransform(scaleX: 1, y: 1)
            default:
                self.distanceReading.text = "Unkown"
                self.circleView.transform = CGAffineTransform(scaleX: 0.0001, y: 1)
                self.circleViewTwo.transform = CGAffineTransform(scaleX: 0.0001, y: 1)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if showAlert {
                let ac = UIAlertController(title: "Beacon Detected", message: "You have detected an iBeacon", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            showAlert = false
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
}

