//
//  RDVDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/26/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class RDVDAO{
    static let request : NSFetchRequest<RDV> = RDV.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(rdv: RDV){
        CoreDataManager.context.delete(rdv)
    }
    static func fetchAll() -> [RDV]?{
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
    
    static private func createRDV() -> RDV{
        return RDV(context: CoreDataManager.context)
    }
    
    static func createRDV(dateTime: NSDate, dateTimeReminder: NSDate, location: String) -> RDV{
        let dao = self.createRDV()
        dao.dateTime  = dateTime
        dao.dateTimeReminder = dateTimeReminder
        dao.location = location
        dao.user = nil
        dao.professional = nil
        return dao
    }
    
    static func createRDV(rdv: RDV) -> RDV{
        let dao = self.createRDV()
        dao.dateTime  = rdv.dateTime
        dao.dateTimeReminder = rdv.dateTimeReminder
        dao.location = rdv.location
        dao.user = nil
        dao.professional = nil
        return dao
    }
    
    static func count(dateTime: NSDate, location: String) -> Int{
        self.request.predicate = NSPredicate(format: "dateTime == %@ AND location == %@", dateTime, location)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(rdv: RDV) -> Int{
        self.request.predicate = NSPredicate(format: "dateTime == %@ AND location == %@", rdv.dateTime!, rdv.location!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(rdv: RDV) -> RDV?{
        self.request.predicate = NSPredicate(format: "dateTime == %@ AND location == %@", rdv.dateTime!, rdv.location!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [RDV]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(location: String) -> RDV?{
        self.request.predicate = NSPredicate(format: "location == %@", location)
        do{
            let result = try CoreDataManager.context.fetch(request) as [RDV]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(rdv: RDV){
        if let _ = self.search(rdv: rdv){} else{
            let _ = self.createRDV(rdv: rdv)
            self.save()
        }
    }
}
