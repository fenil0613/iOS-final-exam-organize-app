//
//  SettingsViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func upgradeToProClicked(_ sender: UIButton) {
        
        performSegue(withIdentifier: "upgrade-to-pro", sender: self)
        
    }
    
    @IBAction func rateTheAppClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "rate-the-app", sender: self)
    }

}
