//
//  Activity.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/31/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension Activity {
    convenience init(dateTime: Date, dateTimeReminder: Date, title: String, desc: String, validated: Bool?){
        self.init(context: CoreDataManager.context)
        self.dateTime  = dateTime as NSDate
        self.dateTimeReminder = dateTimeReminder as NSDate
        self.title = title
        self.desc = desc
        self.validated = validated!
    }
}
