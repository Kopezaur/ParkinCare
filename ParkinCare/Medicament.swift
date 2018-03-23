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
    
    static func search(medicament: MedicamentModel) -> Medicament? {
        self.request.predicate = NSPredicate(format:"name == %@", medicament.name!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func delete(medicamentModel : MedicamentModel){
        if let medicament: Medicament = self.search(medicament: medicamentModel){
            CoreDataManager.context.delete(medicament)
            CoreDataManager.save()
        }
    }
    
    static func getAll() -> [MedicamentModel]{
        var results : [MedicamentModel] = []
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return [] }
            for object in result {
                let model = MedicamentModel(medicament: object)
                results.append(model)
            }
        }
        catch{
            return []
        }
        return results
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
