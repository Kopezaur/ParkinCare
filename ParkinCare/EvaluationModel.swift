//
//  Evaluation.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/23/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specifications fonctionelles
//
//dateTime: Evaluation -> DateTime
//La date et l’heure a laquelle l’evaluation doit etre faite (get/set)
//
//value: Evaluation -> String
//La valeur de l’evaluation des symptomes : (ON,OFF,DYSKINESIE) (get)
//
//validated: Evaluation -> Boolean
//Indique si l’utilisateur a fait son evaluation (get/set)
//
//particularEvent: Evaluation -> String
//Renvoie un evenement particulier subit, optionnel (get)
//
//reminder: Evaluation -> Boolean
//Indique si l’evaluation doit etre rappele (get/set)
//
//validate: Evaluation -> Evaluation
//Pre : La date de l’evaluation doit etre superieur a la date du moment
//Indique que l’evaluation a ete validee

class EvaluationModel {
    private var dao : Evaluation
    
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
    
    var rating: Double{
        get{
            return self.dao.rating
        }
        set{
            self.dao.rating = newValue
        }
    }
    
    var extraEvent: String?{
        get{
            return self.dao.extraEvent
        }
        set{
            self.dao.extraEvent = newValue
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

    
    var user: User?{
        get{
            return self.dao.user
        }
        set{
            self.dao.user = newValue
        }
    }
    
    init(dateTime: NSDate, dateTimeReminder: NSDate, rating: Double, extraEvent: String, validated: Bool?){
        guard let dao = Evaluation.getNewEvaluationDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.dao.dateTime = dateTime
        self.dao.dateTimeReminder = dateTimeReminder
        self.rating = rating
        self.extraEvent = extraEvent
        self.validated = validated!
        self.user = nil
    }
}

extension Evaluation{
    static func getNewEvaluationDao() -> Evaluation?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Evaluation", in: CoreDataManager.context) else{
            return nil
        }
        return Evaluation(entity: entity, insertInto: CoreDataManager.context)
    }
}
