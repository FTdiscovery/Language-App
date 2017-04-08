//
//  CreateAccount.swift
//  LangApp
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

//ERROR TODO LMAO GO CHANGE

import UIKit
import Firebase
import FirebaseDatabase

class CreateAccount: UIViewController {
    
    var data:FIRDatabaseReference?
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var createAccountTitle: UILabel!
    @IBOutlet weak var createAccountDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = FIRDatabase.database().reference()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginPage.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOnScreen(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDeleteFromScreen(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if((email.text?.characters.count)!>4 && (password.text?.characters.count)!>=6) {
            succeed()
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {(user,error) in
                if error == nil
                {
                    FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!,completion: {(user,error) in
                        
                        if error == nil {
                            var courses:[String] = ["bg1","bg2","bg3","br1","br2","br3","br4","br5","frenchTest","germanTest"]
                            self.data?.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(0)
                            for i in 0..<courses.count {
                                self.data?.child(FIRAuth.auth()!.currentUser!.uid).child(String(courses[i])).setValue("not done")
                            }
                            //We're going to start getting points. We're going to win again. We're going to authenticate like you've never seen before.
                        }
                        else {
                            //don't do anything if it fails. It's gonna be horrible, worse than anything you've ever seen, total loss. Sad! - Donald Trump
                        }
                        
                    })
                    self.email.text = ""
                    self.password.text = ""
                }
                else {
                    let alert = UIAlertController(title: "Uh oh.", message: "Oops.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }
        else if ((email.text?.characters.count)!>0 && (email.text?.characters.count)!<4){
            let alert = UIAlertController(title: "Error.", message: "Invalid Email!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if ((password.text?.characters.count)!>0 && (password.text?.characters.count)!<6){
            let alert = UIAlertController(title: "Error.", message: "Password must be at least 6 characters long!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if ((email.text?.characters.count)!>0 && (password.text?.characters.count)!==0){
            let alert = UIAlertController(title: "Invalid Password", message: "Please fill in your password.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if ((email.text?.characters.count)!==0 && (password.text?.characters.count)!>0){
            let alert = UIAlertController(title: "Invalid Username", message: "Please fill in your username.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please fill in the blanks.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardOnScreen(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardSize?.height)!
            createAccountTitle.text = ""
            createAccountDescription.text = ""
        }
        else {
        
        }
    }
    
    func keyboardDeleteFromScreen(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += (keyboardSize?.height)!
            createAccountTitle.text = "New Account"
            createAccountDescription.text = "Please enter your email and desired password into the database. This will be used to save your progress and check the points you have accumulated from the app!"
        }
        else {
            
        }
    }
    
    
    func succeed() {
    
        let alert = UIAlertController(title: "Update", message: "Your account has been created. You can now sign in and use all the features of LangApp. Click 'Back' to log-in! Have a good day.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

