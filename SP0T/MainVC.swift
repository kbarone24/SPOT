//
//  MainVC.swift
//  SP0T
//
//  Created by kbarone on 6/15/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {

    @IBAction func LogoutTapped(_ sender: Any) {
            do {
                
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch {
                print("There was a problem logging out")
            }
        }
    }

