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
    

    
    // MARK: - Navigation

    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if sender.source is NewPrescriptionViewController {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? PrescriptionViewController{
            if let cell = sender as? UITableViewCell{
                guard let index = self.prescriptionTable.indexPath(for: cell) else {
                    return
                }
                destController.indexPath = index
                destController.prescriptionViewModel = self.tableViewController.prescriptionViewModel
            }
        }
    }

}
