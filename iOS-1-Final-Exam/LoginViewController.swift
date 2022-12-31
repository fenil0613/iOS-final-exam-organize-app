//
//  ViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet var facebookButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let token = AccessToken.current, !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start { (connection, result, error) in
                print("\(result ?? "error")")
            }
        } else {
            facebookButton = FBLoginButton()
            facebookButton.permissions = ["public_profile", "email"]
            facebookButton.delegate = self
        }
    }

    @IBAction func registerClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "login-to-register", sender: self)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "login-to-home", sender: self)
    }
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start { (connection, result, error) in
            print("\(result ?? "error")")
        }
        
        performSegue(withIdentifier: "login-to-home", sender: self)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User Logout")
    }
    
}
