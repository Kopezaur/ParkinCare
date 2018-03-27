//
//  DoseDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class DoseDAO{
    static let request : NSFetchRequest<Dose> = Dose.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(dose: Dose){
        CoreDataManager.context.delete(dose)
    }
    static func fetchAll() -> [Dose]?{
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
    
    static private func createDose() -> Dose{
        return Dose(context: CoreDataManager.context)
    }
    
    static func createDose(medName: String, quantity: Int16, validated: Bool?) -> Dose{
        let dao = self.createDose()
        dao.medName = medName
        dao.quantity  = quantity
        dao.validated = validated!
        return dao
    }
    
    static func createDose(dose :Dose) -> Dose{
        let dao = self.createDose()
        dao.medName = dose.medName
        dao.quantity  = dose.quantity
        dao.validated = dose.validated
        return dao
    }
    
    static func count(medName: String, quantity: Int16) -> Int{
        self.request.predicate = NSPredicate(format: "medName == %@ AND quantity == %@", medName, quantity)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(dose: Dose) -> Int{
        self.request.predicate = NSPredicate(format: "medName == %@ AND quantity == %@", dose.medName!, dose.quantity)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(dose: Dose) -> Dose?{
        self.request.predicate = NSPredicate(format: "medName == %@ AND quantity == %@", dose.medName!, dose.quantity)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Dose]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(medName: String, quantity: Int16) -> Dose?{
        self.request.predicate = NSPredicate(format: "medName == %@ AND quantity == %@", medName, quantity)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Dose]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(dose: Dose){
        if let _ = self.search(dose: dose){} else{
            let _ = self.createDose(dose: dose)
            self.save()
        }
    }
}





