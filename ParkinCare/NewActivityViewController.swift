//
//  NewActivityViewController.swift
//  ParkinCare
//
//  Created by julia on 31/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

class NewActivityViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate{
    
    var newActivityController : FormActivityViewController!
    var newActivity: Activity?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let controller = self.childViewControllers.first as? FormActivityViewController else{
            return
        }
        self.newActivityController = controller
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func addActivityButtonClicked(_ sender: Any) {
        if(newActivityController.titleField.text == ""){
            DialogBoxHelper.alert(view: self, WithTitle: "L'activité doit avoir un titre.")
        }
        else if(newActivityController.startDatePicker.date > newActivityController.endDatePicker.date){
            DialogBoxHelper.alert(view: self, WithTitle: "La date de fin ne peut être avant la date de début.")
        }
        else{
            performSegue(withIdentifier: "addActivitySegue", sender: self)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addActivitySegue" {
            //Creation de la nouvelle activité
            let title : String = self.newActivityController.titleField!.text!
            let description : String = self.newActivityController.descriptionField!.text!
            let startDate : Date = self.newActivityController.startDatePicker.date
            let endDate : Date = self.newActivityController.endDatePicker.date
            let intervalDay : Int = Int(self.newActivityController.intervalDateSlider.value)
            let hourDate : Date = self.newActivityController.hourPicker.date
            let calendar : Calendar = Calendar.current
            let hour : Int = calendar.component(.hour, from: hourDate)
            let minute : Int = calendar.component(.minute, from: hourDate)
            var dateTime : Date = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: startDate)!
            while(endDate > dateTime){
                self.newActivity = Activity(dateTime : dateTime, dateTimeReminder: dateTime, title: title, desc: description, validated : false )
                dateTime = calendar.date(byAdding: .day, value: intervalDay, to: dateTime)!
            }
        }
    }

}
