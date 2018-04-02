//
//  CoreDataManager.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/26/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "parking_reminder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var objectContext: NSManagedObjectContext {return persistentContainer.viewContext}
    var fetchedRC: NSFetchedResultsController<Reminder>!
    
    func fetchReminders() {
        let request = Reminder.fetchRequest() as NSFetchRequest<Reminder>
        let sortType = NSSortDescriptor(key: #keyPath(Reminder.type), ascending: true)
        request.sortDescriptors = [sortType]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: objectContext, sectionNameKeyPath: #keyPath(Reminder.type), cacheName: nil)
            try fetchedRC.performFetch()
            fetchedRC.delegate = self
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteObjectAtIndexPath(indexPath: IndexPath) {
        let object = fetchedRC.object(at: indexPath)
        objectContext.delete(object)
        do {
            try objectContext.save()
        } catch {
            let err = error as NSError
            fatalError("Unresolved error \(err), \(err.userInfo)")
        }
    }
    
    func saveContext() {
        if objectContext.hasChanges {
            do {
                try objectContext.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved error \(err), \(err.userInfo)")
            }
        }
    }
}

extension CoreDataManager: NSFetchedResultsControllerDelegate {
    
}
