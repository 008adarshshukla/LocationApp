//
//  ViewController.swift
//  LocationApp
//
//  Created by Adarsh Shukla on 22/04/23.
//

import MapKit
import CoreLocation
import UIKit

class ViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(map)
        title = "Home"
        
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.addMapPin(with: location)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)),
            animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
}

