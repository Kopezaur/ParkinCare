//
//  DialogBoxHelper.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/13/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import UIKit

class DialogBoxHelper {
    
    //
    /// shows an alert box with two messages
    ///
    /// - Parameters:
    ///     - title: title of dialog box as main message
    ///     - msg: additional message used to describe context or additional information
    class func alert(view: UIViewController, WithTitle title: String, andMessage msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    /// shows an alert to inform about an error
    ///
    /// - Parameter error: error we want information about
    class func alert(view: UIViewController, error : NSError) {
        self.alert(view: view, WithTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
}
