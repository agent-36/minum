//
//  HistoryViewController.swift
//  minum
//
//  Created by Ihwan ID on 12/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
DemoCoreData()
    }
    
    
    
}

func DemoCoreData() {
    // Create
    guard let newDrink = CoreDataManager.shared.createDrink(date: Date()) else { return }
    print("Created \(newDrink)")

    // Read

    guard let drinks = CoreDataManager.shared.fetchDrinks() else { return }

    

    print("Number : \(drinks)")
    print("Number hours: \(String(describing: drinks[1].history?.hours))")
    print("Number drinks: \(drinks.count)")
}

extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
                   
            
                 
        return cell
    }
    
    
}
