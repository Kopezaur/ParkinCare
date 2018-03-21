//
//  ContactsViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var professionalSet : ProfessionalSetModel = ProfessionalSetModel()

    @IBOutlet weak var contactTable: UITableView!
    
    

    var professionals : [ProfessionalModel] = [ProfessionalModel(firstname:"Patrick", lastname:"Bruel", title:"Dentiste", address:"hopital", email:"f@f.f", numTel:"05142345", organization:"orgnisation")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        professionals = self.professionalSet.getAll()
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

    @IBAction func unwindToContactsViewController(_ segue: UIStoryboardSegue){
        self.contactTable.reloadData()
    }
    
    
    
    // MARK: - Navigation
    
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
