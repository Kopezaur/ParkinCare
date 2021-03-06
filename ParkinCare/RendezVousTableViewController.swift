//
//  RendezVousTableViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 26/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

//-------------------------------------------------------------------------------------------------
// MARK: -

protocol RDVTableViewModel {
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int
    /// person at indexPath
    ///
    /// - Parameter indexPath: (section, row)
    /// - Returns: RendezVous at indexPath, nil if indexPath not valid
    func getRDV(at indexPath: IndexPath) -> RDV?
}

class RendezVousTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {


    var tableView   : UITableView
    let rendezVousViewModel : RDVSetViewModel
    let fetchResultController : RDVFetchResultController
    
    init(tableView: UITableView) {
        self.tableView             = tableView
        self.rendezVousViewModel      = RDVSetViewModel()
        self.fetchResultController = RDVFetchResultController(view : tableView, model : self.rendezVousViewModel)
        super.init()
        self.tableView.dataSource      = self
        self.rendezVousViewModel.delegate = self.fetchResultController
        self.tableView.rowHeight = 150.0
    }
    
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            // Delete the notification
            NotificationManager.deleteNotification(notificationIdentifier: rendezVousViewModel.getRDV(at: indexPath)!.notificationIdentifier!)
            // Delete the entity
            self.rendezVousViewModel.remove(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.rendezVousViewModel.rowsCount(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rendezVousCell", for: indexPath) as! RendezVousTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    //func tableView
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: RendezVousTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        guard let rendezVous = self.rendezVousViewModel.getRDV(at: indexPath) else { return cell }
        let dateTime = rendezVous.dateTime! as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        //Verification u'il existe bien un professionel
        if(rendezVous.professional == nil){
            cell.lastnameLabel.text = "Inconnu"
            cell.firstnameLabel.text = "Inconnu"
            cell.titleLabel.text = "Inconnu"
        }
        else{
            cell.lastnameLabel.text = rendezVous.professional!.lastname
            cell.firstnameLabel.text = rendezVous.professional!.firstname
            cell.titleLabel.text = Presenter.emptyString(text: rendezVous.professional!.title?.name)
        }
        cell.dateLabel.text = date
        cell.hourLabel.text = hour
        cell.locationLabel.text = rendezVous.location
        return cell
    }

}
