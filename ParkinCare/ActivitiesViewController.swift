//
//  ActivitiesViewController.swift
//  ParkinCare
//
//  Created by julia on 30/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesViewController: UIViewController{
    
    var tableViewController: ActivityTableViewController!
    
    @IBOutlet weak var activityTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableViewController = ActivityTableViewController(tableView: self.activityTable)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? ActivityViewController{
            if let cell = sender as? UITableViewCell{
                guard let index = self.activityTable.indexPath(for: cell) else {
                    return
                }
                destController.indexPath = index
                destController.activityViewModel = self.tableViewController.activityViewModel
            }
        }
    }
    
    // segue ViewControllerB -> ViewController
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewActivityViewController {
            //dataRecieved = sourceViewController.dataPassed
            if let newActivity = sourceViewController.newActivity{
                self.tableViewController.activityViewModel.add(activity: newActivity)
            }
        }
    }
    
    @IBAction func unwindToActivities(sender: UIStoryboardSegue) {
    }

}
