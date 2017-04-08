//
//  RalyasView.swift
//  LangApp
//
//  Created by Gordon Chi on 7/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RalyasView:UITableViewController {
    
    
    var arrayOfCellData = [cellData]()
    var username = String()
    var password = String()
    var storyboardSwitch:[String] = ["br1","br2","br3","br4","br5", "raylanEditor"]
    let scoreOnDatabase = FIRDatabase.database().reference()
    
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(text: "Class 1" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white), cellData(text: "Class 2" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white), cellData(text: "Class 3" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white), cellData(text: "Class 4" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white), cellData(text: "Class 5" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white), cellData(text: "Ralyan Text Editor" ,image: #imageLiteral(resourceName: "ralyas"), colour: UIColor.white)]
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! br1
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! br2
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! br3
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! br4
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 4:
            let viewController = storyboard?.instantiateViewController(withIdentifier: storyboardSwitch[indexPath.row]) as! br5
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        case 5:
            let viewController = storyboard?.instantiateViewController(withIdentifier: "ralyanEditor") as! ralyanEditor
            viewController.username = username
            viewController.password = password
            self.navigationController?.pushViewController(viewController, animated: true)
        default: break
            //nothing
        }

    }
    
    
}
