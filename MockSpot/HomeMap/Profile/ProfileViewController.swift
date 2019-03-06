//
//  ProfileViewController.swift
//  MockSpot
//
//  Created by Nick John on 2/15/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileImageView:UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleBackSwipe))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
        layoutUI()
    }
    
    @objc func handleBackSwipe() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func layoutUI() {
        let topContainer = UIView()
        topContainer.backgroundColor = UIColor.blue
        view.addSubview(topContainer)
        topContainer.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: view.frame.height*0.40, width: 0)
        topContainer.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        profileImageView.layer.cornerRadius = 90
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.image = UIImage(named: "profileImage")?.withRenderingMode(.alwaysOriginal)
        
        
    }
    


}
