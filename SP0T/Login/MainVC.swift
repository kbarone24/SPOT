//
//  MainVC.swift
//  SP0T
//
//  Created by kbarone on 7/2/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class MainVC: UIViewController {
    
    
    //cant wait to get rid of this trash
    @IBAction func LogoutTapped(_ sender: Any) {
        do {
            
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("There was a problem logging out")
        }
    }
}

