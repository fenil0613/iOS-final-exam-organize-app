//
//  CalenderViewController.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-17.
//

import UIKit

class CalenderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        
        setCellsView()
        setMonthView()
    }
    
    func setCellsView() {
        let width = (calenderCollectionView.frame.width - 2) / 8
        let height = (calenderCollectionView.frame.height - 2) / 8
        
        let flowLayout = calenderCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let dayInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while (count <= 42) {
            
            if (count <= startingSpaces || count - startingSpaces > dayInMonth) {
                totalSquares.append("")
            }
            else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
        + " " + CalendarHelper().yearString(date: selectedDate)
        calenderCollectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calenderCollectionView.dequeueReusableCell(withReuseIdentifier: "calender-cell", for: indexPath) as! CalenderCollectionViewCell
        
        cell.dateLable.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    @IBAction func nextMonthClicked(_ sender: UIButton) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func previousMonthClicked(_ sender: UIButton) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}
