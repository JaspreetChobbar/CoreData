//
//  ViewController.swift
//  Cdata
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var serachBar: UISearchBar!
    
    var perArray = [Person]()
    
    var filterArray = [Person]()
    
    @IBOutlet weak var tableView: UITableView!
    
//    @IBAction func add(_ sender: Any) {
//
//        var nameTxt: UITextField?
//        var cityTxt: UITextField?
//
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
//
//
//        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void  in
//
//            let name = nameTxt?.text
//            let city = cityTxt?.text
//
//            if (name != nil && city != nil){
//                //self.appdelegate.insertRecord(name: name!, address: addres!)
//                self.fetchAndUpdateTable()
//            }
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
//
//            print("cancel")
//        })
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
//        alert.addTextField { (textField) in
//            nameTxt = textField
//            nameTxt?.placeholder = "add name"
//        }
//        alert.addTextField { (textField) in
//            cityTxt = textField
//            cityTxt?.placeholder = "add city"
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func fetchAndUpdateTable(){
        perArray = appdelegate.fetchRecords()
        filterArray = perArray
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        serachBar.delegate = self
        filterArray = perArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAndUpdateTable()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArray = searchText.isEmpty ? perArray : perArray.filter({ (personString: Person) -> Bool in
            
            return personString.name?.range(of: searchText, options:  .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellData
        let person = filterArray[indexPath.row]
        cell.name.text = person.name!
        cell.age.text = String(person.age)
        cell.tuition.text = String(person.tuition)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        cell.date.text = dateFormatter.string(from: person.date!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let person = perArray[indexPath.row]
            appdelegate.deleteRecord(person: person)
            fetchAndUpdateTable()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditPage") as! EditPage
        
        secondViewController.index = indexPath.row
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .none
//
//        let person = perArray[indexPath.row]
//
//        var nameTxt: UITextField?
//        var ageTxt: UITextField?
//        var tuitionTxt: UITextField?
//        var dateTxt: UITextField?
//
//        let alert = UIAlertController(title: "Update", message: "update the details", preferredStyle: .alert)
//
//
//        let ok = UIAlertAction(title: "update", style: .default, handler: { (action) -> Void  in
//
//            let name = nameTxt?.text
//            let age = ageTxt?.text
//            let tuition = tuitionTxt?.text
//            let date = dateTxt?.text
//
//            if (name != nil && age != nil && tuition != nil && date != nil){
//                self.appdelegate.updateRecord(person: person, name: name!, age: Int32(age!)!, tuition: Double(tuition!)!,date: dateFormatter.date(from: date!)!  )
//                self.fetchAndUpdateTable()
//            }
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
//
//            print("cancel")
//        })
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
//        alert.addTextField { (textField) in
//            nameTxt = textField
//            nameTxt?.placeholder = "add name"
//            nameTxt?.text = person.name
//        }
//        alert.addTextField { (textField) in
//            ageTxt = textField
//            ageTxt?.placeholder = "add age"
//            ageTxt?.text = String(person.age)
//        }
//        alert.addTextField { (textField) in
//            tuitionTxt = textField
//            tuitionTxt?.placeholder = "add tuition"
//            tuitionTxt?.text = String(person.tuition)
//        }
//        alert.addTextField { (textField) in
//            dateTxt = textField
//            dateTxt?.placeholder = "add date"
//            dateTxt?.text = dateFormatter.string(from: person.date!)
//        }
//        self.present(alert, animated: true, completion: nil)
//
        
        
    }
    
}
