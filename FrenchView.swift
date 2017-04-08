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
    var storyboardSwitch:[String] = ["bf1","bf2","bf3", "bf4"]
    var colours:[UIColor] = [UIColor.white,UIColor.white,UIColor.white, UIColor.white]
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(text: "Class 1" ,image: #imageLiteral(resourceName: "france"), colour: self.colours[0]), cellData(text: "Class 2" ,image: #imageLiteral(resourceName: "france"), colour: self.colours[1]), cellData(text: "Class 3" ,image: #imageLiteral(resourceName: "france"), colour: self.colours[2]), cellData(text: "Class 4" ,image: #imageLiteral(resourceName: "france"), colour: self.colours[3])]
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
        return 49 //tight fit is 44
    }
    
    
}
