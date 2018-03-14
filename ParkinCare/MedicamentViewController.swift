//
//  MedicamentViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 13/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData

class MedicamentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var medicamentNames : [String] = ["toto","tata"]
    var medicaments : [Medicament] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // first get context of persistent data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.alertError(errorMsg: "Could not load data", userInfo: "reason unknown")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // creer une requete associee a l'entite Medicament
        let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do{
            try self.medicaments = context.fetch(request)
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var MedicamentTable: UITableView!
    
    @IBAction func addMedicament(_ sender: Any) {
        let alert = UIAlertController(title: "Nouveau nom de medicament",
                                      message: "Ajouter un nom",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ajouter",
                                       style: .default)
        {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else{
                    return
            }
            self.saveNewMedicament(withName: nameToSave)
            self.MedicamentTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func alertError(errorMsg error : String, userInfo user : String = "") {
        let alert = UIAlertController(title: error,
                                      message: user,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    
    // MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.MedicamentTable.dequeueReusableCell(withIdentifier: "medicamentCell",for: indexPath) as! MedicamentTableViewCell
        cell.medicamentNameLabel.text = self.medicaments[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // after it has just managed deleting
        if(editingStyle == UITableViewCellEditingStyle.delete){
            self.MedicamentTable.beginUpdates()
            if self.delete(medicamentWithIndex: indexPath.row){
                self.MedicamentTable.deleteRows(at : [indexPath], with: UITableViewRowAnimation.automatic)
            }
            self.MedicamentTable.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    // MARK: - Medicament data management -
    
    /// save all data
    ///
    func save(){
        // first get context into application delegate
        if let error = CoreDataManager.save(){
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    func saveNewMedicament(withName name: String){
        // first get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alertError(errorMsg: "Could not save Medicament", userInfo: "unknown reason")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // create a Medicament managedObject
        let medicament = Medicament(context: context)
        // then modify it's attributes
        medicament.name = name
        do{
            try context.save()
            self.medicaments.append(medicament)
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
            return
        }
    }
    
    /// delete a medicament from the collection based on its index
    ///
    /// - Precondition: index must be into the boundaries of the collection
    /// - Parameter index: index of person to delete
    /// - Returns: true if deletion occurs, else false
    func delete(medicamentWithIndex index : Int) -> Bool{
        guard let context = self.getContext(errorMsg:"Could not delete medicament") else {
            return false
        }
        let medicament = self.medicaments[index]
        context.delete(medicament)
        do{
            try context.save()
            self.medicaments.remove(at: index)
            return true
        }
        catch let error as NSError {
            self.alert(error : error)
            return false
        }
    }
    
    // MARK: - Helper Methods -
    
    /// get context of core data initialized in application delegate
    ///
    /// - Parameters:
    ///     -errorMsg: main error message
    ///     -userInfoMsg: additional information user wants to display
    /// - Returns: context of CoreData
    func getContext(errorMsg: String, userInfoMsg: String = "could not retrieve data context") -> NSManagedObjectContext?{
        // first get context of persistent data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alert(WithTitle: errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    /// shows an alert box with two messages
    ///
    /// - Parameters:
    ///     - title: title of dialog box as main message
    ///     - msg: additional message used to describe context or additional information
    func alert(WithTitle title: String, andMessage msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    /// shows an alert to inform about an error
    ///
    /// - Parameter error: error we want information about
    func alert(error : NSError) {
        self.alert(WithTitle: "\(error)", andMessage: "\(error.userInfo)")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
