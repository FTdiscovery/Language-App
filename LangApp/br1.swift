//
//  br1.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class br1: UIViewController {
    
    var username = String()
    var password = String()
    let thresholdScore:[Int] = [10,50,100,250,500]
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func checkAnswers(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: self.username, password: self.password,completion: {(user,error) in
            
            //signs the user up again!
            if !(error != nil) {
                let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("br1")
                start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                    let done = String((snap.value as AnyObject).description)
                    if done == "not done" {
                        let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                        account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let score = (snap.value as AnyObject).description
                            let currentScore = Int(Int(score!)! + 15)
                            self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                            self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("br1").setValue("done")
                            for i in 0..<self.thresholdScore.count {
                                if (((Int(score!)!)<self.thresholdScore[i]) && (currentScore >= self.thresholdScore[i])) {
                                    self.performSegue(withIdentifier: "newReward", sender: nil)
                                }
                            }
                            self.performSegue(withIdentifier: "correct", sender: nil)
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


