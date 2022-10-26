//
//  DailyViewController.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/25/22.
//

import UIKit

class DailyViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    var hours = [Int]()
    var searchEvent = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initTime()
        setDayView()
        
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
        
    }
    
    func initTime(){
        
        for hour in 0...23 {
            hours.append(hour)
        }
    }
    
    func setDayView(){
        
        dayLbl.text = CalendarHelper().monthDayString(date: selectedDate)
        dayWeek.text = CalendarHelper().weekDayAsString(date: selectedDate)
        hourTable.reloadData()
        
    }
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    
    @IBOutlet weak var dayLbl: UILabel!
    
    
    @IBOutlet weak var dayWeek: UILabel!
    
    
    @IBOutlet weak var hourTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDailyID") as! DailyCell
        let hour = hours[indexPath.row]
        cell.timeLbl.text = formatHour(hour: hour)
        
        let events = Event().eventsForDateAndTime(date: selectedDate, hour: hour)
        setEvents(cell, events )
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            eventsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            tableView.endUpdates()
            
        }
        
    }
    
    
    func setEvents(_ cell: DailyCell, _ events: [Event]){
        hideAll(cell)
        switch events.count {
        case 1:
            setEvent1(cell, events[0])
        case 2:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
        case 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setEvent3(cell, events[2])
            
        case let count where count > 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setMoreEvents(cell, events.count - 2)
        default:
            break
            
        }
    }
    
    
    func setMoreEvents(_ cell: DailyCell, _ count: Int){
        
        cell.event3.isHidden = false
        cell.event3.text = String(count) + " More Events"
    }
    
    
    func setEvent1(_ cell: DailyCell, _ event: Event){
        
        cell.event1.isHidden = false
        cell.event1.text = event.name
    }
    
    func setEvent2(_ cell: DailyCell, _ event: Event){
        
        cell.event2.isHidden = false
        cell.event2.text = event.name
    }
    func setEvent3(_ cell: DailyCell, _ event: Event){
        
        cell.event3.isHidden = false
        cell.event3.text = event.name
    }
    
    
    func hideAll(_ cell: DailyCell){
        cell.event1.isHidden = true
        cell.event2.isHidden = true
        cell.event3.isHidden = true

    }
    
    
    func formatHour(hour: Int) -> String{
        
        return String(format: "%02d:%02d", hour, 0)
    }
    
    
    @IBAction func nxtDay(_ sender: Any) {
        
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
        setDayView()
    }
    
    
    @IBAction func prvDay(_ sender: Any) {
        
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -1)
        setDayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDayView()
    }
    
}

extension DailyViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String,  _ event: Event) {
        
    }
    
}
