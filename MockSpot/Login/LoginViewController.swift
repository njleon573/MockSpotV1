//
//  LoginViewController.swift
//  MockSpot
//
//  Created by Nick John on 1/18/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit
import Firebase

protocol loginViewControllerDelegate {
    func receiveLoginUserInfo(userID: String, username: String)
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults()
    
    let blueColor = UIColor.init(displayP3Red: 109/255, green: 142/255, blue: 165/255, alpha: 255/255)

    let topContainer:UIView = {
       let container = UIView()
        return container
    }()
    
    let loginStackView = UIStackView()
    
    let logoImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "MockLogo")
        return iv
    }()

    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.clearButtonMode = .always
        return tf
    }()
    

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(didBeginEditing), for: .allEditingEvents)
        tf.isSecureTextEntry = true
        tf.clearButtonMode = .always
        return tf
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.init(displayP3Red: 109/255, green: 142/255, blue: 165/255, alpha: 100/255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Dont have an Account?"
        return label
    }()

    let signUpButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = true
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    
    @objc func handleSignUp() {
        
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
//        let home = HomeMapViewController()
//
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, err) in
//            if err != nil {
//                print("Cannot create user", err)
//            } else {
//
//                self.present(home, animated: true, completion: nil)}
//            }
        }

    
    @objc func handleLogin() {
        let home = HomeMapViewController()
        self.present(home, animated: true, completion: nil)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, err) in
            if err != nil {
                print("Cannot login user", err.debugDescription)
            } else {
                self.defaults.set(user?.uid, forKey: "userID")
//                self.present(home, animated: true, completion: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        
//        if Auth.auth().currentUser != nil {
//            let home = HomeMapViewController()
//            self.navigationController?.pushViewController(home, animated: true)
//        } else {
//            print("User is not logged in")
//        }

        
        topContainer.addSubview(loginStackView)
        topContainer.addSubview(logoImageView)
        logoImageView.anchor(top: topContainer.safeAreaLayoutGuide.topAnchor, left: topContainer.leftAnchor, right: topContainer.rightAnchor, bottom: nil, paddingTop: 70, paddingLeft: 30, paddingRight: -30, paddingBottom: 0, height: 80, width: 0)

        setupUI()
        
    
        emailTextField.delegate = self
//        userNameTextField.delegate = self
        passwordTextField.delegate = self
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTapToDismissKeyboard))

        view.addGestureRecognizer(dismissKeyboardGesture)

    }

    @objc func didBeginEditing() {

    var formIsValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
    
    if formIsValid == true {
        loginButton.backgroundColor = blueColor
        loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor.init(displayP3Red: 109/255, green: 142/255, blue: 165/255, alpha: 100/255)
                loginButton.isEnabled = false
                    }
    }
    
    
   @objc func handleViewTapToDismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        view.addSubview(topContainer)
        
        topContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 400 , width: 0)

        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
//        initialStackView.addArrangedSubview(signUpButton)
        loginStackView.backgroundColor = .blue
        loginStackView.axis = .vertical
        loginStackView.spacing = 10
        loginStackView.distribution = .fillEqually

        loginStackView.anchor(top: nil, left: topContainer.leftAnchor, right: topContainer.rightAnchor, bottom: topContainer.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: -20, paddingBottom: -30, height: 140, width: 0)
        
        let signUpStackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        view.addSubview(signUpStackView)
        signUpStackView.axis = .horizontal
        signUpStackView.distribution = .fillProportionally
        signUpStackView.anchor(top: nil, left: nil, right: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -10, height: 15, width: 210)
        signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    

}
