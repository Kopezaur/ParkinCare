//
//  NewContactViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController, UITextFieldDelegate {
    
    var editContactController : ContactFormViewController!
    private var newProfessional : Professional?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? ContactFormViewController else{
            return
        }
        self.editContactController = controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if segue.identifier == "newContactSegue" {
            let lastname : String  = self.editContactController.lastnameField.text!
            let firstname  : String  = self.editContactController.firstnameField.text!
            let title : String    = self.editContactController.titleField.text!
            let organization : String    = self.editContactController.organizationField.text!
            let email : String    = self.editContactController.emailField.text!
            let numTel : String    = self.editContactController.numTelField.text!
            self.newProfessional  = Professional(lastname: lastname, firstname: firstname, title: title, organization: organization, email: email, numTel: numTel)
        }
    }

}
