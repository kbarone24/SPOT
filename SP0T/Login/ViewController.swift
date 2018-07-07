//
//  ViewController.swift
//  SP0T
//
//  Created by kbarone on 6/14/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    
    var _segue = false
    
    @IBOutlet weak var _name: UITextField!
  
    @IBOutlet weak var _email: UITextField!
    
    @IBOutlet weak var _username: UITextField!
    
    @IBOutlet weak var _password: UITextField!
    
    //these are for checking for valid password
 
    
    var ref : DatabaseReference! = nil
    // This might be the error or a Storage reference
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        //firebase reference
        ref = Database.database().reference(fromURL: "https://spot69420.firebaseio.com/")    }

    
    //this is checking for a valid email
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    //checking for password length >= 6
    func isValidPassword(password:String) -> Bool {
        if (password.count >= 6) {
            return true
        }
        return false
    }
 
    
    
    @IBAction func createAccount(_ sender: Any) {
        //need to check if valid username, password, email- all of these should come up if fields are blank
        
        guard let name = _name.text, name != "" else {
            print("Not a valid name")
            emptyStringAlert()
            return
        }
        guard let email = _email.text, email != "" else {
            print("Not a valid email")
            emptyStringAlert()
            return
        }
        guard let username = _username.text, username != "" else {
            print("Not a valid username")
            emptyStringAlert()
            return
        }
        guard let password = _password.text, password != "" else {
            print("Password must be 6 characters or longer")
            emptyStringAlert()
            return
        }
        //check if email address could be a real email
    
        
        if !(isValidPassword(password: password)) {
            print("Password must be 6 characters or longer")
            passwordLengthAlert()
            return
            }
        if !(isValidEmail(email: email)) {
            print("Not a valid email")
            emailAlert()
            return
            }
            //firebase createUser
            else { Auth.auth().createUser(withEmail: email, password: password) { (user, error)  in if let firebaseError = error {
            print(firebaseError.localizedDescription)
            //set up alert so that it shows the error that Firebase is returning
            let alert = UIAlertController(title: "Error", message: firebaseError.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            self._segue = false
            return
            }
            //moved this up so that we create account on first tap
            self._segue = true
            self.performSegue(withIdentifier: "createAccountToIntro", sender: self)

            }
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://spot69420.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email, "username":username, "password":password]
            //set values in databse
            usersReference.updateChildValues(values) { (err, ref) in
                
                if err != nil {
                   print(err!)
                    return
                }
                print("Saved user successfully")
            }
        }
    }
            
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
                if (identifier.elementsEqual("createAccountToIntro")) {
                    return self._segue
                }
                else {
                    return true
                }
           }
    //alerts to display
    func emptyStringAlert() {
        let alert = UIAlertController(title: "Error", message: "All fields must be filled out", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func passwordLengthAlert() {
        let alert = UIAlertController(title: "Error", message: "Password must be at least 6 characters", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func emailAlert() {
        let alert = UIAlertController(title: "Error", message: "Not a valid email address", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

            
    }


 /*   @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUpToLogin",
*/

