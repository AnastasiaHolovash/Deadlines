//
//  LoginFirstViewController.swift
//  Deadlines
//
//  Created by Denis on 7/5/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            ViewManager.shared.toMainVC()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            ViewManager.shared.toMainVC()
        }
        
    }
    
    


}
