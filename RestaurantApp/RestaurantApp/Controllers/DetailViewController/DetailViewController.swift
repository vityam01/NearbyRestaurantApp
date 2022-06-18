//
//  DetailViewController.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController {
    
    //MARK: IBOutelts
    @IBOutlet weak private var placesImage: UIImageView!
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var categoriesNameLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var timezoneLabel: UILabel!
    
    
    var viewModel: DetailViewControllerModel?
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

       initUI()
    }
    
//MARK: Private methods
    private func initUI() {
        setPlaceMark()
        placesImage.layer.cornerRadius = viewModel?.cornerRadiusForImage() ?? 0
        setDataForElements()
    }
    
    func setDataForElements() {
        guard let viewModel = viewModel else { return }
        self.navigationItem.title = viewModel.place.name
        categoriesNameLabel.text = viewModel.place.categories?.first?.name
        addressLabel.text = viewModel.place.location?.address
        timezoneLabel.text = viewModel.place.timezone
        placesImage.loadImgFromUrl(urlString: viewModel.imageURL())
    }
    

    func setPlaceMark() {
        guard let viewModel = viewModel else { return }
        let place = viewModel.place
        let initialLocation = CLLocation(latitude: place.geocodes?.main?.latitude ?? 0, longitude: place.geocodes?.main?.longitude ?? 0)
        mapView.centerLocation(initialLocation)

        let cameraCenter = CLLocation(latitude: place.geocodes?.main?.latitude ?? 0 , longitude: place.geocodes?.main?.longitude ?? 0)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate,
                                        latitudinalMeters: 50000,
                                        longitudinalMeters: 50000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)

        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        let mark = PlaceMark(title: place.name, location: place.location?.address, descriptionLinae: place.categories?.first?.name, coordinate: CLLocationCoordinate2D(latitude: place.geocodes?.main?.latitude ?? 0, longitude: place.geocodes?.main?.longitude ?? 0))
        mapView.addAnnotation(mark)
    }
 
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
}
