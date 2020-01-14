//
//  NewPage.swift
//  Cdata
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit

class NewPage: UIViewController {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var tuition: UITextField!
    @IBOutlet weak var startdate: UIDatePicker!
    
    @IBAction func save(_ sender: Any) {
        
        self.appdelegate.insertRecord(name: name.text!, age: Int32(age.text!)!, tuition: Double(tuition.text!)!,date: startdate.date  )
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
}
