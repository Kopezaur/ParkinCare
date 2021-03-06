//
//  PrescriptionDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class PrescriptionDAO{
    static let request : NSFetchRequest<Prescription> = Prescription.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(prescription: Prescription){
        CoreDataManager.context.delete(prescription)
    }
    static func fetchAll() -> [Prescription]?{
        self.request.predicate = nil
        do{
            request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Prescription.dateTime),ascending:true)]
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
    
    static private func createPrescription() -> Prescription{
        return Prescription(context: CoreDataManager.context)
    }
    
    static func createPrescription(dateTime: NSDate, dateTimeReminder: NSDate, observations: String, validated: Bool?) -> Prescription{
        let dao = self.createPrescription()
        dao.dateTime = dateTime
        dao.dateTimeReminder = dateTimeReminder
        dao.validated = validated!
        dao.doses = []
        return dao
    }
    
    static func createPrescription(prescription: Prescription) -> Prescription{
        let dao = self.createPrescription()
        dao.dateTime = prescription.dateTime
        dao.dateTimeReminder = prescription.dateTimeReminder
        dao.validated = prescription.validated
        dao.doses = []
        return dao
    }
    
    static func count(dateTime: NSDate) -> Int{
        self.request.predicate = NSPredicate(format: "dateTime == %@", dateTime)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(prescription: Prescription) -> Int{
        self.request.predicate = NSPredicate(format: "dateTime == %@", prescription.dateTime!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(prescription: Prescription) -> Prescription?{
        self.request.predicate = NSPredicate(format: "dateTime == %@", prescription.dateTime!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Prescription]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(dateTime: Date) -> [Prescription]?{
        let calendar = Calendar.current
        var beginDay: Date = calendar.date(bySetting: .hour, value: 2, of: dateTime)!
        beginDay = calendar.date(bySetting: .minute, value: 0, of: beginDay)!
        
        var endDay: Date = calendar.date(bySetting: .hour, value: 23, of: dateTime)!
        endDay = calendar.date(byAdding: .hour, value: 2, to: endDay)!
        endDay = calendar.date(bySetting: .minute, value: 59, of: endDay)!
        
        self.request.predicate = NSPredicate(format: "dateTime >= %@ AND dateTime <= %@", beginDay as NSDate, endDay as NSDate)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Prescription]
            return result
        }
        catch{
            return nil
        }
    }
    
    static func add(prescription: Prescription){
        if let _ = self.search(prescription: prescription){} else{
            let _ = self.createPrescription(prescription: prescription)
            self.save()
        }
    }
}



