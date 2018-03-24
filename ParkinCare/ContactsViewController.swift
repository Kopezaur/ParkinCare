//
//  ContactsViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController{
    

    
    var tableViewController: ProfessionalTableViewController!
    
    @IBOutlet weak var contactTable: UITableView!
    
    // MARK - Teacher one
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = ProfessionalTableViewController(tableView: self.contactTable)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? ContactViewController{
            if let cell = sender as? UITableViewCell{
                guard let index = self.contactTable.indexPath(for: cell) else {
                    return
                }
                destController.indexPath = index
                destController.professionalsViewModel = self.tableViewController.professionalsViewModel
            }
        }
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewContactViewController {
            //dataRecieved = sourceViewController.dataPassed
            if let newProfessional = sourceViewController.newProfessional{
                self.tableViewController.professionalsViewModel.add(professional: newProfessional)
            }
        }
    }

}
