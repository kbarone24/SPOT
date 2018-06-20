//
//  ViewController.swift
//  SP0T
//
//  Created by kbarone on 6/14/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var GoogleSignIn: GIDSignInButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleSignIn.style = .wide
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentMainScreen()
        }
    }


    @IBAction func createAccountTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if let firebaseError = error{ print(firebaseError.localizedDescription)
                    return
                }
                self.presentMainScreen()
            } )
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
          if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if let firebaseError = error{ print(firebaseError.localizedDescription)
                    return
                }
                self.presentMainScreen()
            })
    }
}
    func presentMainScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC:MainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.present(mainVC, animated: true, completion: nil)
    }
    
    
}
