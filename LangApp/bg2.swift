//
//  bg2.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class bg2: UIViewController {
    
    var username = String()
    var password = String()
    let thresholdScore:[Int] = [10,50,100,250,500]
    let scoreOnDatabase = FIRDatabase.database().reference()
    @IBOutlet weak var userInput: UITextField!
    
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
                let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg2")
                start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                    let done = String((snap.value as AnyObject).description)
                    if done == "not done" {
                        let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                        account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let score = (snap.value as AnyObject).description
                            if (self.userInput.text?.lowercased() == "ich heisse bob") {
                                let currentScore = Int(Int(score!)! + 20)
                                self.userInput.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("bg2").setValue("done")
                                for i in 0..<self.thresholdScore.count {
                                    if (((Int(score!)!)<self.thresholdScore[i]) && (currentScore >= self.thresholdScore[i])) {
                                        self.performSegue(withIdentifier: "newReward", sender: nil)
                                    }
                                }
                                self.performSegue(withIdentifier: "correct", sender: nil)
                            }
                            else {
                                self.performSegue(withIdentifier: "wrong", sender: nil)
                                self.userInput.backgroundColor = UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
                            }
                        }
                    }
                    else {
                        self.performSegue(withIdentifier: "error", sender: nil)
                        self.userInput.backgroundColor = UIColor(red: 1.0, green: 1.0, blue:1.0, alpha: 0.5)
                        
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


