//
//  br4.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class br4: UIViewController {
    
    var username = String()
    var password = String()
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


