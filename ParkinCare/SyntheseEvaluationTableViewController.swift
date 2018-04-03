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

protocol EvaluationTableViewModel {
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int
    /// person at indexPath
    ///
    /// - Parameter indexPath: (section, row)
    /// - Returns: Evaluation at indexPath, nil if indexPath not valid
    func getEvaluation(at indexPath: IndexPath) -> Evaluation?
}

class SyntheseEvaluationTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView   : UITableView
    
    var evaluations: [Evaluation]? = nil
    
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
        return self.evaluations!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syntheseCell", for: indexPath) as! SyntheseTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func setEvaluations(evaluations: [Evaluation]){
        self.evaluations = evaluations
        self.tableView.reloadData()
    }
    
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: SyntheseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let calendar = Calendar.current
        
        let evaluation = self.evaluations![indexPath.row]
        var dateTime = evaluation.dateTime! as Date
        dateTime = calendar.date(byAdding: .hour, value: -2, to: dateTime)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = formatter.string(from: dateTime)
        cell.dateTimeLabel.text = date
        let extraEvent : String? = evaluation.extraEvent
        cell.etatLabel.text = extraEvent
        
        if(extraEvent == "" || extraEvent == nil){
            cell.etatLabel.text = "Oublié"
            cell.backgroundColor = UIColor(displayP3Red: 158.0/255, green: 158.0/255, blue: 158.0/255, alpha: 1.0)
        }
        else if(extraEvent == "OFF"){
            cell.backgroundColor = UIColor(displayP3Red: 216.0/255, green: 167.0/255, blue: 159.0/255, alpha: 1.0)
        }
        else if(extraEvent == "ON"){
            cell.backgroundColor = UIColor(displayP3Red: 159.0/255, green: 213.0/255, blue: 158.0/255, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor(displayP3Red: 216.0/255, green: 207.0/255, blue: 124.0/255, alpha: 1.0)
        }
        
        
        return cell
    }

}
