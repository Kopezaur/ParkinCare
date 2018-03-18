//
//  User.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specifications fonctionelles:
//
//lastname: User -> String
//Le nom de famille de l’utilisateur (get/set)
//
//firstname: User -> String
//le prenom de l’utilisateur (get/set)
//
//address: User -> String
//L’adresse de l’utilisateur (get/set)
//
//numTel: User -> String
//Numero de telephone de l’utilisateur (get/set)
//
//email: User -> String
//L’adresse mail de l’utilisateur (get/set)



class UserModel {
    private var dao : User
    
    var lastname: String?{
        get{
            return self.dao.firstname
        }
        set{
            self.dao.firstname = newValue
        }
    }
    
    var firstname: String?{
        get{
            return self.dao.lastname
        }
        set{
            self.dao.lastname = newValue
        }
    }
    
    var address: String?{
        get{
            return self.dao.address
        }
        set{
            self.dao.address = address
        }
    }
    
    var numTel: String?{
        get{
            return self.dao.numTel
        }
        set{
            self.dao.numTel = newValue
        }
    }
    
    var email: String?{
        get{
            return self.dao.email
        }
        set{
            self.dao.email = newValue
        }
    }
    
    var prescriptions: NSSet?{
        get{
            guard let prescriptions = self.dao.prescriptions else{
                fatalError()
            }
            return prescriptions
        }
        set{
            self.dao.prescriptions = newValue
        }
    }
    
    var evaluations: NSSet?{
        get{
            guard let evaluations = self.dao.evaluations else{
                fatalError()
            }
            return evaluations
        }
        set{
            self.dao.evaluations = newValue
        }
    }
    
    var activities: NSSet?{
        get{
            guard let activities = self.dao.activities else{
                fatalError()
            }
            return activities
        }
        set{
            self.dao.activities = newValue
        }
    }
    
    var rendezVous: NSSet?{
        get{
            guard let rendezVous = self.dao.rendezVous else{
                fatalError()
            }
            return rendezVous
        }
        set{
            self.dao.rendezVous = newValue
        }
    }
    
    var contacts: NSSet?{
        get{
            guard let contacts = self.dao.contacts else{
                fatalError()
            }
            return contacts
        }
        set{
            self.dao.contacts = newValue
        }
    }
    
    init(firstname: String, lastname: String, address: String, email: String, numTel: String){
        guard let dao = User.getNewUserDao() else{
            fatalError("Initialisation error")
        }
        self.dao = dao
        self.firstname = firstname
        self.lastname = lastname
        self.address = address
        self.email = email
        self.numTel = numTel
        self.prescriptions = []
        self.evaluations = []
        self.activities = []
        self.rendezVous = []
        self.contacts = []
    }
}

extension User{
    static func getNewUserDao() -> User?{
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: CoreDataManager.context) else{
            return nil
        }
        return User(entity: entity, insertInto: CoreDataManager.context)
    }
}
































