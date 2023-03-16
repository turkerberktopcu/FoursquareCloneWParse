//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 16.03.2023.
//

import UIKit
import MapKit
import Parse


class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var placeToSave: Places?
    var latitude: Double?
    var longitude: Double?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClicked))
        
        mapView.delegate = self
        locationManager.delegate = self

        mapView.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(createAnnotation))
        longPressRecognizer.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(longPressRecognizer)
    
       
    }
    
    
    @objc func saveClicked(){
        if let placeToSave = self.placeToSave {
            let object = PFObject(className: "places")
            object["placeName"] = placeToSave.placeName
            object["placeType"] = placeToSave.placeType
            object["placeDetails"] = placeToSave.placeDetails
            if let imgData = placeToSave.imageData {
                object["imgData"] = PFFileObject(name: "image.jpg", data: imgData)
            }
             if let latitude = self.latitude,
               let longitude = self.longitude {
                object["latitude"] = latitude
                object["longitude"] = longitude
            }
            
            object.saveInBackground { success, error in
                if error != nil {
                    let alert = self.makeAlert(title: "Error !", message: error!.localizedDescription)
                    self.present(alert, animated: true)
                } else {
                    self.performSegue(withIdentifier: "fromMapVCToPlacesVC", sender: nil)
                }
                
            }
        }
    }
    
    
    
    @objc func createAnnotation(gestureRecognizer: UILongPressGestureRecognizer){
        
        let touchedPoint = gestureRecognizer.location(in: self.mapView)
        let touchedCoordinate = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
        self.latitude = touchedCoordinate.latitude
        self.longitude = touchedCoordinate.longitude
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchedCoordinate
        
        
        self.mapView.addAnnotation(annotation)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }

}
