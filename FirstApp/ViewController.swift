//
//  ViewController.swift
//  FirstApp
//
//  Created by Janice on 2017-10-13.
//  Copyright © 2017 Janice. All rights reserved.
//ocation

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let locationManager = CLLocationManager()
    var imageList : [UIImage]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func btnsend(_ sender: Any) {
        
        let url = URL(string: "http://www.thisismylink.com/postName.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "id=13&name=Jack"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response  \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString  \(responseString)")
        }
        task.resume()
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            
            locationManager.requestLocation()
        }
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {    if let location = locations.first{
            
           print("location:: \(location)")
        imageList.append(UIImage(named:"train2.jpg")!)
        imageList.append(UIImage(named:"train-large.png")!)
        print(imageList.count);
        }
        self.imageView.animationImages=imageList
        self.imageView.animationDuration=2.0
        self.imageView.startAnimating() 
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
