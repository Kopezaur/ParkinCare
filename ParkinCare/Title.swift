//
//  Title.swift
//  ParkinCare
//
//  Created by Stefan-Dragos COPETCHI on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension Title {
    convenience init(name: String) {
        self.init(context: CoreDataManager.context)
        self.name = name
    }
}
