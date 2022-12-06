//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        checkLocationServices()
        func checkLocationServices() {
          if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
          } else {
              let alert = UIAlertController(title: "Can we get permission to get you location?", message: "You have not provided permission", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
          }
        }
        func checkLocationAuthorization() {
          switch locationManager.authorizationStatus{
          case .authorizedWhenInUse:
            mapView.showsUserLocation = true
           case .denied:
              let alert = UIAlertController(title: "Can we get permission to get you location?", message: "You have not provided permission", preferredStyle: UIAlertController.Style.alert)
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
          }
        }
    }
}

extension MapViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: (location)")
        }

    }

}
