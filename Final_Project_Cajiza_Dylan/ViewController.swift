//
//  ViewController.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/20/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tDays.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "callCell", for: indexPath) as! CalCell
        
        cell.DayLbl.text = tDays[indexPath.item]
        
        return cell
        
    }
    
    
    
    @IBOutlet weak var monthLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dateSelector = Date()
    var tDays = [String]()
    
    func setCellsView(){
        
        let width = (collectionView.frame.size.width - 2) / 7
        let height = (collectionView.frame.size.height - 2) / 7
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)

    }
    
    func setMonthView(){
        tDays.removeAll()
        
        let daysInMonth = CallMeth().daysInMonth(date: dateSelector)
        let firstDayOfMonth = CallMeth().firstofMonth(date: dateSelector)
        let startingSpaces = CallMeth().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42){
            
            if(count <= startingSpaces || count - startingSpaces > daysInMonth){
                tDays.append("")
                
            }
            else{
                tDays.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLbl?.text = CallMeth().monthString(date: dateSelector)
            + " " + CallMeth().yearString(date: dateSelector)
        collectionView.reloadData()
    }
    
    
   
    
    @IBAction func PrMonth(_ sender: Any) {
        
        dateSelector = CallMeth().minusMonth(date: dateSelector)
        setMonthView()
    }
    
    
    @IBAction func NxtMonth(_ sender: Any) {
        
        dateSelector = CallMeth().plusMonth(date: dateSelector)
        setMonthView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }

}

