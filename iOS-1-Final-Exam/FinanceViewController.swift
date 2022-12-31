//
//  FinanceViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit
import FirebaseFirestore

class FinanceViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var financeTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var amounts: [Amount] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.layer.masksToBounds = true
        
        financeTableView.dataSource = self
        financeTableView.delegate = self
        financeTableView.register(UINib(nibName: "FinanceTableViewCell", bundle: nil), forCellReuseIdentifier: "finance-cell")
        
        loadFinanceAmounts()
        
    }
    
    func loadFinanceAmounts() {
        
        db.collection("FinanceAmounts").getDocuments { querySnapshot, error in
            self.amounts = []
            if error == nil {
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        let amount = Amount(title: document["title"] as! String,
                                            amount: document["amount"] as! Int)
                        self.amounts.append(amount)
                        DispatchQueue.main.async {
                            self.financeTableView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "new-amount", sender: self)
    }
    
}

extension FinanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = financeTableView.dequeueReusableCell(withIdentifier: "finance-cell", for: indexPath) as! FinanceTableViewCell
        
        cell.amountTitle.text = amounts[indexPath.row].title
        cell.amountCategory.text = "default category"
        cell.amount.text = "\(amounts[indexPath.row].amount)"
        
        return cell
    }
    
}
