//
//  RewardPage.swift
//  Language App
//
//  Created by Gordon Chi on 12/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RewardPage: UIViewController {
    
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
            let splash:ViewController = segue.destination as! ViewController
            splash.userText = username
            splash.passwordText = password
        }
        if segue.identifier == "toRalyan" {
            let splash:RalyanRewardPage = segue.destination as! RalyanRewardPage
            splash.username = username
            splash.password = password
        }
        if segue.identifier == "toGerman" {
            let splash:GermanRewardPage = segue.destination as! GermanRewardPage
            splash.username = username
            splash.password = password
        }
        if segue.identifier == "toChinese" {
            let splash:ChineseRewardPage = segue.destination as! ChineseRewardPage
            splash.username = username
            splash.password = password
        }
        if segue.identifier == "toFrench" {
            let splash:FrenchRewardPage = segue.destination as! FrenchRewardPage
            splash.username = username
            splash.password = password
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


