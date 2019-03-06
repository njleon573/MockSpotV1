//
//  PreeviewViewContainer.swift
//  MockSpot
//
//  Created by Nick John on 1/12/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit
import CoreLocation

//protocol locationCityDelegate {
//    func didRecieveLocationCityName(city: UIImage, location: CLLocationCoordinate2D )
//}

class PreviewViewContainer: UIView {
    
    var image: UIImage?
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(handleRetakeButton), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        if image != nil {
            print("image is not nil")
        } else {
            print("image is nil")
        }
    }
    
    func configureViewComponents() {
        addSubview(imageView)
        NSLayoutConstraint.activate([imageView.leadingAnchor.constraint(equalTo: leadingAnchor), imageView.trailingAnchor.constraint(equalTo: trailingAnchor), imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor), imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)])
        
        addSubview(saveButton)
        NSLayoutConstraint.activate([saveButton.rightAnchor.constraint(equalTo: imageView.rightAnchor), saveButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor), saveButton.widthAnchor.constraint(equalToConstant: 100), saveButton.heightAnchor.constraint(equalToConstant: 35)])
        }
    
    @objc func handleRetakeButton() {
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("T##message: String##String")
    }

}
