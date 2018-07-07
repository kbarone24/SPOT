//
//  loginVC.swift
//  SP0T
//
//  Created by kbarone on 7/1/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class loginVC: UIViewController {

    var _segue = true
    
    @IBOutlet weak var _email: UITextField!
    
    @IBOutlet weak var _password: UITextField!
    
    
    //unwrapping email and password strings
    @IBAction func login(_ sender: Any) {
        guard let email = _email.text, email != "" else {
            print("Not a valid username")
            return
        }
        guard let password = _password.text, password != "" else {
            print("Not a valid password")
            return
        }
        
        //sign in method
        Auth.auth().signIn(withEmail: email, password: password) { (user, error)  in if let firebaseError = error {
            print(firebaseError.localizedDescription)
            let alert = UIAlertController(title: "Error", message: firebaseError.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            self._segue = false
            return
        } else {
            //instruct to perform segue
            self._segue = true
            
            //updating the password until we figure out a better way to account for forgot password changes
            let ref = Database.database().reference(fromURL: "https://spot69420.firebaseio.com/")
            guard let uid = Auth.auth().currentUser?.uid else {
                return
                
            }
            let usersReference = ref.child("users").child(uid)
            let values = ["password":password]
            usersReference.updateChildValues(values) { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
            }
        }
    }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier.elementsEqual("loginToMain")) {
        return self._segue
        }
        else {
            return true
        }
    }
    
}
