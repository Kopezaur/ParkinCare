//
//  PrescriptionTableViewController.swift
//  ParkinCare
//
//  Created by julia on 02/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

//-------------------------------------------------------------------------------------------------
// MARK: -

protocol PrescriptionTableViewModel {
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int
    /// person at indexPath
    ///
    /// - Parameter indexPath: (section, row)
    /// - Returns: Prescription at indexPath, nil if indexPath not valid
    func getPrescription(at indexPath: IndexPath) -> Prescription?
}

class PrescriptionTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView   : UITableView
    let prescriptionViewModel : PrescriptionSetViewModel
    let fetchResultController : PrescriptionFetchResultController
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.prescriptionViewModel = PrescriptionSetViewModel()
        self.fetchResultController = PrescriptionFetchResultController(view : tableView, model : self.prescriptionViewModel)
        super.init()
        self.tableView.dataSource = self
        self.prescriptionViewModel.delegate = self.fetchResultController
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            // Delete the notification
            NotificationManager.deleteNotification(notificationIdentifier: prescriptionViewModel.getPrescription(at: indexPath)!.notificationIdentifier!)
            // Delete the entity
            self.prescriptionViewModel.remove(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.prescriptionViewModel.rowsCount(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionCell", for: indexPath) as! PrescriptionTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }


    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: PrescriptionTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        guard let prescription = self.prescriptionViewModel.getPrescription(at: indexPath) else { return cell }
        print(prescription.doses!.count)
        let dateTime = prescription.dateTime! as Date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        cell.dateLabel.text = date
        cell.hourLabel.text = hour
        cell.numberMedicamentLabel.text = String(prescription.doses!.count)
        return cell
    }

}
