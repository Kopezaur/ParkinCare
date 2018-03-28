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
        if(location == ""){
            DialogBoxHelper.alert(view: self.editRDVController, WithTitle: "Entrez un lieu ou une adresse.")
        }
        else{
            performSegue(withIdentifier: "editRDVSegue", sender: sender)
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
            self.rdv?.professional = self.editRDVController.professional
            self.rdv?.dateTime = self.editRDVController.datePicker.date as NSDate
            self.rdv?.location = self.editRDVController.locationField.text!
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: (0 - Int(self.editRDVController.timeLabel.text!)!), to: (self.editRDVController.datePicker.date))
            self.rdv?.dateTimeReminder = date as NSDate?
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let professional = self.rdv?.professional
            let hour = formatter.string(from: self.editRDVController.datePicker.date)
            let lastname = professional?.lastname!
            let firstname = professional?.firstname!
            let title = professional?.title!
            let location = self.rdv?.location!
            let fullname = lastname! + " " + firstname!
            
            let content = UNMutableNotificationContent()
            content.title = "Vous avez bientot un rendez vous !"
            content.subtitle = "Dans " + self.editRDVController.timeLabel.text! + " minutes."
            content.body = "Vous avez rendez vous à " + hour + " avec " + fullname
            content.body = content.body + " (" + title + ") au  '" + location + "'"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }

}
