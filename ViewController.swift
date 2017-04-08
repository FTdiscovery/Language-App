//
//  ViewController.swift
//  LanguageApp
//
//  Created by Gordon Chi on 7/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var credit: UILabel!
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    var userText = String()
    var passwordText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: userText, password: passwordText,completion: {(user,error) in
            
            //signs the user up again!
            if !(error != nil) {
                self.username.text = "Welcome, " + self.userText + "!"
                let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                account.observe(.value) { (snap: FIRDataSnapshot) in let score = (snap.value as AnyObject).description
                    self.credit.text = "LangApp Credit: " + score!
                }
            }
            else {
                //do nothing
            }
            
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFrench" {
            let french:FrenchViewController = segue.destination as! FrenchViewController
            french.username = userText
            french.password = passwordText
        }
        else if segue.identifier == "toGerman" {
            let german:GermanViewController = segue.destination as! GermanViewController
            german.username = userText
            german.password = passwordText
        }
        else if segue.identifier == "toRalyan" {
            let ralyan:RalyanViewController = segue.destination as! RalyanViewController
            ralyan.username = userText
            ralyan.password = passwordText
        }
        else if segue.identifier == "toChinese" {
            let chinese:ChineseViewController = segue.destination as! ChineseViewController
            chinese.username = userText
            chinese.password = passwordText
        }
        else if segue.identifier == "showRewards" {
            let rewards:RewardPage = segue.destination as! RewardPage
            rewards.username = userText
            rewards.password = passwordText
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
}

