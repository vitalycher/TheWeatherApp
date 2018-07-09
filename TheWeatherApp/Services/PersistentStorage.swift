//
//  PersistentStorage.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 07.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import CoreData

final class PersistentStorage {

    static let shared = PersistentStorage()

    var objectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherAppModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func forecast() -> Forecast? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Forecast")
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = ["weatherDetails", "weatherDetails.generalWeatherParameters"]
        do {
            let result = try objectContext.fetch(request)
            return result.first as? Forecast
        } catch {
            print(error)
        }
        return nil
    }

    func reset() {
        do {
            let forecasts = try objectContext.fetch(Forecast.fetchRequest()) as? [Forecast]
            forecasts?.forEach { $0.managedObjectContext?.delete($0) }
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func saveContext() {
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
