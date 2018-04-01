//
//  RDVViewController.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 26/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class RDVViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numTelLabel: UILabel!
    @IBOutlet weak var remindLabel: UILabel!
    
    var rdv : RDV? = nil
    var indexPath : IndexPath? = nil
    var rdvViewModel : RDVSetViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let rdv = self.rdvViewModel!.getRDV(at: self.indexPath!) {
            self.rdv = rdv
            initLabels()
        }
    }
    
    func initLabels(){
        let dateTime = self.rdv!.dateTime!as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        
        //Verfification qu'il existe bien un professionel
        if(self.rdv?.professional == nil){
            self.lastnameLabel.text = "Inconnu"
            self.firstnameLabel.text = "Inconnu"
            self.titleLabel.text = "Inconnu"
            self.organizationLabel.text = "Inconnu"
            self.emailLabel.text = "Inconnu"
            self.numTelLabel.text = "Inconnu"
        }
        else{
            self.lastnameLabel.text = self.rdv!.professional!.lastname
            self.firstnameLabel.text = self.rdv!.professional!.firstname
            self.titleLabel.text = Presenter.emptyString(text: self.rdv!.professional!.title!.name)
            self.organizationLabel.text = Presenter.emptyString(text: self.rdv!.professional!.organization)
            self.emailLabel.text = Presenter.emptyString(text: self.rdv!.professional!.email)
            self.numTelLabel.text = Presenter.emptyString(text: self.rdv!.professional!.numTel)
        }
        
        self.dateLabel.text = date
        self.hourLabel.text = hour
        self.locationLabel.text = self.rdv!.location
        self.remindLabel.text = "Rappel : " + formatter.string(from: (self.rdv?.dateTimeReminder)! as Date)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toEditRDVSegue"{
            if let editContactViewController = segue.destination as? EditRDVViewController{
                editContactViewController.rdv = self.rdv
            }
        }
    }
 
    @IBAction func unwindToThisViewWithSender(_ segue: UIStoryboardSegue){
        if let rdv = self.rdvViewModel!.getRDV(at: self.indexPath!) {
            self.rdv = rdv
            initLabels()
        }
    }

}
