//
//  FrenchRewardPage.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FrenchRewardPage: UIViewController {
    
    @IBOutlet weak var ten: UIButton!
    @IBOutlet weak var fifty: UIButton!
    @IBOutlet weak var hundred: UIButton!
    @IBOutlet weak var twofifty: UIButton!
    @IBOutlet weak var fivehundred: UIButton!
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let displayScore = (snap.value as AnyObject).description
                    self.score.text = "LangApp Credit: " + displayScore!
                    if (Int(displayScore!)!<500) {
                        self.fivehundred.backgroundColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.0)
                        self.fivehundred.setTitle("500 points to unlock!",for:.normal)
                        self.fivehundred.setTitleColor(UIColor.white,for: .normal)
                        self.fivehundred.isEnabled = false
                    }
                    if (Int(displayScore!)!<250) {
                        self.twofifty.backgroundColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.0)
                        self.twofifty.setTitle("250 points to unlock!",for:.normal)
                        self.twofifty.setTitleColor(UIColor.white,for: .normal)
                        self.twofifty.isEnabled = false
                    }
                    if (Int(displayScore!)!<100) {
                        self.hundred.backgroundColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.0)
                        self.hundred.setTitle("100 points to unlock!",for:.normal)
                        self.hundred.setTitleColor(UIColor.white,for: .normal)
                        self.hundred.isEnabled = false
                    }
                    if (Int(displayScore!)!<50) {
                        self.fifty.backgroundColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.0)
                        self.fifty.setTitle("50 points to unlock!",for:.normal)
                        self.fifty.setTitleColor(UIColor.white,for: .normal)
                        self.fifty.isEnabled = false
                    }
                    if (Int(displayScore!)!<10) {
                        self.ten.backgroundColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.0)
                        self.ten.setTitle("10 points to unlock!",for:.normal)
                        self.ten.setTitleColor(UIColor.white,for: .normal)
                        self.ten.isEnabled = false
                    }
                }
            }
            else {
                //do nothing
            }
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backHome" {
            let splash:RewardPage = segue.destination as! RewardPage
            splash.username = username
            splash.password = password
        }
    }
    @IBAction func showFirstReward(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let score = Int((snap.value as AnyObject).description)
                    if (score!>=10) {
                        self.performSegue(withIdentifier: "no", sender: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Uh oh.", message: "Not enough Points.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
            }
        })

    }
    @IBAction func showSecondReward(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let score = Int((snap.value as AnyObject).description)
                    if (score!>=50) {
                        self.performSegue(withIdentifier: "no", sender: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Uh oh.", message: "Not enough Points.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
            }
        })

    }
    @IBAction func showThirdReward(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let score = Int((snap.value as AnyObject).description)
                    if (score!>=100) {
                        self.performSegue(withIdentifier: "no", sender: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Uh oh.", message: "Not enough Points.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
            }
        })

    }
    @IBAction func showFourthReward(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let score = Int((snap.value as AnyObject).description)
                    if (score!>=250) {
                        self.performSegue(withIdentifier: "no", sender: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Uh oh.", message: "Not enough Points.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
            }
        })

    }
    @IBAction func showFifthReward(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let findScore = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                findScore.observe(.value) { (snap: FIRDataSnapshot) in
                    let score = Int((snap.value as AnyObject).description)
                    if (score!>=500) {
                        self.performSegue(withIdentifier: "no", sender: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Uh oh.", message: "Not enough Points.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else {
            }
        })

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



