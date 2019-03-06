//
//  ViewController.swift
//  MockSpot
//
//  Created by Nick John on 1/8/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit
import AVKit
import CoreLocation
import Firebase
import APESuperHUD
import CoreFoundation



protocol AddMockSpotDelegate {
    func addedMockSpot(title: String, locationName: String, coordinate: CLLocationCoordinate2D, imageURL: String)
}

class TakeMockPictureViewController: UIViewController, AVCapturePhotoCaptureDelegate, CLLocationManagerDelegate {
    
    var delegate:AddMockSpotDelegate?
 
    let locationManager = CLLocationManager()
    
    let refMockImages = Storage.storage().reference().child("MockImages")
    
    let imageView = UIImageView()
    
    let output = AVCapturePhotoOutput()
    
    var number = 1
    
    var titleForSpot: String? = "DefaultTitle"
    
    var locationName: String? = "default location Name"
    
    var location: CLLocationCoordinate2D?
    
    var mockImageData: Data?
    
    var mockImageURL: String?
    
    let userDefaults = UserDefaults()
    
    var didTakePicture = false
    

    
    
    // MARK: - UI Objects
    let captureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleCameraCapture), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go Back", for:.normal)
        button.backgroundColor = UIColor(white: 0, alpha: 0.15)
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setUIConstraints() {
        view.addSubview(captureButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: view.topAnchor), backButton.rightAnchor.constraint(equalTo: view.rightAnchor), backButton.heightAnchor.constraint(equalToConstant: 80), backButton.widthAnchor.constraint(equalToConstant: 80)])
    }
    
    // MARK: - UI Target Handlers
    @objc func handleCameraCapture() {
        didTakePicture = true
        
        locationManager.requestLocation()
        
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
        
        
        
    }
    
    @objc func handleBackButton() {
        let hudStyle = HUDStyle.loadingIndicator(type: .standard)

        imageView.image = nil
        
        var locCity = "DefaultCityName"
        
        if didTakePicture == false {
            self.dismiss(animated: true, completion: nil)
        } else {
        didTakePicture = true
        if let loc = location, let mockData = mockImageData {
            APESuperHUD.show(style: hudStyle, title: "", message: "Adding MockSpot!", completion: nil)

            refMockImages.child("mockImage\(mockData.description)").putData(mockData, metadata: nil) { (metaData, err) in
                if err != nil {
                    print("error storing image, \(err?.localizedDescription)")
                } else {
                    self.number+=1
                    guard let url = metaData?.downloadURL()?.absoluteString else {return}
                    print(url)
                    self.mockImageURL = url
                    CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: loc.latitude, longitude: loc.longitude)) { (placemarks, err) in
                        if err != nil {
                            print("Error geocoding city, \(err?.localizedDescription)")
                        } else {
                            guard let place = placemarks?.last else {return}
                            locCity = place.locality!
                            self.delegate?.addedMockSpot(title: "title", locationName: "San Diego", coordinate: loc, imageURL: self.mockImageURL!)
                            
                            APESuperHUD.dismissAll(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            
//                            let addMockView = AddMockSpotView()
//                            addMockView.imageURL = self.mockImageURL!
//                            
                            
//                            APESuperHUD.dismissAll(animated: true)
                            }}
//                    self.dismiss(animated: true, completion: nil)
                }}
//            self.dismiss(animated: true, completion: nil)
//            let addMockSpotVC = AddMockSpotView()
//            present(addMockSpotVC, animated: true, completion: nil)
        } else {print("something is NIL")}} }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 100.00
        
        configureCaptureSession()
        
        setUIConstraints()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let loc = locationManager.location {
            self.location = loc.coordinate
        } else {
            print("no location data in didUpdateLocations")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("did fail \(error)")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        didTakePicture = true
        guard let imageData = photo.fileDataRepresentation() else {return}
        mockImageData = imageData
        
        let image = UIImage(data: imageData)
        
        let previewContainer = PreviewViewContainer()
        previewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(previewContainer)
        
        NSLayoutConstraint.activate([previewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), previewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), previewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor), previewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor)])

        previewContainer.imageView.image = image
    
    }
    
    
    fileprivate func configureCaptureSession() {
        
        //1. Define Capture Session
        let captureSession = AVCaptureSession()
        
        //2. Define Inputs
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {print("AVCaptureDevice.default is nil"); return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        }
        catch let err {
            print("Could not setup Camera input:", err)
        }
        
        //3. Define Outputs
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        //4. Create PreviewLayer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        captureSession.startRunning()
    }
    
    



}

