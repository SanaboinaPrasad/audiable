//
//  MainViewController.swift
//  Audiable
//
//  Created by sanaboina  prasad on 03/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if isLogedIn() {
            let homeViewController = HomeViewController()
                viewControllers = [homeViewController]
            
        }else {
            perform(#selector(showLoginViewController), with: nil, afterDelay: 0.01)
        }
    }
 fileprivate  func isLogedIn() -> Bool {
    return UserDefaults.standard.isLogedIn()
    }
    
    @objc func showLoginViewController(){
        let loginViewController = LoginController()
        present(loginViewController, animated: true, completion: nil)
    }

   

}


