//
//  MenuViewController.swift
//  MockSpot
//
//  Created by Nick John on 2/15/19.
//  Copyright © 2019 Nick John. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let menuContainer: UIView = {
       let vw = UIView()
        return vw
    }()
    
    let menuTableView: UITableView = {
       let table = UITableView()
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        menuTableView.separatorColor = UIColor.gray
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleBackSwipe))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
        setContainerLayout()
    }
    
    @objc func handleBackSwipe() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setContainerLayout() {
        view.addSubview(menuContainer)
        menuContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, height: 0, width: view.frame.width*0.50)
        menuContainer.backgroundColor = UIColor.white
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        menuContainer.addSubview(menuTableView)
        menuTableView.anchor(top: menuContainer.topAnchor, left: menuContainer.leftAnchor, right: menuContainer.rightAnchor, bottom: menuContainer.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -300, height: 0, width: 0)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "tableCell") as! UITableViewCell
        
        cell.backgroundColor = UIColor.white
        
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Invite Friends!"
            
            cell.textLabel?.textColor = UIColor.lightGray
        }
        if indexPath.row == 1 {
            cell.textLabel?.text = "Add a Spot"
            cell.textLabel?.textColor = UIColor.lightGray
        }
        if indexPath.row == 2 {
            cell.textLabel?.text = "Profile"
            cell.textLabel?.textColor = UIColor.lightGray
        }
        if indexPath.row == 3 {
            cell.textLabel?.text = "Account"
            cell.textLabel?.textColor = UIColor.lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }


}
