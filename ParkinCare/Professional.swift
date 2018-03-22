//
//  ProfessionalDTO.swift
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
    
    static func delete(professional : Professional){
        CoreDataManager.context.delete(professional)
        CoreDataManager.save()
    }
    
    static func getAll() -> [ProfessionalModel]{
        var results : [ProfessionalModel] = []
        var fetchedResults : [Professional] = []
        do{
            try fetchedResults = CoreDataManager.context.fetch(request)
            
            if let result = fetchedResults as? [Professional]
            {
                for object in result {
                    let pModel = ProfessionalModel(professional: object)
                    results.append(pModel)
                }
            }

        }
        catch let error as NSError{
            // to be done
        }

        return results
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
