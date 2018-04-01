//
//  User.swift
//  ParkinCare
//
//  Created by julia on 01/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension User {
    convenience init(lastname: String, firstname: String, address: String, email: String, numTel: String, activityRemind: Bool!){
        self.init(context: CoreDataManager.context)
        self.lastname  = lastname
        self.firstname = firstname
        self.address = address
        self.email = email
        self.numTel = numTel
        self.activityRemind = activityRemind
    }
}
