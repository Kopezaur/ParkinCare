//
//  newRDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class NewRDVViewController: UIViewController, UITextFieldDelegate {

    var editRDVController : FormRDVViewController!
    var newRDV: RDV?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? FormRDVViewController else{
            return
        }
        self.editRDVController = controller
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "newRDVSegue" {
            let date : Date = self.editRDVController.datePicker.date
            let location : String  = self.editRDVController.locationField.text!
            let professional : Professional = self.editRDVController.professional!
            self.newRDV  = RDV(date: date, location: location, professional: professional)
        }
    }

}
