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
    
//    static func getNewProfessionalDao() -> Professional?{
//        guard let entity = NSEntityDescription.entity(forEntityName: "Professional", in: CoreDataManager.context) else{
//            return nil
//        }
//        return Professional(entity: entity,insertInto: CoreDataManager.context)
//    }

}
