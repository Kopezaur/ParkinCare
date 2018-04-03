//
//  SytheseViewController.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class SyntheseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var itemsPicker: UIPickerView!
    @IBOutlet weak var syntheseTable: UITableView!
    
    
    
    var tableViewController : NSObject? = nil
    
    var items : [String]? = nil
    var itemSelected : String? = nil
    
    var dates : [String]? = nil
    var dateSelected : String? = nil
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        var currentDate : Date = calendar.date(byAdding: .hour, value: 2, to: Date())!
        
        // Pour tester
        currentDate = calendar.date(byAdding: .day, value: 2, to: currentDate)!
        
        self.dates = []
        for _ in 1...5 {
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            dates!.append(formatter.string(from: currentDate))
        }
        dateSelected = dates![0]
        
        dayPicker.delegate = self
        dayPicker.dataSource = self
        itemsPicker.delegate = self
        itemsPicker.dataSource = self
        
        items = ["Evaluations","Prescriptions"]
        itemSelected = items![0]

        //print(EvaluationDAO.search(dateTime: formatter.date(from: dateSelected!)!))
        if(itemSelected == "Evaluations"){
            self.tableViewController = SyntheseEvaluationTableViewController(tableView : syntheseTable)
            let newEvaluations : [Evaluation] = EvaluationDAO.search(dateTime: formatter.date(from: dateSelected!)!)!
            (self.tableViewController as! SyntheseEvaluationTableViewController).setEvaluations(evaluations: newEvaluations)
        }
        else{
            //self.tableViewController = SynthesePrecriptionTableViewController(tableView : syntheseTable)
        }
        
       
    }
    
    
    //Taille des pickers
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == dayPicker){
            return dates!.count
        }else if(pickerView == itemsPicker){
            return items!.count
        }else{
            return 0
        }
    }
    
    
    //Valeurs des pickers
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent titlePicker: Int) -> String? {
        if(pickerView == dayPicker){
            return dates![row]
        }else if(pickerView == itemsPicker){
            return items?[row]
        }else{
            return ""
        }
    }
    
    // Lorsqu'un element est selectionné
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent titlePicker: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        if(pickerView == dayPicker){
            dateSelected = dates?[row]
            if(itemSelected == "Evaluations"){
                self.tableViewController = SyntheseEvaluationTableViewController(tableView : syntheseTable)
                let newEvaluations : [Evaluation] = EvaluationDAO.search(dateTime: formatter.date(from: dateSelected!)!)!
                (self.tableViewController as! SyntheseEvaluationTableViewController).setEvaluations(evaluations: newEvaluations)
            }
            else if(itemSelected == "Prescriptions"){
                self.tableViewController = SynthesePrescriptionTableViewController(tableView: syntheseTable)
                let newPrescriptions : [Prescription] = PrescriptionDAO.search(dateTime: formatter.date(from: dateSelected!)!)!
                (self.tableViewController as! SynthesePrescriptionTableViewController).setPrescriptions(prescriptions: newPrescriptions)
            }
            
            
        }else if(pickerView == itemsPicker){
            itemSelected = items![row]
            if(itemSelected == "Evaluations"){
                self.tableViewController = SyntheseEvaluationTableViewController(tableView : syntheseTable)
                let newEvaluations : [Evaluation] = EvaluationDAO.search(dateTime: formatter.date(from: dateSelected!)!)!
                (self.tableViewController as! SyntheseEvaluationTableViewController).setEvaluations(evaluations: newEvaluations)
            }
            else if(itemSelected == "Prescriptions"){
                self.tableViewController = SynthesePrescriptionTableViewController(tableView: syntheseTable)
                let newPrescriptions : [Prescription] = PrescriptionDAO.search(dateTime: formatter.date(from: dateSelected!)!)!
                (self.tableViewController as! SynthesePrescriptionTableViewController).setPrescriptions(prescriptions: newPrescriptions)
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


}
