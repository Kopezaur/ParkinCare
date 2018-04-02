//
//  PilulierViewController.swift
//  ParkinCare
//
//  Created by julia on 02/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class PilulierViewController: UIViewController {
    
    var tableViewController: PrescriptionTableViewController!

    @IBOutlet weak var prescriptionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewController = PrescriptionTableViewController(tableView: self.prescriptionTable)
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
