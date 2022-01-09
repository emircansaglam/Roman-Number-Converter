//
//  FavoriVC.swift
//  romanConverter
//
//  Created by Emircan saglam on 9.01.2022.
//

import UIKit
import CoreData

class FavoriVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var romanArr = [String]()
    var favArr = [String]()
    var idArr : [UUID]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate  = self
        tableView.dataSource = self
        
        getData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = favArr[indexPath.row] + " - " + romanArr[indexPath.row]
        return cell
    }
    
    @objc func getData(){
        favArr.removeAll(keepingCapacity: false)
        idArr?.removeAll(keepingCapacity: false)
        romanArr.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoriler")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let normalNumb = result.value(forKey: "normalNumb") as? String{
                        self.favArr.append(normalNumb)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArr?.append(id)
                    }
                    if let romanNumb = result.value(forKey: "romanNumb") as? String{
                        self.romanArr.append(romanNumb)
                    }
                    self.tableView.reloadData()
                }
            }
            
            
        }catch{
            print("error")
        }
    }

}
