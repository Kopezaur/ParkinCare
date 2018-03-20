//
//  ProfessionalSet.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ProfessionalSetModel{
    
    private var professionals : [ProfessionalModel]
    
    init(){
        self.professionals = [ProfessionalModel(firstname:"Patrick", lastname:"Bruel", title:"Dentiste", address:"hopital", email:"f@f.f", numTel:"05142345", organization:"orgnisation")]
    }
    
    func getAll() -> [ProfessionalModel]{
        return self.professionals
    }
    
    func addProfessional(professional : ProfessionalModel){
        self.professionals.append(professional)
        //TO DO
    }
}
