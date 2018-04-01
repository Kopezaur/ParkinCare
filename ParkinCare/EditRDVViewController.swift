//
//  EditRDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

class EditRDVViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var rdv: RDV? = nil
    var editRDVController : FormRDVViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? FormRDVViewController else{
            return
        }
        self.editRDVController = controller
        let dateTime = self.rdv!.dateTime! as Date
        let dateTimeReminder = self.rdv!.dateTimeReminder! as Date
        self.editRDVController.datePicker.date = dateTime
        self.editRDVController.locationField.text = self.rdv!.location
        let calendar = Calendar.current
        let timeSlider = calendar.dateComponents([.minute], from: dateTimeReminder, to: dateTime).minute ?? 0
        self.editRDVController.timeSlider.value = Float(timeSlider)
        self.editRDVController.timeLabel.text = String(timeSlider)
        
        UNUserNotificationCenter.current().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editRDVButtonAction(_ sender: Any) {
        let location = self.editRDVController.locationField.text!
        if(location == "" || self.editRDVController.professional == nil){
            DialogBoxHelper.alert(view: self, WithTitle: "Des champs sont vides.")
        }
        else{
            performSegue(withIdentifier: "editRDVSegue", sender: self)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = self.childViewControllers.first as? FormRDVViewController else{
            return
        }
        self.editRDVController = controller
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editRDVSegue" {
            // Get the modified information from the Form
            self.rdv?.professional = self.editRDVController.professional
            self.rdv?.dateTime = self.editRDVController.datePicker.date as NSDate
            self.rdv?.location = self.editRDVController.locationField.text!
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: (0 - Int(self.editRDVController.timeLabel.text!)!), to: (self.editRDVController.datePicker.date))
            
            // If a new date has been entered for the RDV, the old request is deleted and a new notification is created
            if(date != self.rdv?.dateTimeReminder as! Date){
                // Deletion of the old notification request
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(self.rdv?.notificationIdentifier)!])
                
                // Creating the new one
                let calendar : Calendar = Calendar.current
                let year : Int = calendar.component(.year, from: date!)
                let month : Int = calendar.component(.month, from: date!)
                let day : Int = calendar.component(.day, from: date!)
                let hour : Int = calendar.component(.hour, from: date!)
                let minute : Int = calendar.component(.minute, from: date!)
                
                // Creating the trigger for the notification
                let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute), repeats: false)
                
                // Creating the content that will be displayed in the notification
                let content = UNMutableNotificationContent()
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                let hourMinutes = formatter.string(from: date!)
                let professionalFullName : String = "\(String(describing: self.rdv?.professional!.lastname!)) \(String(describing: self.rdv?.professional!.firstname!))"
                
                content.title = "Vous avez bientot un rendez vous !"
                content.subtitle = "Dans " + self.editRDVController.timeLabel.text! + " min."
                content.body = "Vous avez rendez vous à \(hourMinutes) avec \(professionalFullName) au '\(String(describing: self.rdv?.location!))'"
                
                //Creating the request of the notification with it's unique identifier
                let request = UNNotificationRequest(identifier: (self.rdv?.notificationIdentifier)!, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print(error)
                        return
                    }
                }

            }
            
            // Finally, we save the dateTimeReminder attribute of the RDV entity
            self.rdv?.dateTimeReminder = date as NSDate?
            
            
        }
    }

}
