//
//  Dose.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 27/02/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specification fonctionnelle
//
//medicament: Dose -> String
//Le nom du medicament(get)
//
//quantity: Dose -> Integer
//La quantité du medicament prescrit (get/set)
//
//validated: Dose -> Boolean
//Indique si l’utilisateur a pris son/ses medicaments en quantité  (get/set)
//Ne peut etre vraie que si la date de la prescription dans laquelle il se trouve est passee

class DoseModel{
    private var dao: Dose
    
    var quantity: Int16{
        get{
            return self.dao.quantity
        }
        set{
            self.dao.quantity = newValue
        }
    }
    
    var validated: Bool{
        get{
            return self.dao.validated
        }
        set{
            self.dao.validated = newValue
        }
    }
    
    var medicament: Medicament?{
        get{
            return self.dao.medicament
        }
        set{
            self.dao.medicament = newValue
        }
    }
    
    var prescription: Prescription?{
        get{
            return self.dao.prescription
        }
        set{
            self.dao.prescription = newValue
        }
    }
    
    init(quantity: Int16, validated: Bool?){
        guard let dao = Dose.getNewDoseDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.quantity = quantity
        self.validated = validated!
        self.medicament = nil
        self.prescription = nil
    }
}

extension Dose{
    static func getNewDoseDao() -> Dose?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Dose", in: CoreDataManager.context) else{
            return nil
        }
        return Dose(entity: entity,insertInto: CoreDataManager.context)
    }
}
