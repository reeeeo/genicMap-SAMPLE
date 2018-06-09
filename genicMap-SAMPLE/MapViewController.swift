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
  
  private let locationManager = CLLocationManager()
  private let annotationIdentifier = "AnnotationIdentifier"
  private var imagePaths: [String: String] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    
    let span = MKCoordinateSpanMake(0.1, 0.1)
    let centerPin = MKPointAnnotation()
    
    centerPin.coordinate = CLLocationCoordinate2DMake(35.681167, 139.767052)
    let region = MKCoordinateRegionMake(centerPin.coordinate, span)
    mapView.setRegion(region, animated: true)
    
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
    locationManager.delegate = self
    
    Instagram.fetchInstagramData { (instagramData) in
      DispatchQueue.main.async {
        instagramData.data.forEach { d in
          let pin = MKPointAnnotation()
          print(d)
          pin.coordinate = CLLocationCoordinate2D(
            latitude: (d.location?.latitude)!,
            longitude: (d.location?.longitude)!)
          pin.title = String(d.id)
          self.imagePaths[String(d.id)] = d.image.url
          self.mapView.addAnnotation(pin)
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if !(annotation is MKPointAnnotation) {
      return nil
    }
    let annotationIdentifier = "AnnotationIdentifier"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
      annotationView?.canShowCallout = false // 吹き出しの有無
    } else {
      annotationView!.annotation = annotation
    }
    let pinImage = UIImage(named: imagePaths[annotation.title!!]!)
    annotationView?.image = pinImage
    annotationView?.frame.size = CGSize(width: 30, height: 30)
    return annotationView
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  }
}
