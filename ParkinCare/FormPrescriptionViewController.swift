//
//  NewPrescriptionViewController.swift
//  ParkinCare
//
//  Created by julia on 02/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class FormPrescriptionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var tableViewController: DoseTableViewController!
    
    @IBOutlet weak var doseTable: UITableView!
    
    @IBOutlet weak var medicamentPicker: UIPickerView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var intervalDaySlider: UISlider!
    @IBOutlet weak var intervalDayLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var hourPicker: UIDatePicker!
    
    var medicaments : [Medicament]? = nil
    var medicamentSelected : Medicament? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicamentPicker.delegate = self
        medicamentPicker.dataSource = self
        self.tableViewController = DoseTableViewController(tableView: self.doseTable)
        self.medicaments = MedicamentDAO.fetchAll()
        self.medicamentSelected = medicaments![0]
    }
    
    @IBAction func changeIntervalDaySlider(_ sender: Any) {
        self.intervalDayLabel.text = String(Int(self.intervalDaySlider.value))
    }
    
    @IBAction func changeStepper(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.medicaments!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent titlePicker: Int) -> String? {
        let medicament = self.medicaments![row]
        return medicament.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent titlePicker: Int) {
        self.medicamentSelected = self.medicaments?[row]
    }
    
    @IBAction func addDoseButtonClicked(_ sender: Any) {
        let dose : Dose = Dose(medicament: medicamentSelected!, quantity: Int(quantityLabel.text!)!)
        self.tableViewController.addDose(dose: dose)
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
