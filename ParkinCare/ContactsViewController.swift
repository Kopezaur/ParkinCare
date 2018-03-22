//
//  ContactsViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var professionalSet : ProfessionalSetModel = ProfessionalSetModel()
    fileprivate var professionals : [ProfessionalModel] = []
    var tableViewController: ContactTableViewController!

    @IBOutlet weak var contactTable: UITableView!
    

//    var professionals : [ProfessionalModel] = [ProfessionalModel(firstname:"Patrick", lastname:"Bruel", title:"Dentiste", address:"hopital", email:"f@f.f", numTel:"05142345", organization:"orgnisation")]
    
//    var professionals : [ProfessionalModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        professionals = Professional.getAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contactTable.dequeueReusableCell(withIdentifier: "contactCell",for: indexPath) as! ContactTableViewCell
        cell.lastnameLabel.text = self.professionals[indexPath.row].lastname
        cell.firstnameLabel.text = self.professionals[indexPath.row].firstname
        cell.titleLabel.text = self.professionals[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.professionals.count
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
    
    func alertError(errorMsg error : String, userInfo user : String = "") {
        let alert = UIAlertController(title: error,
                                      message: user,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    
    // MARK: - Navigation
    
    @IBAction func unwindToContactsViewController(_ segue: UIStoryboardSegue){
        self.contactTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showContactSegue"{
            if let indexPath = self.contactTable.indexPathForSelectedRow{
                if let contactViewController = segue.destination as? ContactViewController{
                    contactViewController.professional = self.professionals[indexPath.row]
                    self.contactTable.deselectRow(at: indexPath, animated: true)
                }
            }
        }
        else if segue.identifier == "newContactSegue"{
            if let controller = segue.destination as? NewContactViewController{
                controller.professionalSet = self.professionalSet
            }
        }
    }

}
