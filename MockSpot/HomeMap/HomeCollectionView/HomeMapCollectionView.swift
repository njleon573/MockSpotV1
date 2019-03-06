//
//  HomeMapCollectionView.swift
//  MockSpot
//
//  Created by Nick John on 1/30/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

extension HomeMapViewController {
    
    
    func initializeCollectionView() {
        
        let cvframe = CGRect.zero
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        
        let mockCollectionView = UICollectionView(frame: cvframe, collectionViewLayout: layout)
        mockCollectionView.isPagingEnabled = false
        mockCollectionView.allowsSelection = true
        map.addSubview(collectionContainer)
        mockCollectionView.backgroundColor = UIColor.clear
        mockCollectionView.delegate = self
        mockCollectionView.dataSource = self
        mockCollectionView.register(HomeMapCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        mockCollectView = mockCollectionView
        mockCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionContainer.centerXAnchor.constraint(equalTo: map.centerXAnchor).isActive = true
//        collectionContainer.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 0).isActive = true
//        collectionContainer.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: 0).isActive = true
//        collectionContainer.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: 0).isActive = true
//        initialConstraint = collectionContainer.heightAnchor.constraint(equalToConstant: 280)
//        initialConstraint?.isActive = true
//        animatedConstraing = collectionContainer.heightAnchor.constraint(equalToConstant: 350)
//        animatedConstraing?.isActive = false
        collectionContainer.backgroundColor = UIColor.clear
        
        collectionContainer.addSubview(mockCollectionView)
        mockCollectionView.backgroundColor = blueColor
        
        mockCollectionView.anchor(top: collectionContainer.topAnchor, left: collectionContainer.leftAnchor, right: collectionContainer.rightAnchor, bottom: collectionContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 0, width: 0)
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleCollectionDownSwipe))
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleUpSwipe))
        downGesture.direction = .down
        mockCollectionView.addGestureRecognizer(downGesture)
        mockCollectionView.addGestureRecognizer(upGesture)
        //        mockCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width - CGFloat(integerLiteral: 20)).isActive = true
        
    }
    
    @objc func handleCollectionDownSwipe() {
        if animatedConstraing?.isActive == true {
            self.animatedConstraing?.isActive = false
            self.initialConstraint?.isActive = true
            guard let index = mockCollectView?.indexPathsForSelectedItems else {return}
            UIView.animate(withDuration: 0.5) {

                self.view.layoutIfNeeded()
                self.mockCollectView?.cellForItem(at: index.first!)?.backgroundColor = UIColor(white: 0, alpha: 0)

                
            }
        }
    }
    
    @objc func handleUpSwipe() {
        if initialConstraint?.isActive == true {
            self.initialConstraint?.isActive = false
            
            self.animatedConstraing?.isActive = true
            guard let indexP = mockCollectView?.indexPathsForVisibleItems else {return}
            guard let index = mockCollectView?.indexPathsForSelectedItems else {return}
            UIView.animate(withDuration: 0.5) {
                
                self.view.layoutIfNeeded()
                self.mockCollectView?.cellForItem(at: indexP.first!)?.backgroundColor = UIColor(white: 0, alpha: 0.3)
                
                
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mockCollectView!.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HomeMapCollectionViewCell
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleCollectionDownSwipe))
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleUpSwipe))
        cell.mockImageView.addGestureRecognizer(downGesture)
        cell.mockImageView.addGestureRecognizer(upGesture)
//        cell.backgroundColor = UIColor(white: 0, alpha: 0)
        cell.backgroundColor = UIColor.white
//        cell.imageURL = mockPins[indexPath.item].imageURL
//        cell.mockImageView.image = imageArray[indexPath.item]
        cell.layer.cornerRadius = 0
        let mock1 = UIImage(named: "Mock1")!
        let mock2 = UIImage(named: "Mock2")!
        let mock3 = UIImage(named: "Mock3")!
        let mock4 = UIImage(named: "Mock4")!
        let mockImages:[UIImage] = [mock1,mock2,mock3,mock4]
        cell.mockImageView.image = mockImages[indexPath.item]
        
//            cell.imageURL = mockPins[indexPath.row].coverImageURL
//            cell.coordinate = mockPins[indexPath.row].coordinate
//            let spot = cell.coordinate!
//            let regionCall = MKCoordinateRegion(center: spot, latitudinalMeters: region ?? 1000, longitudinalMeters: region ?? 1000)
//            map.setRegion(regionCall, animated: true)
      

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//            return mockPins.count
        return 4

        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.initialConstraint?.isActive = false
        self.animatedConstraing?.isActive = true
        UIView.animate(withDuration: 0.5) {
            
            self.view.layoutIfNeeded()
            self.mockCollectView?.cellForItem(at: indexPath)?.backgroundColor = self.blueColor
           
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 200)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    

}
