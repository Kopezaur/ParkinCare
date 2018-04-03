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
            if(date != (self.rdv!.dateTimeReminder! as Date)){
                // Deletion of the old notification request
                NotificationManager.deleteNotification(notificationIdentifier: (self.rdv?.notificationIdentifier!)!)
                
                // Then we save the dateTimeReminder attribute of the RDV entity
                self.rdv?.dateTimeReminder = date as NSDate?
                
                // Creation of the new notification according to the modified dateTimeReminder
                NotificationManager.createRDVNotification(rdv: self.rdv!)
                
            } else {
                // The dateTimeReminder has not been modified and therefore there is nothing to do
            }
            
            // Creation des Evaluations si neurologue
            if(self.rdv!.professional!.title!.name == "Neurologue"){
                Evaluation.editEvaluationsFromRdv(rdv: self.rdv!)
            }
        }
    }

}
