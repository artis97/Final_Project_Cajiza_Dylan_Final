//
//  ViewController.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/20/22.
//

import UIKit

var dateSelector = Date()

class WeekViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    var tDays = [Date]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalCell
        
        
        let date = tDays[indexPath.item]
        cell.DayLbl.text = String(CallMeth().daysofMonth(date: date))
        
        if(date == dateSelector){
            
            cell.backgroundColor = UIColor.systemGreen
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        
        
        
        return cell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dateSelector = tDays[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var monthLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func setCellsView(){
        
        let width = (collectionView.frame.size.width - 2) / 7
        let height = (collectionView.frame.size.height - 2) / 7
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)

    }
    
    func setWeekView(){
        tDays.removeAll()
        
        var curr = CallMeth().sundayFordate(date: dateSelector)
        let nxtSunday = CallMeth().addDays(date: curr, days: 7)
        
        
        while(curr < nxtSunday){
            
            tDays.append(curr)
            curr = CallMeth().addDays(date: curr, days: 1)
        }
        
        monthLbl?.text = CallMeth().monthString(date: dateSelector)
            + " " + CallMeth().yearString(date: dateSelector)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    
   
    
    @IBAction func PrWeek(_ sender: Any) {
        
        dateSelector = CallMeth().addDays(date: dateSelector, days: -7)
        setWeekView()
    }
    
    
    @IBAction func NxtWeek(_ sender: Any) {
        
        dateSelector = CallMeth().addDays(date: dateSelector, days: 7)
        setWeekView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Event().eventsForDate(date: dateSelector).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event = Event().eventsForDate(date: dateSelector)[indexPath.row]
        cell.eventLabel.text = event.name + " " + CallMeth().timeString(date: event.date)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

