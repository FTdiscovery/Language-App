//
//  ChineseView.swift
//  LangApp
//
//  Created by Gordon Chi on 7/2/2017.
//  Copyright © 2017 Salt Studios. All rights reserved.
//

import Foundation
import UIKit

class ChineseView:UITableViewController {
    
    
    var arrayOfCellData = [cellData]()
    var username = String()
    var password = String()
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(text: "Class 1" ,image: #imageLiteral(resourceName: "taiwan"), colour: UIColor.white), cellData(text: "Class 2" ,image: #imageLiteral(resourceName: "taiwan"), colour: UIColor.white), cellData(text: "Class 3" ,image: #imageLiteral(resourceName: "taiwan"), colour: UIColor.green), cellData(text: "Class 4" ,image: #imageLiteral(resourceName: "taiwan"), colour: UIColor.green), cellData(text: "Class 5" ,image: #imageLiteral(resourceName: "taiwan"), colour: UIColor.green)]
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
    
    
}
