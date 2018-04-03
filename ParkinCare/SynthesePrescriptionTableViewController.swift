//
//  SyntheseEvaluationTableViewController.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

//-------------------------------------------------------------------------------------------------
// MARK: -

class SynthesePrescriptionTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView   : UITableView
    
    var prescriptions: [Prescription]? = nil
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.prescriptions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syntheseCell", for: indexPath) as! SyntheseTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func setPrescriptions(prescriptions: [Prescription]){
        self.prescriptions = prescriptions
        self.tableView.reloadData()
    }
    
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: SyntheseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let calendar = Calendar.current
        
        let prescription = self.prescriptions![indexPath.row]
        var dateTime = prescription.dateTime! as Date
        dateTime = calendar.date(byAdding: .hour, value: -2, to: dateTime)!
        var currentDate = Date()
        currentDate = calendar.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let date = formatter.string(from: dateTime)
        cell.dateTimeLabel.text = date
        let extraEvent : String = String(prescription.doses!.count)
        cell.etatLabel.text = extraEvent
        let validated : Bool = prescription.validated
        
        
        if(dateTime > currentDate){
            cell.backgroundColor = UIColor(displayP3Red: 216.0/255, green: 207.0/255, blue: 124.0/255, alpha: 1.0)
        }
        else if(validated){
            cell.backgroundColor = UIColor(displayP3Red: 159.0/255, green: 213.0/255, blue: 158.0/255, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor(displayP3Red: 216.0/255, green: 167.0/255, blue: 159.0/255, alpha: 1.0)
        }
        
        
        return cell
    }
    
}

