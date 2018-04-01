//
//  ViewController.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    let introNotification = Notification.Name(rawValue:"IntroNotification")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(forName:introNotification, object:nil, queue:nil, using: catchIntroNotification)
        
        // MARK: - Seeders -
        
        if(UserDAO.count == 0){
            UserDAO.add(user: User(lastname: "", firstname: "", address: "", email: "", numTel: "", activityRemind: true))
        }
        
        var titles : [String] = ["Kinésithérapeute", "Orthophoniste", "Infirmier", "Psychologue clinicien",
                                 "Neuropsychologue", "Neurologue", "Medecin generaliste", "Psychiatre",
                                 "Neurochirugien", "Médecin de structure antidouleur", "Gériatre",
                                 "Médecin spécialiste en médecin physique", "Gastro-entérologue",
                                 "Urologue", "Gynécologue", "Sexologue", "Ophtalmologiste", "ORL-phoniatre",
                                 "Rhumatologue", "Chirurgien orthopédique", "Pneumologue", "Cardiologue",
                                 "Médecin du travail", "Chirurgien-dentiste", "Ergothérapeute",
                                 "Psychometricien", "Pédicure-podologue", "Diététicien", "Orthoptiste",
                                 "Assistant de service social", "Personnel de transport sanitaire",
                                 "Personnel de soins infirmiere a domicile", "Agent a domicile",
                                 "Assistante de vie", "Personnel des services d'aide a la personne",
                                 "Personnels de coordination gérontologique",
                                 "Maison départamentale des persones handicapées",
                                 "Educateur medico-sportif", "Association de patients"]
        
        if(titles.count > TitleDAO.count){
            for i in 0 ..< titles.count {
                let title = titles[i]
                if(TitleDAO.count(name: title) == 0){
                    TitleDAO.add(name: title)
                }
            }
        }
        
        var symptomes : [String] = ["Somnolence", "Chute", "Hallucination", "Prise de dispersible", "Clic / bolus d'Apokinon"]
        
        if(symptomes.count > SymptomeDAO.count){
            for i in 0 ..< symptomes.count {
                let symptome = symptomes[i]
                if(SymptomeDAO.count(name: symptome) == 0){
                    SymptomeDAO.add(name: symptome)
                }
            }
        }
        
        var medicaments : [String] = ["Modopar (62,5mg)", "Modopar (125mg)", "Modopar (250mg)", "Modopar LP (125mg)", "Modopar Dispersible (125mg)", "Sinemet (100g)", "Sinemet (250mg)", "Sinemet LP (100g)", "Sinemet LP(200mg)", "Stalevo (50mg)", "Stalevo (75mg)", "Stalevo (100mg)", "Stalevo (125mg)", "Stalevo (150mg)", "Stalevo (175mg)", "Stalevo (200mg)", "Parlodel (2,5mg)", "Parlodel (5mg)", "Parlodel (10mg)", "Trivastal (20mg)", "Trivastal LP (50mg)", "Sifrol (0,18mg)", "Sifrol (0,7mg)", "Sifrol LP (0,26mg)", "Sifrol LP (0,52mg)", "Sifrol LP (1,05mg)", "Sifrol LP (2,1mg)", "Requip (0,25mg)", "Requip (0,5mg)", "Requip (1mg)", "Requip (2mg)", "Requip (5mg)", "Requip LP (2mg)", "Requip LP (4mg)", "Requip LP (8mg)", "Neupro (Patch) (2mg)", "Neupro (Patch) (4mg)", "Neupro (Patch) (6mg)", "Neupro (Patch) (8mg)", "Mantadix (100mg)", "Azilect (1mg)", "Comtan (200mg)", "Artane (2mg)", "Artane (5mg)", "Parkinane LP (2mg)", "Parkinane LP (5mg)", "Lepticur (10mg)", "Leponex (25mg)", "Leponex (100mg)", "Exelon (1,5g)", "Exelon (3mg)", "Exelon (4,5mg)", "Exelon (6mg)", "Exelon (Patch) (4,6mg)", "Exelon (Patch) (9,5mg)"]
        
        if(medicaments.count > MedicamentDAO.count){
            for i in 0 ..< medicaments.count {
                let medicament = medicaments[i]
                if(MedicamentDAO.count(name: medicament) == 0){
                    MedicamentDAO.add(name: medicament)
                }
            }
        }
    }

    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nc = NotificationCenter.default
        nc.post(name:introNotification,
                object: nil,
                userInfo:["message":"Yo!", "date":Date()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/

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
    
    // MARK: - Notifications -
    
    func catchIntroNotification(notification: Notification) -> Void {
        guard let userInfo = notification.userInfo,
            let message  = userInfo["message"] as? String,
            let date     = userInfo["date"]    as? Date else {
                print("No userInfo found in notification")
                return
        }
        
        let alert = UIAlertController(title: "Notification!",
                                      message:"\(message) received at \(date)",
            preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

