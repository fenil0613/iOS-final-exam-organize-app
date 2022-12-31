//
//  SignupViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signupCLicked(_ sender: UIButton) {
        performSegue(withIdentifier: "signup-to-home", sender: self)
    }

}
