//
//  RDV.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension RDV {
    convenience init(date: Date, location: String, professional: Professional, dateTimeReminder: Date, notificationIdentifier: String){
        self.init(context: CoreDataManager.context)
        self.dateTime  = date as NSDate
        self.location = location
        self.professional = professional
        self.dateTimeReminder = dateTimeReminder as NSDate
        self.notificationIdentifier = notificationIdentifier
    }
}
