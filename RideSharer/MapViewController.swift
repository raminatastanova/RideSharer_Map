//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        
        func checkLocationServices() {
          if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
          }
        }
        func checkLocationAuthorization() {
          switch locationManager.authorizationStatus{
          case .authorizedWhenInUse:
            mapView.showsUserLocation = true
           case .denied:
              let alert = UIAlertController(title: "Denied", message: "You have not provided permission", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
           break
          case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
          case .restricted: // Show an alert letting them know what’s up
           break
          case .authorizedAlways:
           break
          @unknown default:
              break
          }
        }
    }
}

