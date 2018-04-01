//
//  ViewController.swift
//  ParkinCare
//
//  Created by Kopezaur on 2/20/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications


class ViewController: UIViewController {
    
    let introNotification = Notification.Name(rawValue:"IntroNotification")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DEPRECIATED
//        let nc = NotificationCenter.default
//        nc.addObserver(forName:introNotification, object:nil, queue:nil, using: catchIntroNotification)
        
        
        // MARK: - Seeders -
        
        if(UserDAO.count != 1){
            if(UserDAO.count > 1){
                var users : [User] = UserDAO.search()!
                for i in 0..<users.count {
                    UserDAO.delete(user: users[i])
                }
            }
            var component = DateComponents()
            component.calendar = Calendar.current
            component.hour = 8
            component.minute = 0
            let startDate = component.date
            component.hour = 20
            component.minute = 0
            let endDate = component.date
            
            let _ : User = User(lastname: "", firstname: "", address: "", email: "", numTel: "", activityRemind: true, startEvaluation: startDate!, endEvaluation: endDate!, hourIntervalEvaluation: 1)
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
        
//        let nc = NotificationCenter.default
//        let calendar = Calendar.current
//        let date = calendar.date(byAdding: .minute, value: 1, to: Date())
//        nc.post(name:introNotification,
//                object: nil,
//                userInfo:["message":"Yo!", "date":date!])
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

    // MARK: - Navigation
    
    var evaluation : Evaluation? = nil
    @IBAction func evaluationsButtonClicked(_ sender: Any) {
        
        // Verification qu'il y a bien une évaluation à remplir
        /*var evaluations : [Evaluation]? = EvaluationDAO.fetchAll()
        let calendar : Calendar = Calendar.current
        let currentDate : Date = Date()
        let dateMax = calendar.date(byAdding: .minute, value: 15, to: currentDate)
        let dateMin = calendar.date(byAdding: .minute, value: -15, to: currentDate)
        if(evaluations == nil || evaluations?.count == 0 || (evaluations!.last!.dateTime! as Date) < dateMin!){
            DialogBoxHelper.alert(view: self, WithTitle: "Aucune évaluation.")
        }
        else{
            var index : Int = 0
            while(index < evaluations!.count) {
                let dateTime : Date = evaluations![index].dateTime! as Date
                if(dateTime < dateMax! && dateTime > dateMin!){
                    self.evaluation = evaluations![index]
                }
                index = index + 1
            }
            if(self.evaluation == nil){
                let nextEvaluation : Evaluation = evaluations![index]
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let date = formatter.string(from: (nextEvaluation.dateTime! as Date))
                formatter.dateFormat = "HHhmmmin"
                let hour = formatter.string(from: (nextEvaluation.dateTime! as Date))
                DialogBoxHelper.alert(view: self, WithTitle: "Prochaine évaluation le " + date + " à " + hour)
            }
            else{
                performSegue(withIdentifier: "toEvaluationSegue", sender: self)
            }
        }*/
        performSegue(withIdentifier: "toEvaluationSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let evaluationViewController = segue.destination as? EvaluationViewController{
            evaluationViewController.evaluation = self.evaluation
        }
    }
    
    @IBAction func unwindToHomeView(sender: UIStoryboardSegue) {
        if let evaluationViewController = sender.source as? EvaluationViewController {
            DialogBoxHelper.alert(view: self, WithTitle: "Enregistré ! test")
        }
    }
    
}

