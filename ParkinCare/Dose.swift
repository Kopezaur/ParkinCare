//
//  Dose.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension Dose {
    convenience init(medicament : Medicament, quantity: Int){
        self.init(context: CoreDataManager.context)
        self.medicament = medicament
        self.quantity = Int16(quantity)
    }
}
