//
//  FormActivityViewController.swift
//  ParkinCare
//
//  Created by julia on 31/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class FormActivityViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var intervalDateSlider: UISlider!
    @IBOutlet weak var hourPicker: UIDatePicker!
    @IBOutlet weak var intervalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeIntervalDate(_ sender: Any) {
        self.intervalLabel.text = String(Int(self.intervalDateSlider.value))
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
