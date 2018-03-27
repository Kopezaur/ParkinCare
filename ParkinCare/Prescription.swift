//
//  Prescription.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension Prescription {
    convenience init(dateTime: NSDate, dateTimeReminder: NSDate, observations: String, validated: Bool?, doses: NSSet){
        self.init(context: CoreDataManager.context)
        self.dateTime = dateTime
        self.dateTimeReminder = dateTimeReminder
        self.observations = observations
        self.validated = validated!
        self.doses = doses
    }
}
