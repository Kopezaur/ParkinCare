//
//  Presenter.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 28/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

class Presenter{
    
    static func emptyString(text: String?) -> String{
        if let res = (text == "" ? "-" : text){
            return res
        }
        else{
            return "null"
        }
    }
}
