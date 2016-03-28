//
//  DataManager.swift
//  WeCenterMobile
//
//  Created by Darren Liu on 15/10/7.
//  Copyright (c) 2015年 BetaTech. All rights reserved.
//

import CoreData
import Foundation

class DataManager: NSObject {
    required init?(name: String?) {
        super.init()
        managedObjectModel = NSManagedObjectModel(contentsOfURL: NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!)
        if managedObjectModel == nil {
            return nil
        }
        if name != nil {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            let directory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last! as NSURL
            
            
            let url = directory.URLByAppendingPathComponent(name! + ".sqlite")
            var error: NSError? = nil
            if let _=try? persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
                {
                let dict = NSMutableDictionary()
                dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data."
                dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data."
                dict[NSUnderlyingErrorKey] = error
                error = NSError(
                    domain: NetworkManager.defaultManager!.website,
                    code: 0,
                    userInfo: dict as [NSObject: AnyObject])
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                return nil
            }
            managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            managedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        }
    }
    private static var _defaultManager: DataManager! = nil
    //private static var _temporaryManager: DataManager! = nil
    static var defaultManager: DataManager! { // for creating cached objects
        get {
            if _defaultManager == nil {
                _defaultManager = DataManager(name: "Model")
            }
            return _defaultManager
        }
        set {
            _defaultManager = newValue
        }
    }
//    static var temporaryManager: DataManager! { // for creating temporary objects
//        get {
//            if _temporaryManager == nil {
//                _temporaryManager = DataManager(name: nil)
//            }
//            return _temporaryManager
//        }
//        set {
//            _temporaryManager = newValue
//        }
//    }
    func create(entityName: String) -> DataObject {
        let entity = managedObjectModel.entitiesByName[entityName]!
        return DataObject(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }
    func fetch(entityName: String, ID: NSNumber, error: NSErrorPointer) -> DataObject? {
        let request = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id = %@", ID)
        request.fetchLimit = 1
        let results = try? managedObjectContext?.executeFetchRequest(request)
        if results != nil && results!!.count != 0 {
            return results!![0] as? DataObject
        } else {
            if error != nil && error.memory == nil {
                error.memory = NSError(domain: "", code: 0, userInfo: nil) // Needs specification
            }
            return nil
        }
    }
    func fetchAll(entityName: String, error: NSErrorPointer) -> [DataObject] {
        let request = NSFetchRequest(entityName: entityName)
        let results = try? managedObjectContext?.executeFetchRequest(request)
        if results != nil {
            return results as! [DataObject]
        } else {
            if error != nil && error.memory == nil {
                error.memory = NSError(domain: "", code: 0, userInfo: nil) // Needs specification
            }
            return []
        }
    }
    func autoGenerate(entityName: String, ID: NSNumber) -> DataObject {
        var object = fetch(entityName, ID: ID, error: nil)
        if object == nil {
            object = create(entityName)
            object!.setValue(ID, forKey: "id")
        }
        return object!
    }
    func deleteAllObjectsWithEntityName(entityName: String) {
        //managedObjectContext?.msr_deleteAllObjectsWithEntityName(entityName)
        var error: NSError?
        let request = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(value: true)
        let results = try? managedObjectContext?.executeFetchRequest(request)
        if results != nil {
            for r in results!! {
                managedObjectContext!.deleteObject(r as! NSManagedObject)
            }
        } else {
            if error != nil {
                error = NSError(domain: "清空表\(entityName)错误", code: 0, userInfo: nil)
                print(error)
            }
        }
        
    }
    func saveChanges() {
        if managedObjectContext?.hasChanges ?? false {
            do
            {
                try! managedObjectContext?.save()
            }
        }
    }
    var managedObjectModel: NSManagedObjectModel!
    var managedObjectContext: NSManagedObjectContext?
}
