//
//  NotificationManager.swift
//  ParkinCare
//
//  Created by Kopezaur on 4/1/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

class NotificationManager{
    
    class func deleteNotification(notificationIdentifier: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
    
    class func createActivityNotification(activity: Activity){
        // Check if the profile has been created
        if let user : User = UserDAO.searchOne() {
            // Check if the user has the notifications active
            if user.activityRemind == true { // if they are active, we can continue creating the notification
                // Creation of the trigger parameters
                let calendar = Calendar.current
                let year : Int = calendar.component(.year, from: activity.dateTimeReminder! as Date)
                let month : Int = calendar.component(.month, from: activity.dateTimeReminder! as Date)
                let day : Int = calendar.component(.day, from: activity.dateTimeReminder! as Date)
                let hour : Int = calendar.component(.hour, from: activity.dateTimeReminder! as Date)
                let minute : Int = calendar.component(.minute, from: activity.dateTimeReminder! as Date)
        
                // Creating the trigger for the notification
                let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
        
                // Creating the content that will be displayed in the notification
                let content = UNMutableNotificationContent()
                content.title = "Activité"
                content.body = "Il est temps de bouger un peu ! Activité proposée : " + activity.title!
        
                // Creating the request of the notification with it's unique identifier
                // The identifier of the request will be the unique notificationIdentifier of the entity
                let request = UNNotificationRequest(identifier: activity.notificationIdentifier!, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print(error)
                        return
                    }
                }
            }
        }
    }
    
    class func createRDVNotification(rdv: RDV){
        // Check if the profile has been created
        if let _ : User = UserDAO.searchOne() {
            // Creation of the trigger parameters
            let calendar = Calendar.current
            let finalDate = rdv.dateTime! as Date
            let initialDate = rdv.dateTimeReminder! as Date
            let year : Int = calendar.component(.year, from: initialDate)
            let month : Int = calendar.component(.month, from: initialDate)
            let day : Int = calendar.component(.day, from: initialDate)
            let hour : Int = calendar.component(.hour, from: initialDate)
            let minute : Int = calendar.component(.minute, from: initialDate)
            
            // Creating the trigger for the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
            
            // Creating the content that will be displayed in the notification
            let content = UNMutableNotificationContent()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let hourMinutes = formatter.string(from: initialDate)
            content.title = "Rendez Vous"
            content.subtitle = "Dans " + finalDate.offset(from: initialDate)
            content.body = "Vous avez rendez vous à " + hourMinutes + " avec \(rdv.professional!.lastname!) \(rdv.professional!.firstname!) (\(rdv.professional!.title!.name!)) au  '\(rdv.location!)'."
                
            // Creating the request of the notification with it's unique identifier
            // The identifier of the request will be the unique notificationIdentifier of the entity
            let request = UNNotificationRequest(identifier: rdv.notificationIdentifier!, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    class func createEvaluationNotification(evaluation: Evaluation){
        // Check if the profile has been created
        if let _ : User = UserDAO.searchOne() {
            // Creation of the trigger parameters
            let calendar = Calendar.current
            let notificationDate = evaluation.dateTimeReminder! as Date
            let year : Int = calendar.component(.year, from: notificationDate)
            let month : Int = calendar.component(.month, from: notificationDate)
            let day : Int = calendar.component(.day, from: notificationDate)
            let hour : Int = calendar.component(.hour, from: notificationDate)
            let minute : Int = calendar.component(.minute, from: notificationDate)
                
            // Creating the trigger for the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
                
            // Creating the content that will be displayed in the notification
            let content = UNMutableNotificationContent()
            content.title = "Evaluation"
            content.body = "C'est le moment d'évaluer vos symptômes !"
                
            // Creating the request of the notification with it's unique identifier
            // The identifier of the request will be the unique notificationIdentifier of the entity
            let request = UNNotificationRequest(identifier: evaluation.notificationIdentifier!, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    class func createPrescriptionNotification(prescription: Prescription){
        // Check if the profile has been created
        if let _ : User = UserDAO.searchOne() {
            // Creation of the trigger parameters
            let calendar = Calendar.current
            let notificationDate = prescription.dateTimeReminder! as Date
            let year : Int = calendar.component(.year, from: notificationDate)
            let month : Int = calendar.component(.month, from: notificationDate)
            let day : Int = calendar.component(.day, from: notificationDate)
            let hour : Int = calendar.component(.hour, from: notificationDate)
            let minute : Int = calendar.component(.minute, from: notificationDate)
            
            // Creating the trigger for the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
            
            // Creating the content that will be displayed in the notification
            var dosesString : String = "Doses : "
            for case let dose as Dose in prescription.doses!  {
                dosesString.append(dose.medicament!.name!+"-"+String(dose.quantity)+" doses ; ")
            }
            let content = UNMutableNotificationContent()
            content.title = "Prescription"
            content.subtitle = "Il est temps de prendre vos pilules !"
            content.body = dosesString

            // Creating the request of the notification with it's unique identifier
            // The identifier of the request will be the unique notificationIdentifier of the entity
            let request = UNNotificationRequest(identifier: prescription.notificationIdentifier!, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    class func deactivateActivityNotifications(){
        // Check if we have activities created
        if(ActivityDAO.count > 0){
            // Get the list of notificationIdentifiers for all activities
            let activities = ActivityDAO.fetchAll()
            var notificationIdentifiers : [String] = []
            for i in 0 ..< ActivityDAO.count {
                let activity = activities![i]
                notificationIdentifiers.append(activity.notificationIdentifier!)
            }
            // Delete all the pending requests for activities
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationIdentifiers)
        }

    }
    
    class func reactivateActivityNotifications(){
        // Recreate notifications for Activities
        if(ActivityDAO.count > 0){
            let activities = ActivityDAO.fetchAll()
            for i in 0 ..< ActivityDAO.count {
                let activity = activities![i]
                self.createActivityNotification(activity: activity)
            }
        }
    }
    
}
