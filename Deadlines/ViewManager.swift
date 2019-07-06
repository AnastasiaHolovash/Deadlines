//
//  ViewManager.swift
//  Deadlines
//
//  Created by Denis on 7/5/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
//import FirebaseUI
import Firebase
import GoogleSignIn

class ViewManager {
    static let shared = ViewManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    private let loginStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
    
    func setupInitialController() {
        if let window = self.appDelegate?.window {
            let loginVC = loginStoryboard.instantiateInitialViewController()
            let mainVC = mainStoryboard.instantiateInitialViewController()
            window.rootViewController = Settings.shared.isLoggedIn ? mainVC : loginVC
        }
    }
    
    func toMainVC() {
        if let window = self.appDelegate?.window {
            let mainVC = mainStoryboard.instantiateInitialViewController()
            window.rootViewController =  mainVC
        }
    }
    
    func toLoginVC() {
        if let window = self.appDelegate?.window {
            let loginVC = mainStoryboard.instantiateInitialViewController()
            window.rootViewController =  loginVC
        }
    }
    
}
