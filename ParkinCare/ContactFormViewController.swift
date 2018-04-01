//
//  ContactFormViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 22/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ContactFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var titlePicker: UIPickerView!
    @IBOutlet weak var organizationField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numTelField: UITextField!
    
    var titles : [Title]? = nil
    var titleSelected : Title? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlePicker.delegate = self
        titlePicker.dataSource = self

        self.titles = TitleDAO.fetchAll()
        titleSelected = titles?[0]
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
    
    // MARK: - Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent titlePicker: Int) -> Int {
        return titles!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent titlePicker: Int) -> String? {
        let title = self.titles![row]
        return title.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent titlePicker: Int) {
        self.titleSelected = self.titles?[row]
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
