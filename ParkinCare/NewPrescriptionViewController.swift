//
//  NewPrescriptionViewController.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class NewPrescriptionViewController: UIViewController {

    var editPrescriptionController : FormPrescriptionViewController!
    var newProfessional : Professional?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let controller = self.childViewControllers.first as? FormPrescriptionViewController else{
            return
        }
        self.editPrescriptionController = controller
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newPrescriptionSegue" {
            let doses : [Dose]  = self.editPrescriptionController.tableViewController.doses
            var startDate  : Date  = self.editPrescriptionController.startDatePicker.date
            var endDate : Date = self.editPrescriptionController.endDatePicker.date
            let intervalDay : Int = Int(self.editPrescriptionController.intervalDayLabel.text!)!
            let hourDate : Date = self.editPrescriptionController.hourPicker.date
            if(endDate < startDate){
                DialogBoxHelper.alert(view: self, WithTitle: "La date de fin doit être après la date de début.")
            }
            else if(doses.count == 0){
                DialogBoxHelper.alert(view: self, WithTitle: "Aucun médicament n'a été prescrit.")
            }
            else{
                let calendar = Calendar.current
                let hour : Int = calendar.component(.hour, from: hourDate)
                let minute : Int = calendar.component(.minute, from: hourDate)
                
                startDate = calendar.date(bySetting: .hour, value: hour, of: startDate)!
                startDate = calendar.date(bySetting: .minute, value: minute, of: startDate)!
                
                endDate = calendar.date(bySetting: .minute, value: 0, of: endDate)!
                endDate = calendar.date(bySetting: .hour, value: 0, of: endDate)!
                
                while(startDate < endDate){
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
                    let notificationIdentifier = formatter.string(from: startDate) + formatter.string(from: Date())
                    let _ : Prescription = Prescription(dateTime: startDate, dateTimeReminder: startDate, validated: false, doses: doses, notificationIdentifier: notificationIdentifier)
                    startDate = calendar.date(byAdding: .day, value: intervalDay, to: startDate)!
                }
            }
        }
    }
}

