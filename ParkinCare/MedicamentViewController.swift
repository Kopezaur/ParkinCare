//
//  MedicamentViewController.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 13/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class MedicamentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var medicamentNames : [String] = ["toto","tata"]
    
    @IBOutlet weak var MedicamentTable: UITableView!
    @IBAction func addMedicament(_ sender: Any) {
        self.medicamentNames.append("tutu")
        self.MedicamentTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.MedicamentTable.dequeueReusableCell(withIdentifier: "medicamentCell",for: indexPath) as! MedicamentTableViewCell
        cell.medicamentNameLabel.text = self.medicamentNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicamentNames.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    func delete(medicamentWithIndex index : Int) -> Bool{
        guard let context = self.getContext(errorMsg:"ereur") else {
            return false
        }
        let medicament = self.medicamentNames[index]
        context.delete(medicament)
        do{
            try context.save()
            self.medicamentNames.remove(at: index)
            return true
        }
        catch let error as NSError {
            self.alert(error : error)
            return false
        }
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
