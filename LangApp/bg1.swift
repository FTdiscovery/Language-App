//
//  bg1.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class bg1: UIViewController {
    
    
    @IBOutlet weak var hallo: UITextField!
    @IBOutlet weak var eins: UITextField!
    @IBOutlet weak var zwei: UITextField!
    @IBOutlet weak var drei: UITextField!
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    let thresholdScore:[Int] = [10,50,100,250,500]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func checkAnswers(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: self.username, password: self.password,completion: {(user,error) in
            
            //signs the user up again!
            if !(error != nil) {
                let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg1")
                start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                    let done = String((snap.value as AnyObject).description)
                    if done == "not done" {
                        let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                        account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let score = (snap.value as AnyObject).description
                            if (self.hallo.text?.lowercased() == "hallo" && self.eins.text?.lowercased() == "eins" && self.zwei.text?.lowercased() == "zwei" && self.drei.text?.lowercased() == "drei") {
                            let currentScore = Int(Int(score!)! + 15)
                                self.hallo.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.eins.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.zwei.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.drei.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                            self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                            self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg1").setValue("done")
                            for i in 0..<self.thresholdScore.count {
                                if (((Int(score!)!)<self.thresholdScore[i]) && (currentScore >= self.thresholdScore[i])) {
                                    self.performSegue(withIdentifier: "newReward", sender: nil)
                                    }
                                }
                            self.performSegue(withIdentifier: "correct", sender: nil)
                            }
                            else {
                                self.performSegue(withIdentifier: "wrong", sender: nil)
                                if self.hallo.text?.lowercased() != "hallo" {
                                    self.hallo.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.eins.text?.lowercased() != "eins" {
                                    self.eins.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.zwei.text?.lowercased() != "zwei" {
                                    self.zwei.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.drei.text?.lowercased() != "drei" {
                                    self.drei.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.hallo.text?.lowercased() == "hallo" {
                                    self.hallo.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                if self.eins.text?.lowercased() == "eins" {
                                    self.eins.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                if self.zwei.text?.lowercased() == "zwei" {
                                    self.zwei.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                if self.drei.text?.lowercased() == "drei" {
                                    self.drei.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                
                            }
                        }
                    }
                    else {
                        self.performSegue(withIdentifier: "error", sender: nil)
                    }
                }
            }
            else {
                //do nothing
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


