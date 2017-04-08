//
//  ralyanEditor.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ralyanEditor: UIViewController {
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var displayRalyan: UILabel!
    @IBAction func displayTextInField(_ sender: Any) {
        let doubleWords = ["ck","c","kh","xylophone","aa","bb","cc","dd","ff","gg","hh","ii","kk","ll","mm","nn","pp","qq","rr","ss","tt","uu","vv","ww","xx","yy","zz","wh","ph","kh","one","legend","why","how","two","ee","oo","j","ts","tz","ch","sh","zh","thomas","sch","x","you","are"]
        let singleWords = ["k","k","c","zailofon","a","b","c","d","f","g","h","y","k","l","m","n","p","q","r","s","t","u","v","w","x","y","z","w","f","k","wan","lezend","wai","hau","tu","y","u","z","j","j","c","q","z","tomas","sh","ks","yu","ar"]
        var rawInput = textField.text?.lowercased()
        for i in 0..<doubleWords.count {
            rawInput = rawInput?.replacingOccurrences(of: doubleWords[i], with: singleWords[i])
        }
        rawInput = rawInput?.uppercased()
        displayRalyan.text = rawInput
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


