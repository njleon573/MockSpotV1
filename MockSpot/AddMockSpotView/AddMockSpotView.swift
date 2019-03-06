//
//  AddMockSpotView.swift
//  MockSpot
//
//  Created by Nick John on 2/2/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation



class AddMockSpotView: UIViewController{
    
    
    // Define UI Elements
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.blue
        return iv
    }()
    
    let addTitleTextField: UITextField = {
       let tf = UITextField()
        tf.backgroundColor = UIColor.lightGray
        return tf
    }()
    
    let descriptionTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.yellow
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = UIColor(white: 0, alpha: 0.30)
    }
    
    // Layout UI Elements in View
    func layoutUI() {
        view.addSubview(imageView)
            imageView.anchor(top: view.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 100, width: 100)
        
        view.addSubview(addTitleTextField)
            addTitleTextField.anchor(top: view.topAnchor, left: imageView.rightAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 100, width: 0)
        
        view.addSubview(descriptionTextField)
            descriptionTextField.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 100, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 200, width: 0)
    }
}
