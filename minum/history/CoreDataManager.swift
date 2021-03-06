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
    func createDrink(image: UIImage, amount: String) -> Drink? {
        let context = persistentContainer.viewContext
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd LLLL"
        let current_date = dateFormatter.string(from: date)
        
        let idFormatter = DateFormatter()
        idFormatter.dateFormat =  "yyyyMMdd"
        let id = idFormatter.string(from: date)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let imageData = image.jpegData(compressionQuality: 1.0)
        let history = History(context: context)
        history.amount = Int32(amount) ?? 0
        history.hours = "\(hour):\(minute)"
        history.photo = imageData
        
        let drinks = CoreDataManager.shared.fetchDrinks()
        
        if let object = drinks?.filter({ $0.id == id}).first {
            
            print("found")
            var arr: [History] = (object.history?.allObjects as? [History])!
            arr.append(history)
            object.history = NSSet.init(array: arr)
            
            do {
                try context.save()
                return object
            } catch let createError {
                print("Failed to create: \(createError)")
            }
        } else {
            print("not found")
            
            
            let drink = Drink(context: context)
            drink.id = id
            drink.date = current_date
            
           
            print("jam \(hour) : \(minute)")
            drink.history = NSSet.init(array: [history])
            do {
                try context.save()
                return drink
            } catch let createError {
                print("Failed to create: \(createError)")
            }
            
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
    
    
    func fetchDrink(withName id: String) -> Drink? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Drink>(entityName: "Drink")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
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
