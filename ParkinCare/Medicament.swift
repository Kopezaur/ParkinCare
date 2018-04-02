//
//  Medicament.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/23/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Medicament{
    static let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
    
    static func create() -> Medicament?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Medicament", in: CoreDataManager.context) else{
            return nil
        }
        return Medicament(entity: entity,insertInto: CoreDataManager.context)
    }
    
    static func create(medicament : Medicament){
        if self.count(medicament: medicament) > 1{
            CoreDataManager.context.delete(medicament)
        } else{
            CoreDataManager.save()
        }
    }
    
    static func count(medicament : Medicament) -> Int{
        let predicate = NSPredicate(format:"name == %@", medicament.name!)
        self.request.predicate = predicate
        do{
            return try CoreDataManager.context.count(for: self.request as! NSFetchRequest<NSFetchRequestResult>)
        }
        catch{
            fatalError()
        }
        
    }
    
    /// initialize a `Medicament`
    ///
    /// - Parameters:
    ///   - name: `String` name of `Medicament`
    convenience init(name: String){
        self.init(context: CoreDataManager.context)
        self.name  = name
    }

}
