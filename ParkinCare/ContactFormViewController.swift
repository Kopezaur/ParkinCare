//
//  ContactFormViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 22/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ContactFormViewController: UIViewController {
    
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var organizationField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numTelField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == self.lastnameField) || (textField == self.firstnameField) {
            self.performSegue(withIdentifier: "editContactSegue", sender: self)
            return false
        }
        else{
            return true
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
