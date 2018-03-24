//
//  Professional.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Professional{
    static let request : NSFetchRequest<Professional> = Professional.fetchRequest()
    
    static func create() -> Professional?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Professional", in: CoreDataManager.context) else{
            return nil
        }
        return Professional(entity: entity,insertInto: CoreDataManager.context)
    }
    
    static func create(professional : Professional){
        if self.count(professional: professional) > 1{
            CoreDataManager.context.delete(professional)
        } else{
            CoreDataManager.save()
        }
    }
    
    static func count(professional : Professional) -> Int{
        let predicate = NSPredicate(format:"firstname == %@ AND lastname == %@", professional.firstname!, professional.lastname!)
        self.request.predicate = predicate
        do{
            return try CoreDataManager.context.count(for: self.request as! NSFetchRequest<NSFetchRequestResult>)
        }
        catch{
            fatalError()
        }
        
    }
    
    static func search(professional: Professional) -> Professional? {
        self.request.predicate = NSPredicate(format:"firstname == %@ AND lastname == %@", professional.firstname!, professional.lastname!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Professional]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func delete(professional: Professional){
        CoreDataManager.context.delete(professional)
    }
    
    static func getAll() -> [Professional]!{
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Professional.lastname),ascending:true),NSSortDescriptor(key:#keyPath(Professional.firstname),ascending:true)]
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return []
        }
    }
    
    /// initialize a `Professional`
    ///
    /// - Parameters:
    ///   - lastname: `String` last name of `Professional`
    ///   - firstname:  `String` first name of `Professional`
    ///   - title: `String` title of `Professional`
    convenience init(lastname: String, firstname: String, title: String, organization: String, email: String, numTel: String){
        self.init(context: CoreDataManager.context)
        self.lastname  = lastname
        self.firstname = firstname
        self.title = title
        self.organization = organization
        self.email = email
        self.numTel = numTel
    }
    
//    static func getNewProfessionalDao() -> Professional?{
//        guard let entity = NSEntityDescription.entity(forEntityName: "Professional", in: CoreDataManager.context) else{
//            return nil
//        }
//        return Professional(entity: entity,insertInto: CoreDataManager.context)
//    }

}

