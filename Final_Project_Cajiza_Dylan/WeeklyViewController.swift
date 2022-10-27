//  Created by Aristoteles 10/23/22


import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
							UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    @IBOutlet var searchBar: UISearchBar!

	
	@IBOutlet weak var monthLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var collectionView: UICollectionView!
	
    var searching = false
    var totalSquares = [Date]()
    
    var filteredData: [String]!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setCellsView()
		setWeekView()
        
        searchBar.delegate = self
        
        
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
	}
	
	func setCellsView()
	{
		let width = (collectionView.frame.size.width - 2) / 7
		let height = (collectionView.frame.size.height - 2)
		
		let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		flowLayout.itemSize = CGSize(width: width, height: height)
	}
	
	func setWeekView()
	{
		totalSquares.removeAll()
		
		var current = CalendarHelper().sundayForDate(date: selectedDate)
		let nextSunday = CalendarHelper().addDays(date: current, days: 7)
		
		while (current < nextSunday)
		{
			totalSquares.append(current)
			current = CalendarHelper().addDays(date: current, days: 1)
		}
		
		monthLabel.text = CalendarHelper().monthString(date: selectedDate)
			+ " " + CalendarHelper().yearString(date: selectedDate)
		collectionView.reloadData()
		tableView.reloadData()
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		totalSquares.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
		
		let date = totalSquares[indexPath.item]
		cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
		
		if(date == selectedDate)
		{
			cell.backgroundColor = UIColor.systemBlue
		}
		else
		{
			cell.backgroundColor = UIColor.white
		}
		
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		selectedDate = totalSquares[indexPath.item]
		collectionView.reloadData()
		tableView.reloadData()
	}
	
	@IBAction func previousWeek(_ sender: Any)
	{
		selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
		setWeekView()
	}
	
	@IBAction func nextWeek(_ sender: Any)
	{
		selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
		setWeekView()
	}
	
	override open var shouldAutorotate: Bool
	{
		return false
	}
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return Event().eventsForDate(date: selectedDate).count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
		let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
		cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.date)
        
		return cell
	}
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            eventsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            tableView.endUpdates()
            
        }
        
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		setWeekView()
	}
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = []
        
    
        
        for event in eventsList {
            
            if event.name.contains(searchText){
                
                filteredData.append(event.name)
                
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        
        
    }
    
    
    
}


    
   

