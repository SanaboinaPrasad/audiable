//
//  UserDefaults+helper.swift
//  Audiable
//
//  Created by sanaboina  prasad on 03/12/19.
//  Copyright © 2019 sanaboina  prasad. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    enum UserDefaultKeys: String {
        case isLogedIn
    }
    func setIsLogedIn(value: Bool){
        set(value, forKey: UserDefaultKeys.isLogedIn.rawValue)
        synchronize()
    }
    func isLogedIn() -> Bool{
        return bool(forKey: UserDefaultKeys.isLogedIn.rawValue)
    }
}
