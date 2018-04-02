//
//  Evaluation.swift
//  ParkinCare
//
//  Created by julia on 02/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

extension Evaluation{
    
    convenience init(dateTime: Date, dateTimeReminder : Date, notificationIdentifier: String?, extraEvent: String?, validated: Bool, symptome: Symptome?, rdv: RDV){
        self.init(context: CoreDataManager.context)
        self.dateTime = dateTime as NSDate
        self.dateTimeReminder = dateTimeReminder as NSDate
        self.notificationIdentifier = notificationIdentifier
        self.extraEvent = extraEvent
        self.validated = validated
        self.symptome = symptome
        self.rdv = rdv
    }
    
    static func createEvaluationsFromNewRdv(dateTime : Date, rdv : RDV){
        
        let calendar = Calendar.current
        
        var component = DateComponents()
        component.calendar = Calendar.current
        
        // Initialiser les heures de debut et de fin
        let user : User = UserDAO.searchOne()!
        let startOnDay = user.startEvaluation! as Date
        let endOnDay = user.endEvaluation! as Date
        
        let startHour : Int = calendar.component(.hour, from: startOnDay)
        let startMinute : Int = calendar.component(.minute, from: startOnDay)
        let endHour : Int = calendar.component(.hour, from: endOnDay)
        let endMinute : Int = calendar.component(.minute, from: endOnDay)
        
        //Initialiser la date de depart de la creation des evaluations
        var startDate = calendar.date(byAdding: .day, value: -5, to: dateTime)
        startDate = calendar.date(bySetting: .hour, value: (startHour + 2), of: startDate!)
        startDate = calendar.date(bySetting: .minute, value: startMinute, of: startDate!)
        
        // Pareil pour la date de fin des evaluations
        var endDate : Date = calendar.date(bySetting: .hour, value: (endHour + 2), of: startDate!)!
        endDate = calendar.date(bySetting: .minute, value: endMinute, of: endDate)!
        
        // Créer les evaluations
        let newEvaluations : NSSet = NSSet()
        while(startDate! < endDate){
            var currentDate = startDate
            for _ in 1...5 {
                let evaluation = Evaluation(dateTime: currentDate!, dateTimeReminder : currentDate!, notificationIdentifier: "", extraEvent: nil, validated: false, symptome: nil, rdv : rdv)
                newEvaluations.adding(evaluation)
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate!)
            }
            startDate = calendar.date(byAdding: .hour, value: Int(user.hourIntervalEvaluation), to: startDate!)
        }
        
        rdv.evaluations = newEvaluations
    }
}
