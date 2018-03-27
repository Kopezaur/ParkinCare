//
//  ActivityDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class ActivityDAO{
    static let request : NSFetchRequest<Activity> = Activity.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(activity: Activity){
        CoreDataManager.context.delete(activity)
    }
    static func fetchAll() -> [Activity]?{
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
    
    static private func createActivity() -> Activity{
        return Activity(context: CoreDataManager.context)
    }
    
    static func createActivity(dateTime: NSDate, dateTimeReminder: NSDate, title: String, desc: String, validated: Bool?) -> Activity{
        let dao = self.createActivity()
        dao.dateTime = dateTime
        dao.dateTimeReminder  = dateTimeReminder
        dao.title = title
        dao.desc = desc
        dao.validated = validated!
        return dao
    }
    
    static func createActivity(activity :Activity) -> Activity{
        let dao = self.createActivity()
        dao.dateTime = activity.dateTime
        dao.dateTimeReminder  = activity.dateTimeReminder
        dao.title = activity.title
        dao.desc = activity.desc
        dao.validated = activity.validated
        return dao
    }
    
    static func count(title: String) -> Int{
        self.request.predicate = NSPredicate(format: "title == %@", title)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(activity: Activity) -> Int{
        self.request.predicate = NSPredicate(format: "title == %@ AND dateTime == %@", activity.title!, activity.dateTime!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(activity: Activity) -> Activity?{
        self.request.predicate = NSPredicate(format: "title == %@ AND dateTime == %@", activity.title!, activity.dateTime!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activity]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(title: String) -> Activity?{
        self.request.predicate = NSPredicate(format: "title == %@", title)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activity]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(activity: Activity){
        if let _ = self.search(activity: activity){} else{
            let _ = self.createActivity(activity: activity)
            self.save()
        }
    }
}







