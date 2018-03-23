//
//  Medicaments.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 27/02/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specifications fonctionnelles
//
//addMedicament: Medicaments x Dose -> Medicaments
//Ajoute une dose de medicament
//
//delMedicament: Medicaments x Dose -> Medicaments
//Pre : La dose de medicament doit etre present dans les medicaments
//Supprime des medicaments la ose de medicament en entre
//
//makeIterator: Medicament -> ItMedicament
//Cree un iterator pour les medicaments

class MedicamentModel{
    private var dao: Medicament
    
    var name: String?{
        get{
            return self.dao.name
        }
        set{
            self.dao.name = newValue
        }
    }
    
//    var dose: Dose?{
//        get{
//            return self.dao.dose
//        }
//        set{
//            self.dao.dose = newValue
//        }
//    }
    
    func save(){
        if let medicament = Medicament.search(medicament: self){
            medicament.name = self.name
            CoreDataManager.save()
        }
    }

    // MARK: - Constructors -
    
    init(name: String){
        guard let dao = Medicament.create() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.name = name
    }
    
    init(medicament: Medicament){
        self.dao = medicament
    }
    
    // -- MARK: - Equatable functions -
    
    static func == (lhs: MedicamentModel, rhs: MedicamentModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func != (lhs: MedicamentModel, rhs: MedicamentModel) -> Bool {
        return !(lhs == rhs)
    }

}

