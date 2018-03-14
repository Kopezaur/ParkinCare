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
    private var dao: User
    
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
    
    init(firstname: String, lastname: String, address: String, email: String, numTel: String){
        guard let dao = User.getNewUserDao() else{
            fatalError()
        }
        self.dao = dao
        self.firstname = firstname
        self.lastname = lastname
        self.address = address
        self.email = email
        self.numTel = numTel
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
































