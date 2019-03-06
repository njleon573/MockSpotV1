//
//  File.swift
//  MockSpot
//
//  Created by Nick John on 1/12/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MockSpotPin: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let city: String?
    let title: String?
    let locationName: String
    let coverImageURL: String
    let pinImage: UIImage
    let starReviews: [Int]
    let comments:[Comment]
    
    init(coordinate: CLLocationCoordinate2D, city: String, title: String, locationName: String, coverImageURL: String, pinImage: UIImage, starReviews: [Int], comments: [Comment]) {
        
    self.coordinate = coordinate
    self.city = city
    self.title = title
    self.locationName = locationName
    self.coverImageURL = coverImageURL
    self.pinImage = pinImage
    self.starReviews = starReviews
    self.comments = comments
        
        super.init()
    }
    
    
    
    var subtitle: String? {
        return locationName
    }
    
}
