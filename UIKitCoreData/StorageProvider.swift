//
//  StorageProvider.swift
//  CoreDataSwiftUI
//
//  Created by Eduardo Developer on 7/2/23.
//

import CoreData

final class StorageProvider{
    
    let persistentContainer: NSPersistentContainer
    
    static let shared: StorageProvider = StorageProvider(storeType: .inMemory)
    
    static var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "UIKitCoreData", withExtension: "momd") else {
            fatalError("Fail: locate momd file for my defined model of Core Data")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Fail: to load the momd file which contains  my defined model of Core Data")
        }
        return model
    }()
    
    init(storeType: StoreType) {
        persistentContainer = NSPersistentContainer(name: "UIKitCoreData", managedObjectModel: Self.managedObjectModel)
        if storeType == .inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        )
        // este parámetro de configuración aparece por defecto, significa que la información se graba a la vez en todos los niveles, puede darse el caso de tener un contexto padre y otros hijos, un cambio afecta a todos sin tener que hacer nada nosotros
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        // este parémetro de configuración es conveniente añadirlo, el hecho de estar aislado en un struct no le ocasiona problemas de compatibilidad. Ejemplo: si se modifican datos en dos contextos distintos con esto activado los datos se guardan de forma secuencial mas eficiente
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    enum StoreType {
        case inMemory, persisted
    }
    
}

extension ErrorModelLogic{
    enum Persistance: Error{
        case gameAlreadyExists
    }
}
