//
//  ChineseViewController.swift
//  Language App
//
//  Created by Gordon Chi on 8/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import UIKit

class ChineseViewController: UIViewController {
    
    var username = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backHome" {
            let splash:ViewController = segue.destination as! ViewController
            splash.userText = username
            splash.passwordText = password
        }
        if segue.identifier == "toBasic" {
            let basic:BasicChinese = segue.destination as! BasicChinese
            basic.username = username
            basic.password = password
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


