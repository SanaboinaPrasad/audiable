//
//  HomeViewController.swift
//  Audiable
//
//  Created by sanaboina  prasad on 03/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "we' are loggedIn..."
        view.backgroundColor = .yellow
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    
    @objc fileprivate func handleSignOut(){
        UserDefaults.standard.setIsLogedIn(value: false)
        let loginViewController = LoginController()
            present(loginViewController, animated: true, completion: nil)
        
    }
}
