//
//  FrenchView.swift
//  LangApp
//
//  Created by Gordon Chi on 7/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class FrenchView:UITableViewController {
    
    
    var username = String()
    var password = String()
    
    let scoreOnDatabase = FIRDatabase.database().reference()
    var arrayOfCellData = [cellData]()
    var storyboardSwitch:[String] = ["frenchTest"]
    var colours:[UIColor] = [UIColor.white]
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(text: "TEST" ,image: #imageLiteral(resourceName: "france"), colour: self.colours[0])]
        for i in 0..<storyboardSwitch.count {
            FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
                //signs the user up again!
                if !(error != nil) {
                    let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child(String(self.storyboardSwitch[i]))
                    account.observe(.value) { (snap: FIRDataSnapshot) in
                        let word = String((snap.value as AnyObject).description)
                        if (word == "done") {
                            self.arrayOfCellData[i].colour = UIColor.green
                        }
                        self.tableView.reloadData()
                    }
                }
            })
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("CourseTableViewCell", owner: self, options: nil)?.first as! CourseTableViewCell
        
        cell.coursePhoto.image = arrayOfCellData[indexPath.row].image
        cell.courseLabel.text = arrayOfCellData[indexPath.row].text
        cell.courseLabel.backgroundColor = arrayOfCellData[indexPath.row].colour
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! FrenchTest
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        default: break
            //nothing
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49 //tight fit is 44
    }
    
    
}
