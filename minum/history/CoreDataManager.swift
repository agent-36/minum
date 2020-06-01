//
//  CoreDataManager.swift
//  minum
//
//  Created by Ihwan ID on 27/05/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import CoreData

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
    func createDrink(date: Date) -> Drink? {
        let context = persistentContainer.viewContext
        
        let drink = NSEntityDescription.insertNewObject(forEntityName: "Drink", into: context) as! Drink // NSManagedObject

        drink.date = date
        drink.history
        
//        drink.history?.hours = "17:00"
//        drink.history?.total = 120
        

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
