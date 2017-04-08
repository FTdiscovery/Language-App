//
//  FrenchTest.swift
//  French Test
//
//  Created by Jack on 2017-02-22.
//  Copyright © 2017 Jack. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var dictofwords: [String:String] = ["hello":"Bonjour","goodbye":"Au Revoir","morning":"Le matin","evening":"Le soir","day":"Un jour"]
var listofwords: [String] = ["hello","goodbye","morning","evening","day"]


class FrenchTest: UIViewController {
    
    var randomIndex = Int(arc4random_uniform(UInt32(dictofwords.count)))
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    let thresholdScore:[Int] = [10,50,100,250,500]
    
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var word3: UILabel!
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    
    @IBAction func refreshWords(_ sender: Any) {
        randomIndex = Int(arc4random_uniform(UInt32(dictofwords.count)))
        word1.text = dictofwords[listofwords[randomIndex%dictofwords.count]]!
        word2.text = dictofwords[listofwords[(randomIndex+1)%dictofwords.count]]!
        word3.text = dictofwords[listofwords[(randomIndex+2)%dictofwords.count]]!
    }
    
    @IBAction func checkAns(_ sender: Any) {
        if answer1.text?.lowercased() == listofwords[randomIndex] {
            answer1.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer1.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
        }
        if answer2.text?.lowercased() == listofwords[(randomIndex+1)%dictofwords.count] {
            answer2.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer2.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)        }
        if answer3.text?.lowercased() == listofwords[(randomIndex+2)%dictofwords.count] {
            answer3.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer3.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
        }
        if (answer1.text?.lowercased() == listofwords[randomIndex] && answer2.text?.lowercased() == listofwords[(randomIndex+1)%dictofwords.count] && answer3.text?.lowercased() == listofwords[(randomIndex+2)%dictofwords.count]) {
            FIRAuth.auth()?.signIn(withEmail: self.username, password: self.password,completion: {(user,error) in
                
                if !(error != nil) {
                    let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                    account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                        let score = (snap.value as AnyObject).description
                        let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("frenchTest")
                        start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let done = String((snap.value as AnyObject).description)
                            if done == "not done" {
                                let currentScore = Int(Int(score!)! + 50)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("frenchTest").setValue("done")
                                for i in 0..<self.thresholdScore.count {
                                    if (((Int(score!)!)<self.thresholdScore[i]) && (currentScore >= self.thresholdScore[i])) {
                                        self.performSegue(withIdentifier: "newReward", sender: nil)
                                    }
                                }
                                self.performSegue(withIdentifier: "correct", sender: nil)
                            }
                            else {
                                self.performSegue(withIdentifier: "error", sender: nil)

                            }
                        }
                    }
                }
                else {
                }
                
            })

        }
        else {
            self.performSegue(withIdentifier: "wrong", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        word1.text = dictofwords[listofwords[randomIndex]]!
        word2.text = dictofwords[listofwords[(randomIndex+1)%dictofwords.count]]!
        word3.text = dictofwords[listofwords[(randomIndex+2)%dictofwords.count]]!
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


