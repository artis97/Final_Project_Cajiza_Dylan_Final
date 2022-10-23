//
//  EditEventViewController.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/23/22.
//

import UIKit

class EditEventViewController: UIViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datePicker.date = dateSelector
    }
    
    @IBAction func saveAction(_ sender: Any)
    {
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}
