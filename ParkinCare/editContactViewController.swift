//
//  editContactViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 23/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class editContactViewController: UIViewController {
        
    var professional: ProfessionalModel? = nil
    var editContactController : ContactFormViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let controller = self.childViewControllers.first as? ContactFormViewController else{
            return
        }
        self.editContactController = controller
        
        self.editContactController.lastnameField.text = self.professional!.lastname
        self.editContactController.firstnameField.text = self.professional!.firstname
        self.editContactController.titleField.text = self.professional!.title
        self.editContactController.organizationField.text = self.professional!.organization
        self.editContactController.emailField.text = self.professional!.email
        self.editContactController.numTelField.text = self.professional!.numTel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = self.childViewControllers.first as? ContactFormViewController else{
            return
        }
        self.editContactController = controller
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editContactSegue" {
            self.professional?.lastname = self.editContactController.lastnameField.text!
            self.professional?.firstname = self.editContactController.firstnameField.text!
            self.professional?.title = self.editContactController.titleField.text!
            self.professional?.organization = self.editContactController.organizationField.text!
            self.professional?.email = self.editContactController.emailField.text!
            self.professional?.numTel = self.editContactController.numTelField.text!
            CoreDataManager.save()
            //ProfessionalModel(lastname:lastname,firstname:firstname,title:title,organization:organization,email:email,numTel:numTel).save()
        }
    }
    
    

}
