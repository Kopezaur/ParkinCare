//
//  ContactViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 21/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numTelLabel: UILabel!
    
    
    var professional : Professional? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let aprofessional = self.professional{
            self.lastnameLabel.text = aprofessional.lastname
            self.firstnameLabel.text = aprofessional.firstname
            self.titleLabel.text = aprofessional.title
            self.organizationLabel.text = aprofessional.organization
            self.emailLabel.text = aprofessional.email
            self.numTelLabel.text = aprofessional.numTel
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toEditContactSegue"{
            if let editContactViewController = segue.destination as? editContactViewController{
                editContactViewController.professional = self.professional
            }
        }
    }
    
    @IBAction func unwindToContactViewController(_ segue: UIStoryboardSegue){
        let newProfessional = Professional.search(professional:self.professional!)
        self.professional?.lastname = newProfessional!.lastname
        self.professional?.firstname = newProfessional!.firstname
        self.professional?.title = newProfessional!.title
        self.professional?.organization = newProfessional!.organization
        self.professional?.email = newProfessional!.email
        self.professional?.numTel = newProfessional!.numTel
    }

}
