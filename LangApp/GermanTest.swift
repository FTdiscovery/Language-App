//
//  GermanTest.swift
//  German Test
//
//  Created by Jack on 2017-02-22.
//  Copyright © 2017 Jack. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var germanDictionary: [String:String] = ["hello":"Hallo","goodbye":"Auf Wiedersehen","morning":"der Morgen","evening":"der Abend","day":"der Tag", "tree":"der Baum", "fish":"der Fisch", "apple":"der Apfel", "friend":"der Freund","german":"Deutsch","money":"das Geld", "good":"gut", "bad":"schlecht","happy":"glücklich","car":"das Auto","dog":"der Hund","cat":"die Katze","red":"rot","blue":"blau","yellow":"gelb","black":"schwarz","white":"weiß","green":"grün"]
var germanList: [String] = ["hello","goodbye","morning","evening","day","tree","fish","apple","friend","german","money","good","bad", "happy","car","dog","cat","red","blue","yellow","black","white","green"]


class GermanTest: UIViewController {
    
    var randomIndex = Int(arc4random_uniform(UInt32(germanDictionary.count)))
    
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
        randomIndex = Int(arc4random_uniform(UInt32(germanDictionary.count)))
        word1.text = germanDictionary[germanList[randomIndex%germanDictionary.count]]!
        word2.text = germanDictionary[germanList[(randomIndex+1)%germanDictionary.count]]!
        word3.text = germanDictionary[germanList[(randomIndex+2)%germanDictionary.count]]!
    }
    
    @IBAction func checkAns(_ sender: Any) {
        if answer1.text?.lowercased() == germanList[randomIndex] {
            answer1.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer1.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
        }
        if answer2.text?.lowercased() == germanList[(randomIndex+1)%germanDictionary.count] {
            answer2.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer2.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)        }
        if answer3.text?.lowercased() == germanList[(randomIndex+2)%germanDictionary.count] {
            answer3.backgroundColor = UIColor(red: 0, green: 1.0, blue:0, alpha: 0.5)
        }
        else{
            answer3.backgroundColor=UIColor(red: 1.0, green: 0, blue:0, alpha: 0.5)
        }
        if (answer1.text?.lowercased() == germanList[randomIndex] && answer2.text?.lowercased() == germanList[(randomIndex+1)%germanDictionary.count] && answer3.text?.lowercased() == germanList[(randomIndex+2)%germanDictionary.count]) {
            FIRAuth.auth()?.signIn(withEmail: self.username, password: self.password,completion: {(user,error) in
                
                if !(error != nil) {
                    let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                    account.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                        let score = (snap.value as AnyObject).description
                        let start = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("germanTest")
                        start.observeSingleEvent(of: .value) { (snap: FIRDataSnapshot) in
                            let done = String((snap.value as AnyObject).description)
                            if done == "not done" {
                                let currentScore = Int(Int(score!)! + 50)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score").setValue(currentScore)
                                self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("germanTest").setValue("done")
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
        word1.text = germanDictionary[germanList[randomIndex]]!
        word2.text = germanDictionary[
            germanList[(randomIndex+1)%germanDictionary.count]]!
        word3.text = germanDictionary[germanList[(randomIndex+2)%germanDictionary.count]]!
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


