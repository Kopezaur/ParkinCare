//
//  TitleDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/31/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class TitleDAO{
    static let request : NSFetchRequest<Title> = Title.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(title: Title){
        CoreDataManager.context.delete(title)
    }
    static func fetchAll() -> [Title]?{
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
    
    static private func createTitle() -> Title{
        return Title(context: CoreDataManager.context)
    }
    
    static func createTitle(name: String) -> Title{
        let dao = self.createTitle()
        dao.name  = name
        return dao
    }
    
    static func createTitle(title: Title) -> Title{
        let dao = self.createTitle()
        dao.name = title.name
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
    
    static func count(title: Title) -> Int{
        self.request.predicate = NSPredicate(format: "name == %@", title.name!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(title: Title) -> Title?{
        self.request.predicate = NSPredicate(format: "name == %@", title.name!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Title]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(name: String) -> Title?{
        self.request.predicate = NSPredicate(format: "name == %@", name)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Title]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(name: String){
        if let _ = self.search(name: name){} else{
            let _ = self.createTitle(name: name)
            self.save()
        }
    }
}



