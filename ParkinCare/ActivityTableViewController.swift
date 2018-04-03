//
//  ActivityTableViewController.swift
//  ParkinCare
//
//  Created by julia on 31/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

//-------------------------------------------------------------------------------------------------
// MARK: -

protocol ActivityTableViewModel {
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int
    /// person at indexPath
    ///
    /// - Parameter indexPath: (section, row)
    /// - Returns: Activity at indexPath, nil if indexPath not valid
    func getActivity(at indexPath: IndexPath) -> Activity?
}

class ActivityTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var tableView   : UITableView
    let activityViewModel : ActivitySetViewModel
    let fetchResultController : ActivityFetchResultController

    init(tableView: UITableView) {
        self.tableView             = tableView
        self.activityViewModel      = ActivitySetViewModel()
        self.fetchResultController = ActivityFetchResultController(view : tableView, model : self.activityViewModel)
        super.init()
        self.tableView.dataSource      = self
        self.activityViewModel.delegate = self.fetchResultController
        self.tableView.rowHeight = 60.0
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            // Delete the notification
            NotificationManager.deleteNotification(notificationIdentifier: activityViewModel.getActivity(at: indexPath)!.notificationIdentifier!)
            // Delete the entity
            self.activityViewModel.remove(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.activityViewModel.rowsCount(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: ActivityTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        guard let activity = self.activityViewModel.getActivity(at: indexPath) else { return cell }
        let dateTime = activity.dateTime! as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        cell.dateLabel.text = date
        cell.hourLabel.text = hour
        cell.titleLabel.text = activity.title
        return cell
    }

}
