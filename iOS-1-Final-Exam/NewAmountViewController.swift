//
//  NewAmountViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-18.
//

import UIKit
import FirebaseFirestore

class NewAmountViewController: UIViewController {

    @IBOutlet weak var amountTitle: UITextField!
    @IBOutlet weak var amountCategory: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountDate: UIDatePicker!
    
    let db = Firestore.firestore()
    
    var newAmounts: [Amount] = []
    var amount: Int?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func amountSliderChanged(_ sender: UISlider) {
        amountLabel.text = String(format: "%.0f", sender.value)
        amount = Int(sender.value)
    }
    
    @IBAction func addAmountClicked(_ sender: UIButton) {
        
        if let title = amountTitle.text, let amount = amountLabel.text {
            
            db.collection("FinanceAmounts").addDocument(data: ["title" : title, "amount": Int(amount)!]) { (error) in
                
                if error == nil {
                    print("Amount Data saved successfully.")
                } else {
                    print("Error while inserting amount data")
                }
            }
        }
        
        performSegue(withIdentifier: "add-to-list", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add-to-list" {
            
            let destination = segue.destination as? FinanceViewController
            destination?.amounts = newAmounts
        }
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: sender.date)
    }
    
}
