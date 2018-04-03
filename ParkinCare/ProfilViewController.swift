//
//  ProfilViewController.swift
//  ParkinCare
//
//  Created by julia on 01/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numTelField: UITextField!
    @IBOutlet weak var allowRemindSwitch: UISwitch!
    @IBOutlet weak var startEvaluationDatePicker: UIDatePicker!
    @IBOutlet weak var endEvaluationDatePicker: UIDatePicker!
    @IBOutlet weak var hourIntervalSlider: UISlider!
    @IBOutlet weak var hourIntervalLabel: UILabel!
    
    var user : User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user : User = UserDAO.searchOne() {
            self.user = user
            initLabels()
        }
        
    }
    
    func initLabels(){
        self.lastnameField.text = self.user!.lastname
        self.firstnameField.text = self.user!.firstname
        self.addressField.text = self.user!.address
        self.emailField.text = self.user!.email
        self.numTelField.text = self.user!.numTel
        self.allowRemindSwitch.setOn(self.user!.activityRemind, animated: true)
        self.startEvaluationDatePicker.date = self.user!.startEvaluation! as Date
        self.endEvaluationDatePicker.date = self.user!.endEvaluation! as Date
        self.hourIntervalSlider.value = Float(self.user!.hourIntervalEvaluation)
        self.hourIntervalLabel.text = String(self.user!.hourIntervalEvaluation)
    }
    
    @IBAction func saveModificationsButtonClicked(_ sender: Any) {
        self.user!.lastname = self.lastnameField.text
        self.user!.firstname = self.firstnameField.text
        self.user!.address = self.addressField.text
        self.user!.email = self.emailField.text
        self.user!.numTel = self.numTelField.text
        // Verification for Notifications supression
        if(self.allowRemindSwitch.isOn == false){ // If all activities notifications have been supressed
            NotificationManager.deactivateActivityNotifications()
        } else {
            if(self.user!.activityRemind == false){
                // If the activity notifications used to be supressed but he reactivated them
                NotificationManager.reactivateActivityNotifications()
            }
        }
        self.user!.activityRemind = self.allowRemindSwitch.isOn
        self.user!.startEvaluation = self.startEvaluationDatePicker.date as NSDate
        self.user!.endEvaluation = self.endEvaluationDatePicker.date as NSDate
        self.user!.hourIntervalEvaluation = Int16(self.hourIntervalSlider.value)
        print(self.startEvaluationDatePicker.date)
        UserDAO.save()
        DialogBoxHelper.alert(view: self, WithTitle: "Modifications enregistrées.")
    }
    
    @IBAction func changeValueHourSlider(_ sender: Any) {
        self.hourIntervalLabel.text = String(Int(self.hourIntervalSlider.value))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
