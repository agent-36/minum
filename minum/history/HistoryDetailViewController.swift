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
    
    var id: String!
    
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
        let data = CoreDataManager.shared.fetchDrink(withName: id)
        return data?.history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = CoreDataManager.shared.fetchDrink(withName: id)
        let history: [History] = (data!.history!.allObjects as? [History])!
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! HistoryDetailTableViewCell
       
        cell.desc.text = "You drink \(history[indexPath.row].amount) water"
        cell.hour.text = "\(history[indexPath.row].hours!)"
        cell.photo.image = UIImage(data: history[indexPath.row].photo!)

        return cell
    }
    
    
    
}
