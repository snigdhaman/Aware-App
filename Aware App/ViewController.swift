 //
//  ViewController.swift
//  Aware App
//
//  Created by Chatterjee, Snigdhaman on 02/01/16.
//  Copyright © 2016 Chatterjee, Snigdhaman. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location : CLLocation = locations[0]
        
        self.latitude.text = String(location.coordinate.latitude)
        self.longitude.text = String(location.coordinate.longitude)
        self.speed.text = String(location.speed) + "  MPH"
        self.course.text = String(location.course)
        self.altitude.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            
            var addressString = ""
            
            if ((error) != nil){
                
                print(error)
                
            } else {
                
                if let subThoroughfare = placemarks?[0].subThoroughfare {
                    
                    addressString = addressString + "\(subThoroughfare)  "
                    
                }
                if let thoroughfare = placemarks?[0].thoroughfare {
                
                    addressString = addressString + "\(thoroughfare)\n"
                    
                }
                if let subAdministrativeArea = placemarks?[0].subAdministrativeArea {
                    
                    addressString = addressString + "\(subAdministrativeArea)  "
                    
                }
                if let administrativeArea = placemarks?[0].administrativeArea {
                    
                    addressString = addressString + "\(administrativeArea)  "
                    
                }
                if let country = placemarks?[0].country {
                    
                    addressString = addressString + "\(country)"
                    
                }
                self.address.text = addressString
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

