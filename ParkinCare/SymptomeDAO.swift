//
//  SymptomeDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/31/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class SymptomeDAO{
    static let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(symptome: Symptome){
        CoreDataManager.context.delete(symptome)
    }
    static func fetchAll() -> [Symptome]?{
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
    
    static private func createSymptome() -> Symptome{
        return Symptome(context: CoreDataManager.context)
    }
    
    static func createSymptome(name: String) -> Symptome{
        let dao = self.createSymptome()
        dao.name  = name
        return dao
    }
    
    static func createSymptome(symptome: Symptome) -> Symptome{
        let dao = self.createSymptome()
        dao.name = symptome.name
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
    
    static func count(symptome: Symptome) -> Int{
        self.request.predicate = NSPredicate(format: "name == %@", symptome.name!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(symptome: Symptome) -> Symptome?{
        self.request.predicate = NSPredicate(format: "name == %@", symptome.name!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(name: String) -> Symptome?{
        self.request.predicate = NSPredicate(format: "name == %@", name)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(symptome: Symptome){
        if let _ = self.search(symptome: symptome){} else{
            let _ = self.createSymptome(symptome: symptome)
            self.save()
        }
    }
}



