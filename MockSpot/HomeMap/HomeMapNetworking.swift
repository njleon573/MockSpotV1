//
//  HomeMapNetworking.swift
//  MockSpot
//
//  Created by Nick John on 1/30/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation


extension HomeMapViewController {
    
    func retrieveMockSpotsFromDatabase() {
        

        
        
        
        
//        print("ret mock spot started")
//        ref.child("MockSpots").observeSingleEvent(of: DataEventType.value) { (snapshot, err) in
//            if err != nil {
//                print("error retrieving data ERR")
//            }
//            if let dictionary = snapshot.value as? [String: Any] {
//                dictionary.forEach({ (key, value) in
//                    guard let dictionary = value as? [String: Any] else {return}
//                    print(dictionary)
//                    guard let tit = dictionary["title"] else {return}
//                    guard let lat = dictionary["latitude"] else {return}
//                    guard let lon = dictionary["longitude"] else {return}
//                    guard let imgURL = dictionary["imageURL"] else {return}
//                    guard let locName = dictionary["locationName"] else {return}
////                    let spot = MockSpotPin(title: tit as! String, locationName: locName as! String, coverImageURL: imgURL as! String, coordinate: CLLocationCoordinate2D(latitude: lat as! CLLocationDegrees, longitude: lon as! CLLocationDegrees), city: "Deafult City", pinImage: UIImage(named: "MockSpotPin")!, starReviews: [1,3,4,2,3,2,3], comments: <#[Comment]#>)
////                    self.mockPins.append(spot)
//                    print(self.mockPins.count)
//                    self.map.addAnnotations(self.mockPins)
//                    self.mockCollectView?.reloadData()
//                })
//
//            } else {
//                print("error converting to dictionary")
//            }
//        }
//            print("rec mock spot ended")
//    }
//
    }}
