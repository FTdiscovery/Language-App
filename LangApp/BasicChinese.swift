//
//  BasicChinese.swift
//  LangApp
//
//  Created by Gordon Chi on 11/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class BasicChinese: UIViewController {
    
    
    @IBOutlet weak var score: UILabel!
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            
            //signs the user up again!
            if !(error != nil) {
                let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child("score")
                account.observe(.value) { (snap: FIRDataSnapshot) in let score = (snap.value as AnyObject).description
                    self.score.text = "Score: " + score!
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
        if segue.identifier == "mainChinese" {
            let splash:ChineseViewController = segue.destination as! ChineseViewController
            splash.username = username
            splash.password = password
        }
        if segue.identifier == "courseTable" {
            let navController:UINavigationController = segue.destination as! UINavigationController
            let table:ChineseView = navController.topViewController as! ChineseView
            table.username = username
            table.password = password
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


