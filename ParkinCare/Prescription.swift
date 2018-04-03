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
    convenience init(dateTime: Date, dateTimeReminder: Date, validated: Bool?, doses: [Dose], notificationIdentifier: String){
        self.init(context: CoreDataManager.context)
        self.dateTime = dateTime as NSDate
        self.dateTimeReminder = dateTimeReminder as NSDate
        self.validated = validated!
        self.doses = NSSet().addingObjects(from: doses) as NSSet
        self.notificationIdentifier = notificationIdentifier
    }
}
