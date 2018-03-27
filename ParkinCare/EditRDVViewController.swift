//
//  EditRDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 27/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class EditRDVViewController: UIViewController {
    
    var rdv: RDV? = nil
    var editContactController : FormRDVViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? FormRDVViewController else{
            return
        }
        self.editContactController = controller
        
        self.editContactController.datePicker.date = self.rdv!.dateTime! as Date
        self.editContactController.locationField.text = self.rdv!.location
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editRDVButtonAction(_ sender: Any) {
        let location = self.editContactController.locationField.text!
        if(location == ""){
            DialogBoxHelper.alert(view: self.editContactController, WithTitle: "Entrez un lieu ou une adresse.")
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
        self.editContactController = controller
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editRDVSegue" {
            self.rdv?.professional = self.editContactController.professional
            self.rdv?.dateTime = self.editContactController.datePicker.date as NSDate
            self.rdv?.location = self.editContactController.locationField.text!
        }
    }

}
