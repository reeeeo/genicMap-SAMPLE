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
  private var imagePaths: [String: String] = [:]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    
    locationManager.startUpdatingLocation()
    locationManager.requestWhenInUseAuthorization()
    locationManager.delegate = self
    
    Instagram.fetchInstagramData { (instagramData) in
      DispatchQueue.main.async {
        self.addImageAnnotation(withInstagramData: instagramData)
        self.setCenterLocation(withInstagramData: instagramData)
      }
    }
  }
  
  // InstagramDataの位置情報に画像付きのピンを刺す
  private func addImageAnnotation(withInstagramData instagramData: InstagramData) {
    instagramData.data.forEach { d in
      let pin = MKPointAnnotation()
      pin.coordinate = CLLocationCoordinate2D(
        latitude: (d.location?.latitude)!,
        longitude: (d.location?.longitude)!)
      pin.title = String(d.id)
      self.imagePaths[String(d.id)] = d.image.url
      self.mapView.addAnnotation(pin)
    }
  }
  
  // 緯度経度の平均値に中心にする
  private func setCenterLocation(withInstagramData instagramData: InstagramData) {
    let lats = instagramData.data.map { $0.location?.latitude }
    let lons = instagramData.data.map { $0.location?.longitude }
    let span = MKCoordinateSpanMake(0.1, 0.1)
    let centerPin = MKPointAnnotation()
    centerPin.coordinate = CLLocationCoordinate2DMake(
      calcAverage(lats),
      calcAverage(lons)
    )
    let region = MKCoordinateRegionMake(centerPin.coordinate, span)
    mapView.setRegion(region, animated: true)
  }
  
  // Double型の配列の平均値を算出
  private func calcAverage(_ countableAry: [Double?]) -> Double {
    return (countableAry.reduce(0) { $0! + $1! } / Double(countableAry.count))
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
      annotationView?.canShowCallout = true // 吹き出しの有無
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
