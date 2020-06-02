//
//  HistoryDetailViewController.swift
//  minum
//
//  Created by Ihwan ID on 02/06/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "HistoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
    }
    
}

extension HistoryDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HistoryDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let drinks = CoreDataManager.shared.fetchDrinks()
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! HistoryDetailTableViewCell
//        let arr: [History] = (drinks!.last!.history!.allObjects as? [History])!
//    
//        cell.desc.text = "You drank \(arr.first!.amount) ml water"
//        cell.date.text = "\(drinks?.last?.date ?? "nodata")"
                 

        return cell
    }
    
    
    
}
