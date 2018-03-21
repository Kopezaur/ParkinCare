//
//  ItProfessionalSet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/21/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

struct ItProfessionalSet: IteratorProtocol{
    let professionals : ProfessionalSetModel
    private var current: Int = 0
    private let set: PersonSet
    
    fileprivate init(_ s: PersonSet){
        self.set = s
    }
    
    init(_ professionals : ProfessionalSetModel){
        self.professionals = professionals
    }
    
    mutating func next() -> ProfessionalModel? {
        // ...
        return nil
    }
}
