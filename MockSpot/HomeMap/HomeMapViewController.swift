//
//  HomeViewController.swift
//  MockSpot
//
//  Created by Nick John on 1/11/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase
import Firebase



class HomeMapViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddMockSpotDelegate, MKMapViewDelegate {
    
    let blueColor = UIColor.init(displayP3Red: 109/255, green: 142/255, blue: 165/255, alpha: 255/255)
    
    let map = MKMapView()
    let region = CLLocationDistance(exactly: 1000)
    let locationManager = CLLocationManager()
    var mockPins: [MockSpotPin] = [MockSpotPin]()
    let takePicVC = TakeMockPictureViewController()
    var ref = Database.database().reference()
    var number = 0
    var mockCollectView: UICollectionView?
    var initialConstraint: NSLayoutConstraint?
    var animatedConstraing: NSLayoutConstraint?
    let mainContainer = UIView()
    
    
    
    let collectionContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    let imageArray: [UIImage] = [UIImage(named: "Mock1")!, UIImage(named: "Mock2")!, UIImage(named: "Mock3")!, UIImage(named: "Mock4")!]
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "mockPin")
//        annView?.image = UIImage(named: "MockSpotPoint")
//    }
//

    
    
    // MARK: - UI Elements
    let addMockSpotButton:UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleTakeMockPicture))
        button.tintColor = UIColor.white
        button.isEnabled = true

//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(white: 0, alpha: 0.15)
//        button.addTarget(self, action: #selector(handleTakeMockPicture), for: .touchUpInside)
//        button.titleLabel?.numberOfLines = 0
//        button.setTitle("Add Spot", for: .normal)
//        button.titleLabel?.textColor = .white
//        button.layer.cornerRadius = 40
        
        return button
    }()
    
    fileprivate func layoutBottomBar() {
        let bottomBar = UIStackView()
        view.addSubview(bottomBar)
        bottomBar.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 50, width: 0)
        
        let leftBarMapButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "map")!, for: .normal)
            button.addTarget(self, action: #selector(handleMapButton), for: .touchUpInside)
            button.backgroundColor = UIColor.white
            return button
        }()
        
        let rightBarFeedButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "feed")!, for: .normal)
            button.addTarget(self, action: #selector(handleFeedButton), for: .touchUpInside)
            button.backgroundColor = UIColor.white
            return button
        }()
        
        bottomBar.addArrangedSubview(leftBarMapButton)
        bottomBar.addArrangedSubview(rightBarFeedButton)
        bottomBar.axis = .horizontal
        bottomBar.distribution = .fillEqually
        bottomBar.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    navigationController?.isNavigationBarHidden = false
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false

        navigationItem.hidesBackButton = false
        layoutBottomBar()
        
        
        
    }
    
    @objc func handleMapButton() {
        if collectionContainer.superview == mainContainer {
            collectionContainer.removeFromSuperview()
            mainContainer.addSubview(map)
            map.anchor(top: mainContainer.topAnchor, left: mainContainer.leftAnchor, right: mainContainer.rightAnchor, bottom: mainContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 0, width: 0)
        }
        
        
    }
    
    @objc func handleFeedButton() {
        if map.superview == mainContainer {
        map.removeFromSuperview()
        mainContainer.addSubview(collectionContainer)
            collectionContainer.anchor(top: mainContainer.topAnchor, left: mainContainer.leftAnchor, right: mainContainer.rightAnchor, bottom: mainContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 0, width: 0)}
        
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
       
        takePicVC.delegate = self
        map.delegate = self
      
        retrieveMockSpotsFromDatabase()
        initializeCollectionView()
        mockCollectView?.allowsSelection = false
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        if let center = locationManager.location?.coordinate {
            map.region = MKCoordinateRegion(center: center, latitudinalMeters: region ?? 1000, longitudinalMeters: region ?? 1000)}
    }
    
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationItem.hidesBackButton = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let menuButton = UIButton(type: .system)
        let profileButton = UIButton(type: .system)
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
        menuButton.setImage(UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.setImage(UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.title = "MOCKSPOT"
        
    }
    
    @objc func handleMenuButton() {
        let menuView = MenuViewController()
        menuView.modalPresentationStyle = .overFullScreen
        present(menuView, animated: true, completion: nil)
        
        
    }
    @objc func handleProfileButton() {
        let profileVC = ProfileViewController()
        present(profileVC, animated: true, completion: nil)
        
    }
    
    @objc fileprivate func handleTakeMockPicture() {
//        let takeMockPicController = TakeMockPictureViewController()
        present(takePicVC, animated: true, completion: nil)
//        takeMockPicController.delegate = self
        
    }
    
    func configureUI() {
//        map.addSubview(addMockSpotButton)
//        navigationController?.navigationItem.rightBarButtonItem = addMockSpotButton
        map.showsUserLocation = true
        view.addSubview(mainContainer)
        mainContainer.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        mainContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -50, height: 0, width: 0)
        map.anchor(top: mainContainer.topAnchor, left: mainContainer.leftAnchor, right: mainContainer.rightAnchor, bottom: mainContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 0, width: 0)
 
//        NSLayoutConstraint.activate([addMockSpotButton.topAnchor.constraint(equalTo: map.topAnchor, constant: 40), addMockSpotButton.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 30), addMockSpotButton.heightAnchor.constraint(equalToConstant: 80), addMockSpotButton.widthAnchor.constraint(equalToConstant: 80)])
    }
    
    func addedMockSpot(title: String, locationName: String, coordinate: CLLocationCoordinate2D, imageURL: String) {
        print("addedMockSpot")
        
        let starReviews = [3,4,3,2,4,1,3,2]
        let c1 = Comment(user: "userID", commentBody: "This spot was awesome!", time: Date(timeIntervalSinceReferenceDate: 100000000000), didNavTo: true)
        let c2 = Comment(user: "userID", commentBody: "This spot was awesome2!", time: Date(timeIntervalSinceReferenceDate: 1000000000003), didNavTo: true)
        let c3 = Comment(user: "userID", commentBody: "This spot was awesome3!", time: Date(timeIntervalSinceReferenceDate: 1000000000004), didNavTo: true)
        let cArray = [c1,c2,c3]
        let spot = MockSpotPin(coordinate: coordinate, city: "San Diego", title: title, locationName: locationName, coverImageURL: imageURL, pinImage: UIImage(named: "MockSpotPoint")!, starReviews: starReviews, comments: cArray)
        let spotRegion = MKCoordinateRegion.init(center: spot.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(spotRegion, animated: true)
        ref.child("MockSpots").childByAutoId().updateChildValues(["latitude" : coordinate.latitude, "longitude": coordinate.longitude, "title": title, "locationName": locationName, "imageURL": imageURL])
        mockPins.append(spot)
        map.addAnnotations(mockPins)
        mockCollectView?.reloadData()
        number += 1
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("viewForAnnotation")
      
        var anno = mapView.dequeueReusableAnnotationView(withIdentifier: "view")
        if anno == nil {
            anno = MKAnnotationView(annotation: annotation, reuseIdentifier: "view")
        } else {
            anno?.annotation = annotation
        }
        anno?.canShowCallout = true
        let vw = UIView()
        vw.backgroundColor = UIColor.blue
        anno?.leftCalloutAccessoryView = vw
        
        
        if let image = UIImage(named: "MockSpotPoint") {
            if anno != nil {
                
                anno?.image = image
            } else {
                print("anno is nil")
            }
        } else {
            print("Image is nil")
        }
        return anno
    }
    

    func getLocation() {
        let locationAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.desiredAccuracy = locationAccuracy
        locationManager.startUpdatingLocation()
    }
    

    
}
