//
//  SettingsViewController.swift
//  Deadlines
//
//  Created by Denis on 7/5/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else { return }
        emailLabel.text = email
    }
    
    
    
    @IBAction func didPressExit(_ sender: UIButton) {
        do {
            Settings.shared.isLoggedIn = false
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance()?.signOut()
            
            emailLabel.text = "Email:"
            ViewManager.shared.setupInitialController()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
