//
//  ActivityViewController.swift
//  ParkinCare
//
//  Created by julia on 01/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit
import UserNotifications

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var activity : Activity? = nil
    var indexPath : IndexPath? = nil
    var activityViewModel : ActivitySetViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let activity = self.activityViewModel!.getActivity(at: self.indexPath!) {
            self.activity = activity
            initLabels()
        }
    }

    func initLabels(){
        let dateTime = self.activity!.dateTime!as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: dateTime)
        formatter.dateFormat = "HH:mm"
        let hour = formatter.string(from: dateTime)
        
        //Verfification qu'il existe bien un professionel
        
    
        self.titleLabel.text = self.activity!.title
        self.descriptionLabel.text = self.activity!.desc
        self.dateLabel.text = date
        self.hourLabel.text = hour
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        // Delete the notification
        NotificationManager.deleteNotification(notificationIdentifier: self.activityViewModel!.getActivity(at: self.indexPath!)!.notificationIdentifier!)
        // Delete the entity
        ActivityDAO.delete(activity: self.activityViewModel!.getActivity(at: self.indexPath!)!)
        performSegue(withIdentifier: "exit", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CongratulationViewController{
            ActivityDAO.delete(activity: (activityViewModel?.getActivity(at: indexPath!)!)!)
        }
    }
 

}
