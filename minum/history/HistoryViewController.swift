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
    var fetchedResultsController: NSFetchedResultsController<Drink>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.dataSource = self
        historyTable.delegate = self
        historyTable.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        DemoCoreData()
    }
    
    func applicationDirectoryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
    }
}



func DemoCoreData() {
    // Create
    guard let newDrink = CoreDataManager.shared.createDrink(date: Date().addingTimeInterval(5 * 60 * 24 * 100)) else { return }

    guard let drinks = CoreDataManager.shared.fetchDrinks() else { return }

    guard let histories = CoreDataManager.shared.fetchHistories() else { return }
    for history in histories{
        print("jumlah \(history.ofDrink?.date),, \(history.amount)")
    }
}

extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        let drinks: [Drink] = CoreDataManager.shared.fetchDrinks()!
//    let dateFormatterPrint = DateFormatter()
//    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//        ///let drink = fetchedResultsController.object(at: indexPath)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        cell.textLabel?.text = "\(dateFormatterPrint.string(from: drinks?.last?.date ?? Date()) )"
//
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
                
        cell.desc.text = "You drank 1980 ml water"
        cell.date.text = "today"
                 

        return cell
    }
    
    
    
}
