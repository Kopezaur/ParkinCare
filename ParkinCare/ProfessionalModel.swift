//
//  Professional.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

// ----- Specifications fonctionelles
//
//lastname: Professional -> String
//Le nom du professionnel (get/set)
//
//firstname: Professional -> String
//Le prenom du professionnel (get/set)
//
//title: Professional -> String
//Le titre du professionnel (get/set)
//
//address: Professional -> String
//L’adresse du professionnel (ou organisation) (get/set)
//
//email: Profesional -> String
//L’adresse mail du professionnel (get/set)
//
//telNumber: Professional -> String
//Le numero de telephone du professionnel (get/set)
//
//organization: Professional -> String
//L’organisation dans laquelle se trouve le professionnel (get/set)


class ProfessionalModel {
    private var dao: Professional
    
    var firstname: String?{
        get{
            return self.dao.firstname
        }
        set{
            self.dao.firstname = newValue
        }
    }
    
    var lastname: String?{
        get{
            return self.dao.lastname
        }
        set{
            self.dao.lastname = newValue
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
    
    var address: String?{
        get{
            return self.dao.address
        }
        set{
            self.dao.address = newValue
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
    
    var numTel: String?{
        get{
            return self.dao.numTel
        }
        set{
            self.dao.numTel = newValue
        }
    }
    
    var organization: String?{
        get{
            return self.dao.organization
        }
        set{
            self.dao.organization = newValue
        }
    }
    
    init(firstname: String, lastname: String, title: String, address: String, email: String, numTel: String, organization: String){
        guard let dao = Professional.getNewProfessionalDao() else{
            fatalError()
        }
        self.dao = dao
        self.firstname = firstname
        self.lastname = lastname
        self.title = title
        self.address = address
        self.email = email
        self.numTel = numTel
        self.organization = organization
    }
}

extension Professional{
    static func getNewProfessionalDao() -> Professional?{
        guard let entity = NSEntityDescription.entity(forEntityName: "Professional", in: CoreDataManager.context) else{
            return nil
        }
        return Professional(entity: entity,insertInto: CoreDataManager.context)
    }
}
