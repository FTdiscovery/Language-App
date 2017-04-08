//
//  GermanView.swift
//  LangApp
//
//  Created by Gordon Chi on 7/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseDatabase

struct cellData {
    var text:String!
    let image:UIImage!
    var colour:UIColor!
}

class GermanView:UITableViewController {
    
    var username = String()
    var password = String()
    
    let scoreOnDatabase = FIRDatabase.database().reference()
    var arrayOfCellData = [cellData]()
    var storyboardSwitch:[String] = ["bg1","bg2","bg3","germanTest"]
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(text: "Class 1",image: #imageLiteral(resourceName: "germany.png"),colour: UIColor.white), cellData(text: "Class 2",image: #imageLiteral(resourceName: "germany.png"),colour: UIColor.white), cellData(text: "Class 3" ,image: #imageLiteral(resourceName: "germany.png"), colour: UIColor.white), cellData(text: "TEST" ,image: #imageLiteral(resourceName: "germany.png"), colour: UIColor.white)]
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
        
        return (cell)
        
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! bg1
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! bg2
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! bg3
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! GermanTest
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        default: break
            //nothing
        }
        
        
    }
        

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    func isGreen(colour:String, completionHandler:@escaping (_ success:Bool) ->()) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: {(user,error) in
            //signs the user up again!
            if !(error != nil) {
                let account = self.scoreOnDatabase.child(FIRAuth.auth()!.currentUser!.uid).child(colour)
                account.observe(.value) { (snap: FIRDataSnapshot) in
                    let hasDoneBefore = String((snap.value as AnyObject).description)
                    if (hasDoneBefore == "done") {
                        completionHandler(true)
                    }
                    else {
                        completionHandler(false)
                    }
                }
            }
        })
        completionHandler(false)
    }
    
    /* this could one day work
    func putColourOnTable(theColour:String) -> UIColor {
        isGreen(colour:theColour) { (success) -> () in
            if success == true {
                print("have done this before")
            }
            else {
               print("haven't done this before")
            }
        }
        return UIColor.white
    }
    */

}
