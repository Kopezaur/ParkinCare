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
    var indexPath : IndexPath? = nil
    var professionalsViewModel : ProfessionalSetViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if let professional = self.professionalsViewModel!.getProfessional(at: self.indexPath!) {
            self.professional = professional
            initLabels()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLabels(){
        self.lastnameLabel.text = self.professional!.lastname
        self.firstnameLabel.text = self.professional!.firstname
        self.titleLabel.text = Presenter.emptyString(text: self.professional!.title?.name)
        self.organizationLabel.text = Presenter.emptyString(text: self.professional!.organization)
        self.emailLabel.text = Presenter.emptyString(text: self.professional!.email)
        self.numTelLabel.text = Presenter.emptyString(text: self.professional!.numTel)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toEditContactSegue"{
            if let editContactViewController = segue.destination as? editContactViewController{
                editContactViewController.professional = self.professional
            }
        }
    }
    
    @IBAction func unwindToThisViewWithSender(_ segue: UIStoryboardSegue){
        if let professional = self.professionalsViewModel!.getProfessional(at: self.indexPath!) {
            self.professional = professional
            initLabels()
        }
    }

}
