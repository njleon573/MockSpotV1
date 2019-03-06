//
//  HomeMapCollectionViewCell.swift
//  MockSpot
//
//  Created by Nick John on 2/7/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeMapCollectionViewCell: UICollectionViewCell {
    
    var imageURL: String? {
        didSet {
            print("didset")
            self.mockImageView.backgroundColor = UIColor.lightGray
            guard let imURL = imageURL else {return}
            guard let url = URL(string: imURL) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print("error downloading photos from url", err?.localizedDescription)
                    return
                }
                    guard let imageData = data else { return }
                    let image = UIImage(data: imageData)
                    
                DispatchQueue.main.async {
                    self.mockImageView.image = image
                }
                }.resume()
            }
        }
    

    
    var coordinate: CLLocationCoordinate2D?

    
    var initialImageAnchor: NSLayoutConstraint?
    var animatedImageAnchor: NSLayoutConstraint?
    

    
    let closestToYouLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let getDirectionsButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.white
        button.setTitle("Get Directions", for: .normal)
        button.setTitleColor(UIColor(white: 0, alpha: 0.3), for: .normal)
        return button
    }()
    
    let seePicturesButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.white
        button.setTitle("See Pictures", for: .normal)
        button.setTitleColor(UIColor(white: 0, alpha: 0.3), for: .normal)
        return button
    }()
    
    let cellView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let mockImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 20
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
        
    }
    
    private func layoutUI() {
        addSubview(cellView)
        NSLayoutConstraint.activate([cellView.centerXAnchor.constraint(equalTo: centerXAnchor), cellView.centerYAnchor.constraint(equalTo: centerYAnchor), cellView.widthAnchor.constraint(equalToConstant: frame.width)])
        
        
        initialImageAnchor = cellView.heightAnchor.constraint(equalToConstant: frame.height)
        initialImageAnchor?.isActive = true
        

        cellView.addSubview(mockImageView)
        mockImageView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, right: cellView.rightAnchor, bottom: cellView.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: -50, height: 0, width: 0)
        
        let stack = UIStackView(arrangedSubviews: [getDirectionsButton, seePicturesButton])
        cellView.addSubview(stack)
        
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.anchor(top: mockImageView.bottomAnchor, left: cellView.leftAnchor, right: cellView.rightAnchor, bottom: nil, paddingTop: 14, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, height: 20, width: 0)
//        initialImageAnchor = mockImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0)
//        initialImageAnchor?.isActive = true
        
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageURL = ""
        self.mockImageView.image = nil
        self.coordinate = nil
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
