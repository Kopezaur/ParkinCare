//
//  professionalDAO.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 24/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class ProfessionalDAO{
    static let request : NSFetchRequest<Professional> = Professional.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(professional: Professional){
        CoreDataManager.context.delete(professional)
    }
    static func fetchAll() -> [Professional]?{
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
    
    static private func createProfessional() -> Professional{
        return Professional(context: CoreDataManager.context)
    }
    
    static func createProfessional(lastname: String, firstname: String, title: String, organization: String, email: String, numTel:String) -> Professional{
        let dao        = self.createProfessional()
        dao.lastname  = lastname
        dao.firstname = firstname
        dao.title = title
        dao.organization = organization
        dao.email = email
        dao.numTel = numTel
        return dao
    }
    
    static func createProfessional(professional :Professional) -> Professional{
        let dao        = self.createProfessional()
        dao.lastname  = professional.lastname
        dao.firstname = professional.firstname
        dao.title = professional.title
        dao.organization = professional.organization
        dao.email = professional.email
        dao.numTel = professional.numTel
        return dao
    }
    
    static func count(firstname: String, lastname: String) -> Int{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(professional: Professional) -> Int{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", professional.firstname!, professional.lastname!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(professional: Professional) -> Professional?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", professional.firstname!, professional.lastname!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Professional]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(lastname: String, firstname: String) -> Professional?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Professional]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(professional: Professional){
        if let _ = self.search(professional: professional){} else{
            let _ = self.createProfessional(professional: professional)
            self.save()
        }
    }
}
