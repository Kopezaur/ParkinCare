//
//  NewContactViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {
    
    @IBOutlet weak var lastnameInput: UITextField!
    @IBOutlet weak var firstnameInput: UITextField!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var organizationInput: UITextField!
    @IBOutlet weak var mailInput: UITextField!
    @IBOutlet weak var numTelInput: UITextField!
    
    private var professionalSet : ProfessionalSetModel = ProfessionalSetModel()
    
    @IBAction func newContactClicked(_ sender: Any) {
        
        let professional : ProfessionalModel = ProfessionalModel(firstname: firstnameInput.text!, lastname: lastnameInput.text!, title: titleInput.text!, address: "", email: mailInput.text!, numTel: numTelInput.text!, organization: organizationInput.text!)
        
        professionalSet.addProfessional(professional: professional)
        performSegue(withIdentifier: "formSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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

}
