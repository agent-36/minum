//
//  HistoryViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTable.dataSource = self
        historyTable.delegate = self
        historyTable.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
    
    }
    
    func applicationDirectoryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if (segue.identifier == "toDetail") {
               let vc = segue.destination as! HistoryDetailViewController
                vc.id = "20200602"
           }
    }
}


extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: self)
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = CoreDataManager.shared.fetchDrinks()
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drinks = CoreDataManager.shared.fetchDrinks()
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        let arr: [History] = (drinks!.last!.history!.allObjects as? [History])!
    
        cell.desc.text = "You drank \(arr.first!.amount) ml water"
        cell.date.text = "\(drinks?.last?.date ?? "nodata")"
                 

        return cell
    }
    
    
    
}
