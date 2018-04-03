//
//  DoseTableViewController.swift
//  ParkinCare
//
//  Created by julia on 02/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class DoseTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView : UITableView
    
    var doses : [Dose]
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.doses = []
        super.init()
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            // Delete the notification
            doses.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return doses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doseCell", for: indexPath) as! DoseTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func addDose(dose: Dose){
        self.doses.append(dose)
        self.tableView.reloadData()
    }
    
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: DoseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let dose = self.doses[indexPath.row]
        cell.medicamentLabel.text = dose.medicament?.name
        cell.quantityLabel.text = String(dose.quantity)
        return cell
    }

}
