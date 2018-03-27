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
    
    var rdv : RDV? = nil
    var indexPath : IndexPath? = nil
    var rdvViewModel : RDVSetViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let rdv = self.rdvViewModel!.getRDV(at: self.indexPath!) {
            self.rdv = rdv
            initLabels()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initLabels(){
        let dateTime = self.rdv!.dateTime!as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        self.lastnameLabel.text = self.rdv!.professional!.lastname
        self.firstnameLabel.text = self.rdv!.professional!.firstname
        self.titleLabel.text = self.rdv!.professional!.title
        self.organizationLabel.text = self.rdv!.professional!.organization
        self.emailLabel.text = self.rdv!.professional!.email
        self.numTelLabel.text = self.rdv!.professional!.numTel
        self.dateLabel.text = date
        self.hourLabel.text = hour
        self.locationLabel.text = self.rdv!.location
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
 
    @IBAction func unwindToContactViewController(_ segue: UIStoryboardSegue){
        self.rdv = self.rdvViewModel!.getRDV(at: self.indexPath!)
        initLabels()
    }

}