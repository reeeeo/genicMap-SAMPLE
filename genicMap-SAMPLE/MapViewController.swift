//
//  ViewController.swift
//  genicMap-SAMPLE
//
//  Created by okumura reo on 2018/06/08.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Instagram.fetchInstagramData { (instagramData) in
      DispatchQueue.main.async {
        print(instagramData)
      }
    }
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

