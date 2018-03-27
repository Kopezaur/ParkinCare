//
//  ProfessionalTableViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 24/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

//-------------------------------------------------------------------------------------------------
// MARK: -

protocol ProfessionalTableViewModel {
    /// numbers of rows for a given section
    ///
    /// - Parameter section: section we want the number of rows
    /// - Returns: number of rows for section
    func rowsCount(inSection section : Int) -> Int
    /// person at indexPath
    ///
    /// - Parameter indexPath: (section, row)
    /// - Returns: Person at indexPath, nil if indexPath not valid
    func getProfessional(at indexPath: IndexPath) -> Professional?
}

//-------------------------------------------------------------------------------------------------
// MARK: -

class ProfessionalTableViewController: NSObject, UITableViewDataSource{

    var tableView   : UITableView
    let professionalsViewModel : ProfessionalSetViewModel
    let fetchResultController : ProfessionalFetchResultController
    
    init(tableView: UITableView) {
        self.tableView             = tableView
        self.professionalsViewModel      = ProfessionalSetViewModel()
        self.fetchResultController = ProfessionalFetchResultController(view : tableView, model : self.professionalsViewModel)
        super.init()
        self.tableView.dataSource      = self
        self.professionalsViewModel.delegate = self.fetchResultController
    }
    
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            ProfessionalDAO.delete(professional: professionalsViewModel.getProfessional(at: indexPath)!)
            //self.tableView.deleteRows(at : [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
        /*if (editingStyle==UITableViewCellEditingStyle.delete){
            let city = self.citiesFetched.object(at: indexPath)
            CityDAO.delete(city: city)
        }*/
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.professionalsViewModel.rowsCount(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func configure(cell: ContactTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        guard let professional = self.professionalsViewModel.getProfessional(at: indexPath) else { return cell }
        cell.lastnameLabel.text = professional.lastname
        cell.firstnameLabel.text = professional.firstname
        cell.titleLabel.text = Presenter.emptyString(text: professional.title)
        return cell
    }
}
