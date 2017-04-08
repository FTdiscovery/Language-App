//
//  LoginPage.swift
//  LangApp
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase

class LoginPage: UIViewController {
    
    let keepUserSignedIn = UserDefaults.standard
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBAction func changeView(_ sender: UIButton) {
        if((email.text?.characters.count)!>0 && (password.text?.characters.count)!>0) {
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!,completion: {(user,error) in
            
                if !(error != nil) {
                    //switch view controllers
                    self.keepUserSignedIn.setValue(self.email.text, forKey: "email")
                    self.keepUserSignedIn.setValue(self.password.text, forKey: "password")
                    self.keepUserSignedIn.synchronize()
                    self.performSegue(withIdentifier: "nextView", sender: self.login)
                }
                else {
                    self.performSegue(withIdentifier: "wrongCreds", sender: self.login)
                }
            
            })
        
        }
        else if ((email.text?.characters.count)!>0 && (password.text?.characters.count)!==0){
            self.performSegue(withIdentifier: "enterpassword", sender: self.login)
        }
        else if ((email.text?.characters.count)!==0 && (password.text?.characters.count)!>0){
            self.performSegue(withIdentifier: "enterusername", sender: self.login)
        }
        else {
            self.performSegue(withIdentifier: "enteranything", sender: self.login)        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedUsername = self.keepUserSignedIn.string(forKey: "email")
        let savedPassword = self.keepUserSignedIn.string(forKey: "password")
        if ((savedUsername?.characters.count)! > 0 && (savedPassword?.characters.count)! > 0) {
            email.text = savedUsername
            password.text = savedPassword
        }
        FIRAuth.auth()?.signIn(withEmail: (savedUsername)!, password: (savedPassword)!,completion: {(user,error) in
            if !(error != nil) {
                //switch view controllers
                self.keepUserSignedIn.synchronize()
                self.performSegue(withIdentifier: "nextView", sender: self.login)
            }
            else {
                self.performSegue(withIdentifier: "wrongCreds", sender: self.login)
            }
            
        })
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginPage.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextView" {
            let loggedInSplash:ViewController = segue.destination as! ViewController
            loggedInSplash.userText = email.text!
            loggedInSplash.passwordText = password.text!
        }
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

