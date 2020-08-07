//
//  MyAddressVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class MyAddressVC: BaseViewController {
    static func instance () -> MyAddressVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MyAddressVC") as! MyAddressVC
    }
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var details: UITextField!
    
    var myLocationPresnter: MyLocationPresnter!
    var lat:Double?
    var long:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationPresnter = MyLocationPresnter(Home: self)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    
    @IBAction func BackToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func DoneButton(_ sender: Any) {
        let param = ["name":Name.text ?? "",
                     "city":City.text ?? "",
                     "region":region.text ?? "",
                     "details":details.text ?? "",
                     "notes": "no notes",
                     "latitude":lat ?? 1,
                     "longitude":long ?? 1] as [String : Any]
        print(param)
        myLocationPresnter = MyLocationPresnter(Home: self)
        myLocationPresnter.MyLoction(param: param)
        
    }
    
}
extension MyAddressVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue:CLLocationCoordinate2D = manager.location?.coordinate else {return}
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        
    }
}
extension MyAddressVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        dismiss(animated: true, completion: nil)
        
        self.mapView.clear()
        
        
        let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))
        
        let marker = GMSMarker()
        marker.position =  cord2D
        marker.title = "Location"
        marker.snippet = place.name
        
        let markerImage = UIImage(named: "icon_offer_pickup")!
        let markerView = UIImageView(image: markerImage)
        marker.iconView = markerView
        marker.map = self.mapView
        
        self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
    
    
    
}
extension MyAddressVC:MyLocationToDo{
    
    
    func showHud() {
        showLoading()
    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        
        HideLoading()
        
    }
    
    func showError(error: String) {
        print(error)
        HideLoading()
        
    }
}
