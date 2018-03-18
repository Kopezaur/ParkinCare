//
//  Activity.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/23/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specification fonctionelle
//
// dateTime: Activity -> dateTime
// La date et l’heure a laquelle doit etre effectuee l’activite
// (get/set)
//
// title: Activity -> String
// Le titre de l’activite physique (get)
//
// description: Activity -> String
// La description de l’activite physique (get/set)
//
// validated: Activity -> Boolean
// Indique si l’activite a ete effectuee (get)
//
// validate: Activity -> Activity
// Pre: La date et l’heure de l’activite sportive doit etre
// inferieur a la date et l’heure du moment
// Valide l’activite physique
//
// reminder: Activity -> Boolean
// Indique si l’activite doit etre rappele (get/set)



class ActivityModel {
    private var dao : Activity
    
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

    
    var title: String?{
        get{
            return self.dao.title
        }
        set{
            self.dao.title = newValue
        }
    }
    
    var desc: String?{
        get{
            return self.dao.desc
        }
        set{
            self.dao.desc = newValue
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
    
    init(dateTime: NSDate, dateTimeReminder: NSDate, title: String, desc: String, validated: Bool?){
        guard let dao = Activity.getNewActivityDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.dao.dateTime = dateTime
        self.dao.dateTimeReminder = dateTimeReminder
        self.title = title
        self.desc = desc
        self.validated = validated!
        self.user = nil
    }
}

extension Activity{
    static func getNewActivityDao() -> Activity?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Activity", in: CoreDataManager.context) else{
            return nil
        }
        return Activity(entity: entity, insertInto: CoreDataManager.context)
    }
}
