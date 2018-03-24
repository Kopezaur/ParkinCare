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


class ProfessionalModel: Equatable {
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
    
    var patient: User?{
        get{
            return self.dao.patient
        }
        set{
            self.dao.patient = newValue
        }
    }
    
    /// fullname property: `String` firstname lastname (read-only)
    var fullname: String {
        return self.dao.firstname! + " " + self.dao.lastname!
    }
    
    // MARK: - Constructors -
    
    init(lastname: String, firstname: String, title: String, organization: String, email: String, numTel: String){
        guard let dao = Professional.create() else{
            fatalError("Initialisation error")
        } 
        self.dao = dao
        self.dao.firstname = firstname
        self.dao.lastname = lastname
        self.dao.title = title
        self.dao.email = email
        self.dao.numTel = numTel
        self.dao.organization = organization
    }
    
    init(professional: Professional){
        self.dao = professional
    }
    
    // -- MARK: - Equatable functions -
    
    static func == (lhs: ProfessionalModel, rhs: ProfessionalModel) -> Bool {
        return lhs.firstname == rhs.firstname &&
            lhs.lastname == rhs.lastname
    }
    
    static func != (lhs: ProfessionalModel, rhs: ProfessionalModel) -> Bool {
        return !(lhs == rhs)
    }

}

