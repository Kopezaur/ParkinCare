//
//  MedicamentDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/26/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class MedicamentDAO{
    static let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(medicament: Medicament){
        CoreDataManager.context.delete(medicament)
    }
    static func fetchAll() -> [Medicament]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static private func createMedicament() -> Medicament{
        return Medicament(context: CoreDataManager.context)
    }
    
    static func createMedicament(name: String) -> Medicament{
        let dao = self.createMedicament()
        dao.name  = name
        return dao
    }
    
    static func createMedicament(medicament: Medicament) -> Medicament{
        let dao = self.createMedicament()
        dao.name = medicament.name
        return dao
    }
    
    static func count(name: String) -> Int{
        self.request.predicate = NSPredicate(format: "name == %@", name)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(medicament: Medicament) -> Int{
        self.request.predicate = NSPredicate(format: "name == %@", medicament.name!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(medicament: Medicament) -> Medicament?{
        self.request.predicate = NSPredicate(format: "name == %@", medicament.name!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(name: String) -> Medicament?{
        self.request.predicate = NSPredicate(format: "name == %@", name)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(name: String){
        if let _ = self.search(name: name){} else{
            let _ = self.createMedicament(name: name)
            self.save()
        }
    }
}

