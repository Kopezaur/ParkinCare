//
//  RendezVousViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 26/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData

class RendezVousViewController: UIViewController {
    
    var tableViewController: RendezVousTableViewController!
    
    @IBOutlet weak var rendezVousTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableViewController = RendezVousTableViewController(tableView: self.rendezVousTable)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? RDVViewController{
            if let cell = sender as? UITableViewCell{
                guard let index = self.rendezVousTable.indexPath(for: cell) else {
                    return
                }
                destController.indexPath = index
                destController.rdvViewModel = self.tableViewController.rendezVousViewModel
            }
        }
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewRDVViewController {
            //dataRecieved = sourceViewController.dataPassed
            if let newRDV = sourceViewController.newRDV{
                self.tableViewController.rendezVousViewModel.add(rdv: newRDV)
            }
        }
    }
}
