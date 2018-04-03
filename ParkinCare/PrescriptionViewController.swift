//
//  PrescriptionViewController.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class PrescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var prescription : Prescription? = nil
    var indexPath : IndexPath? = nil
    var prescriptionViewModel : PrescriptionSetViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let prescription = self.prescriptionViewModel!.getPrescription(at: self.indexPath!) {
            self.prescription = prescription
            initLabels()
        }
    }

    func initLabels(){
        let dateTime = prescription!.dateTime! as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date : String = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour : String = formatter.string(from: dateTime)
        
        dateLabel.text = date
        hourLabel.text = hour
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescription!.doses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doseCell", for: indexPath) as! DoseTableViewCell
        let dose = prescription!.doses!.allObjects[indexPath.row] as! Dose
        cell.medicamentLabel.text = dose.medicament!.name
        cell.quantityLabel.text = String(dose.quantity)
        return cell
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        // First, we delete the notification
        NotificationManager.deleteNotification(notificationIdentifier: prescription!.notificationIdentifier!)
        // Then we delete the prescription
        self.prescriptionViewModel!.remove(prescription: prescription!)
        performSegue(withIdentifier: "toPilulierSegue", sender: self)
    }
    
    @IBAction func validateButtonClicked(_ sender: Any) {
        let calendar = Calendar.current
        let dateMin = calendar.date(byAdding: .minute, value: -15, to: self.prescription!.dateTime! as Date)!
        if(dateMin < Date()){
            self.prescription!.validated = true
            EvaluationDAO.save()
            performSegue(withIdentifier: "toPilulierSegue", sender: self)
        }
        else{
            DialogBoxHelper.alert(view: self, WithTitle: "Il est encore un peu trop tôt pour valider.")
        }
       
    }
    
    // MARK: - Navigation

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toPilulierSegue"{
            if segue.destination is PilulierViewController{
            }
        }
    }*/

}
