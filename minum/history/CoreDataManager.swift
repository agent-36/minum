//
//  CoreDataManager.swift
//  minum
//
//  Created by Ihwan ID on 27/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import CoreData
import UIKit

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "minum")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createDrink(image: UIImage, amount: Int) -> Drink? {
        let context = persistentContainer.viewContext
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd LLLL"
        let current_date = dateFormatter.string(from: date)
    
        let idFormatter = DateFormatter()
        idFormatter.dateFormat =  "yyyyMMdd"
        let id = dateFormatter.string(from: date)
        
        let drink = Drink(context: context)
        drink.id = id
        drink.date = current_date
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
       
        print("jam \(hour) : \(minute)")
        
        let imageData = image.jpegData(compressionQuality: 1.0)
        let history = History(context: context)
        history.amount = Int32(amount)
        history.hours = "\(hour):\(minute)"
        history.photo = imageData
        drink.history = NSSet.init(array: [history, history])

        do {
            try context.save()
            return drink
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchDrinks() -> [Drink]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Drink>(entityName: "Drink")

        do {
            let drinks = try context.fetch(fetchRequest)
            return drinks
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchHistories() -> [History]? {
           let context = persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<History>(entityName: "History")

           do {
               let histories = try context.fetch(fetchRequest)
               return histories
           } catch let fetchError {
               print("Failed to fetch companies: \(fetchError)")
           }

           return nil
       }

    func fetchDrink(withName name: String) -> Drink? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Drink>(entityName: "Drink")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let drinks = try context.fetch(fetchRequest)
            return drinks.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateDrink(drink: Drink) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteDrink(drink: Drink) {
        let context = persistentContainer.viewContext
        context.delete(drink)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

}
