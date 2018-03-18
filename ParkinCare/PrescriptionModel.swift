//
//  Prescription.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specifications fonctionelles :
//
//dateTime: Prescription -> DateTime
//La date et l’heure à laquelle l’utilisateur doit prendre ses medicaments (get/set)
//
//medicaments: Prescription -> Medicaments
//Les medicaments que doit prendre l’utilisateur (get/set)
//
//changeDateTime: Prescription x DateTime -> Prescription
//Pre : la date entre doit etre superieur a la date du jour
//Change la date de la description
//
//prescValidated: Prescription -> Boolean
//Retourne vraie si toute les doses ont ete validees
//
//isPartForgotten: Prescription -> Boolean
//Retourne vraie si au moins un medicament a ete oublie
//
//snooze: Prescription x Integer -> Prescription
//Pre: l’entier doit etre compris strict entre 0 et 60
//Decaler le rappelle de x minutes avec x l’entier entre
//
//reminder: Prescription -> Boolean
//Indique si la prescription doit etre rappele



class PrescriptionModel{
    private var dao : Prescription
    
    var dateTime: NSDate?{
        get{
            return self.dao.dateTime
        }
        set{
            self.dao.dateTime = newValue
        }
    }
    
    var dateTimeReminder: NSDate?{
        get{
            return self.dao.dateTimeReminder
        }
        set{
            self.dao.dateTimeReminder = newValue
        }
    }
    
    
    var observations: String?{
        get{
            return self.dao.observations
        }
        set{
            self.dao.observations = newValue
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
    
    var doses: NSSet?{
        get{
            guard let doses = self.dao.doses else{
                fatalError()
            }
            return doses
        }
        set{
            self.dao.doses = newValue
        }
    }
    
    var user: User?{
        get{
            return self.dao.user
        }
        set{
            self.dao.user = newValue
        }
    }
    
    init(dateTime: NSDate, dateTimeReminder: NSDate, observations: String, validated: Bool?){
        guard let dao = Prescription.getNewPrescriptionDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.dao.dateTime = dateTime
        self.dao.dateTimeReminder = dateTimeReminder
        self.observations = observations
        self.validated = validated!
        self.doses = []
        self.user = nil
    }
}

extension Prescription{
    static func getNewPrescriptionDao() -> Prescription?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Prescription", in: CoreDataManager.context) else{
            return nil
        }
        return Prescription(entity: entity, insertInto: CoreDataManager.context)
    }
}
