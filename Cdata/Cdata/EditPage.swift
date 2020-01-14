//
//  EditPage.swift
//  Cdata
//
//  Created by MacStudent on 2020-01-14.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit

class EditPage: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var tuition: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    var index = 0
    
    var perArray = [Person]()
    
     let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perArray = appdelegate.fetchRecords()
        
        name.text = perArray[index].name
        age.text = String(perArray[index].age)
        tuition.text = String(perArray[index].tuition)
        date.setDate(perArray[index].date!, animated: true)
        
        
    }
    
    @IBAction func update(_ sender: Any) {
        

        self.appdelegate.updateRecord(person: perArray[index], name: name.text!, age: Int32(age.text!)!, tuition: Double(tuition.text!)!,date: date.date  )

        if let navController = self.navigationController {
                   navController.popViewController(animated: true)
               }
        
    }
    
}
