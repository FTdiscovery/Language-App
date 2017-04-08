//
//  bg3.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class bg3: UIViewController {
    
    @IBOutlet weak var bin: UITextField!
    @IBOutlet weak var bist: UITextField!
    @IBOutlet weak var ist: UITextField!
    
    var username = String()
    var password = String()
    let thresholdScore:[Int] = [10,50,100,250,500]
    let scoreOnDatabase = FIRDatabase.database().reference()
    
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
                let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg3")
                start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                    let done = String((snap.value as AnyObject).description)
                    if done == "not done" {
                        let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                        account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let score = (snap.value as AnyObject).description
                            if (self.bin.text?.lowercased() == "bin" && self.bist.text?.lowercased() == "bist" && self.ist.text?.lowercased() == "ist" ) {
                                let currentScore = Int(Int(score!)! + 25)
                                self.bin.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.bist.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.ist.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg3").setValue("done")
                                for i in 0..<self.thresholdScore.count {
                                    if (((Int(score!)!)<self.thresholdScore[i]) && (currentScore >= self.thresholdScore[i])) {
                                        self.performSegue(withIdentifier: "newReward", sender: nil)
                                    }
                                }
                                self.performSegue(withIdentifier: "correct", sender: nil)
                            }
                            else {
                                self.performSegue(withIdentifier: "wrong", sender: nil)
                                if self.bin.text?.lowercased() != "bin" {
                                    self.bin.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.bist.text?.lowercased() != "bist" {
                                    self.bist.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.ist.text?.lowercased() != "ist" {
                                    self.ist.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                                }
                                if self.bin.text?.lowercased() == "bin" {
                                    self.bin.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                if self.bist.text?.lowercased() == "bist" {
                                    self.bist.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                }
                                if self.ist.text?.lowercased() == "ist" {
                                    self.ist.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
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


