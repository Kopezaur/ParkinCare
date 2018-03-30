//
//  FormRDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class FormRDVViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var professionalSelect: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    var professionalsViewModel : ProfessionalSetViewModel? = nil
    var professional : Professional? = nil
    var professionals : [Professional]? = nil
    
    override func viewDidLoad() {
        professionalSelect.delegate = self
        professionalSelect.dataSource = self
        super.viewDidLoad()
        self.professionals = ProfessionalDAO.fetchAll();
        if professionals!.count > 0{
            self.professional = professionals?[0]
        };
        // Do any additional setup after loading the view.
        self.timeLabel.text = String(Int(timeSlider.value))
    }
    
    @IBAction func timeSliderAction(_ sender: Any) {
        self.timeLabel.text = String(Int(timeSlider.value) - Int(timeSlider.value)%5)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.professionals!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let professional = self.professionals![row]
        return (professional.lastname)! + " " + (professional.firstname)!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(self.professional! == nil){
            self.professional = self.professionals?[row]
        }
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
