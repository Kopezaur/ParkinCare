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

    @IBOutlet weak var ajdB: UIButton!
    @IBOutlet var button: UIView!
    @IBOutlet weak var prescB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ajdB.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

