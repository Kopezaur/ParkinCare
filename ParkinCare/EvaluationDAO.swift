//
//  EvaluationDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class EvaluationDAO{
    static let request : NSFetchRequest<Evaluation> = Evaluation.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(evaluation: Evaluation){
        CoreDataManager.context.delete(evaluation)
    }
    static func fetchAll() -> [Evaluation]?{
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
    
    static private func createEvaluation() -> Evaluation{
        return Evaluation(context: CoreDataManager.context)
    }
    
    static func createEvaluation(dateTime: NSDate, dateTimeReminder: NSDate, symptome: Symptome, rating: Double, extraEvent: String, validated: Bool?) -> Evaluation{
        let dao = self.createEvaluation()
        dao.dateTime = dateTime
        dao.dateTimeReminder  = dateTimeReminder
        dao.symptome = symptome
        dao.rating = rating
        dao.extraEvent = extraEvent
        dao.validated = validated!
        return dao
    }
    
    static func createEvaluation(evaluation :Evaluation) -> Evaluation{
        let dao = self.createEvaluation()
        dao.dateTime = evaluation.dateTime
        dao.dateTimeReminder  = evaluation.dateTimeReminder
        dao.symptome = evaluation.symptome
        dao.rating = evaluation.rating
        dao.extraEvent = evaluation.extraEvent
        dao.validated = evaluation.validated
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
    
    static func count(evaluation: Evaluation) -> Int{
        self.request.predicate = NSPredicate(format: "dateTime == %@", evaluation.dateTime!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(evaluation: Evaluation) -> Evaluation?{
        self.request.predicate = NSPredicate(format: "dateTime == %@", evaluation.dateTime!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evaluation]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(dateTime: NSDate) -> Evaluation?{
        self.request.predicate = NSPredicate(format: "dateTime == %@", dateTime)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evaluation]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(evaluation: Evaluation){
        if let _ = self.search(evaluation: evaluation){} else{
            let _ = self.createEvaluation(evaluation: evaluation)
            self.save()
        }
    }
}







