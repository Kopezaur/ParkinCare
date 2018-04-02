//
//  EvaluationViewController.swift
//  ParkinCare
//
//  Created by julia on 01/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class EvaluationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var symptomesPicker: UIPickerView!
    @IBOutlet weak var particularEventPicker: UIPickerView!
    
    var evaluation : Evaluation? = nil
    var particularEvents : [Symptome]? = nil
    let symptomes : [String] = ["ON","OFF","DYSKINESIES"]
    
    var particularEvent : Symptome? = nil
    var symptome : String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        symptomesPicker.delegate = self
        symptomesPicker.dataSource = self
        particularEventPicker.delegate = self
        particularEventPicker.dataSource = self
        
        self.particularEvents = SymptomeDAO.fetchAll()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == particularEventPicker){
            return particularEvents!.count
        }else if(pickerView == symptomesPicker){
            return symptomes.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent titlePicker: Int) -> String? {
        if(pickerView == particularEventPicker){
            return particularEvents![row].name
        }else if(pickerView == symptomesPicker){
            return symptomes[row]
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent titlePicker: Int) {
        if(pickerView == particularEventPicker){
            particularEvent = particularEvents?[row]
        }else if(pickerView == symptomesPicker){
            symptome = symptomes[row]
        }
    }
    
    @IBAction func validateEvaluationButtonClicked(_ sender: Any) {
        self.evaluation?.symptome = self.particularEvent
        self.evaluation?.extraEvent = self.symptome
        self.evaluation?.validated = true
        EvaluationDAO.save()
        performSegue(withIdentifier: "returnHome", sender: self)
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
