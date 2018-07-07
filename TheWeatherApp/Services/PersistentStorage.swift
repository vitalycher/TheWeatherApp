//
//  PersistentStorage.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

class PersistentStorage {

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataProj")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
