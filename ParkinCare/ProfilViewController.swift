//
//  ProfilViewController.swift
//  ParkinCare
//
//  Created by julia on 01/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numTelField: UITextField!
    @IBOutlet weak var allowRemindSwitch: UISwitch!
    
    var user : User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user : User = UserDAO.search() {
            self.user = user
            initLabels()
        }
        
    }
    
    func initLabels(){
        self.lastnameField.text = self.user!.lastname
        self.firstnameField.text = self.user!.firstname
        self.addressField.text = self.user!.address
        self.emailField.text = self.user!.email
        self.numTelField.text = self.user!.numTel
        self.allowRemindSwitch.setOn(self.user!.activityRemind, animated: true)
    }
    
    @IBAction func saveModificationsButtonClicked(_ sender: Any) {
        self.user!.lastname = self.lastnameField.text
        self.user!.firstname = self.firstnameField.text
        self.user!.address = self.addressField.text
        self.user!.email = self.emailField.text
        self.user!.numTel = self.numTelField.text
        self.user!.activityRemind = self.allowRemindSwitch.isOn
        UserDAO.save()
        DialogBoxHelper.alert(view: self, WithTitle: "Modifications enregistrées.")
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
