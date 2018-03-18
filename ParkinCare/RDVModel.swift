//
//  RendezVous.swift
//  ParkinCare
//
//  Created by Polytech on 27/02/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData 

// ----- Specifications fonctionnelles
//
// dateTime : RendezVous -> DateTime
// La date et l’heure du rendez vous (get/set)
//
// professional : RendezVous -> Professionnal
// Le professionnel avec qui le patient a rendez vous (get)
//
// dateTimeReminder : RendezVous -> DateTime
// Pre: la date et l’heure renvoyees doivent etre inferieures a la date et a l’heure du rendez vous
// La date et l’heure du rappel (get/set)
//
// setTimeBeforeRemind: RendezVous x Time -> RendezVous
// Pre : Le temps entre ne peut exceder 2 heures
// Change l’heure de rappel du rendez vous avec l’heure du rendez vous moins le temps entre en parametre
//
// reminder: RendezVous -> Boolean
// Indique si le rendez-vous doit etre rappele


class RDVModel{
    private var dao : RDV
    
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
    
    var location: String?{
        get{
            return self.dao.location
        }
        set{
            self.dao.location = newValue
        }
    }
    
    var professional: Professional?{
        get{
            return self.dao.professional
        }
        set{
            self.dao.professional = newValue
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
    
    init(dateTime: NSDate, dateTimeReminder: NSDate, location: String){
        guard let dao = RDV.getNewRDVDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.dao.dateTime = dateTime
        self.dao.dateTimeReminder = dateTimeReminder
        self.location = location
        self.professional = nil
        self.user = nil
    }
}

extension RDV{
    static func getNewRDVDao() -> RDV?{
        guard let entity = NSEntityDescription.entity(forEntityName: "RDV", in: CoreDataManager.context) else{
            return nil
        }
        return RDV(entity: entity, insertInto: CoreDataManager.context)
    }
}
