//
//  newRDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

class NewRDVViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {

    var editRDVController : FormRDVViewController!
    var newRDV: RDV?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? FormRDVViewController else{
            return
        }
        self.editRDVController = controller
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func addRDVButton(_ sender: Any) {
        let location = self.editRDVController.locationField.text
        if(location == "" || self.editRDVController.professional == nil){
            DialogBoxHelper.alert(view: self, WithTitle: "Des champs sont vides.")
        }
        else{
            performSegue(withIdentifier: "addRDVSegue", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addRDVSegue" {
            //Creation of the new RDV's arguments
            let date : Date = self.editRDVController.datePicker.date
            let location : String  = self.editRDVController.locationField.text!
            let professional : Professional = self.editRDVController.professional!
            let calendar = Calendar.current
            let dateTimeReminder : Date = calendar.date(byAdding: .minute, value: (0 - Int(self.editRDVController.timeLabel.text!)!), to: (self.editRDVController.datePicker.date))!
            
            // Creation of the notificationIdentifier
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            let dateId : String = formatter.string(from: date)
            let notificationIdentifier : String = professional.firstname! + professional.lastname! + dateId
            
            // Finally calling the init() function of RDV with all the necessary arguments
            self.newRDV  = RDV(date: date, location: location, professional: professional, dateTimeReminder: dateTimeReminder, notificationIdentifier: notificationIdentifier)
            
            // MARK: Creation of the notification
            let year : Int = calendar.component(.year, from: dateTimeReminder)
            let month : Int = calendar.component(.month, from: dateTimeReminder)
            let day : Int = calendar.component(.day, from: dateTimeReminder)
            let hour : Int = calendar.component(.hour, from: dateTimeReminder)
            let minute : Int = calendar.component(.minute, from: dateTimeReminder)

            // Creating the trigger for the notification
            let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
            
            // Creating the content that will be displayed in the notification
            let content = UNMutableNotificationContent()
            formatter.dateFormat = "HH:mm"
            let hourMinutes = formatter.string(from: date)
            content.title = "Vous avez bientot un rendez vous !"
            content.subtitle = "Dans " + self.editRDVController.timeLabel.text! + " min."
            content.body = "Vous avez rendez vous à " + hourMinutes + " avec " + professional.lastname! + " " + professional.firstname! + " (" + professional.title!.name! + ") au  '" + location + "'"            // The identifier of the request will be the unique notificationIdentifier of the entity
            
            //Creating the request of the notification with it's unique identifier
            let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }

}
