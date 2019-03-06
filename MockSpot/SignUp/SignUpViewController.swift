//
//  SignUpViewController.swift
//  MockSpot
//
//  Created by Nick John on 2/9/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let blueColor = UIColor.init(displayP3Red: 109/255, green: 142/255, blue: 165/255, alpha: 255/255)
    
    let signUpViewContainer = UIView()

    var bottomInitialAnchor: NSLayoutConstraint?
    var bottomoAnimateAnchor: NSLayoutConstraint?
    
    let emailTF: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0.25, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(TFdidBeginEditing), for: .allEditingEvents)
//        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.clearButtonMode = .always
        return tf
    }()
    
    let userNameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0.50, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(TFdidBeginEditing), for: .allEditingEvents)
        //        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.clearButtonMode = .always
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0.75, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(TFdidBeginEditing), for: .allEditingEvents)
        tf.isSecureTextEntry = true
        //        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.clearButtonMode = .always
        return tf
    }()
    
    
    let passwordTF2: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Re-Enter Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(TFdidBeginEditing), for: .allEditingEvents)
        tf.isSecureTextEntry = true
        //        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.clearButtonMode = .always
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    

    
    fileprivate func initializeViewGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDownGesture.direction = .down
        view.addGestureRecognizer(swipeDownGesture)
        view.addGestureRecognizer(gesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        initializeViewGestures()
        layoutUI()

        
    }
    
    @objc func TFdidBeginEditing() {
        print("didBeginEditing")
        var formIsValid: Bool = emailTF.text?.count ?? 0 > 0 && userNameTF.text?.count ?? 0 > 0 && passwordTF.text?.count ?? 0 > 0 && passwordTF2.text?.count ?? 0 > 0
        
        if formIsValid == true {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = blueColor
            print("formIsValid")
        } else {
            signUpButton.isEnabled = false
            print("formIsNOTValid")
        }
        if bottomInitialAnchor?.isActive == true {
            bottomInitialAnchor?.isActive = false
            bottomoAnimateAnchor?.isActive = true
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }

        
    }
    
    @objc func handleSignUp() {
        print("handleSignUp")
    }
    

    func layoutUI() {
        let textFieldSV = UIStackView(arrangedSubviews: [emailTF,userNameTF,passwordTF,passwordTF2,signUpButton])
        view.addSubview(signUpViewContainer)
        signUpViewContainer.addSubview(textFieldSV)
        
        signUpViewContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: nil, paddingTop: 50, paddingLeft: 30, paddingRight: -30, paddingBottom: 0, height: 0, width: 0)
        
        addAnimationConstraints()
        
        signUpViewContainer.backgroundColor = UIColor.white
        signUpViewContainer.layer.cornerRadius = 20
        textFieldSV.axis = .vertical
        textFieldSV.distribution = .fillEqually
        signUpViewContainer.addSubview(textFieldSV)
        textFieldSV.anchor(top: nil, left: nil, right: nil, bottom: signUpViewContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -40, height: 240, width: 270)
        textFieldSV.centerXAnchor.constraint(equalTo: signUpViewContainer.centerXAnchor).isActive = true
        textFieldSV.spacing = 10
        
    }
    
    func addAnimationConstraints() {
        bottomInitialAnchor = signUpViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        bottomInitialAnchor?.isActive = true
        bottomoAnimateAnchor = signUpViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -240)
        bottomoAnimateAnchor?.isActive = false
        
    }
    
    @objc func handleTapGesture() {
        view.endEditing(true)
    }
    
    @objc func handleSwipeDown() {
        self.dismiss(animated: true, completion: nil)
        
    }

}
