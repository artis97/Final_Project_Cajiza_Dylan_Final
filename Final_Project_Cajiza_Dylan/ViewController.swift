//
//  ViewController.swift
//  Final_Project_Cajiza_Dylan
//
//  Created by Aristoteles on 10/20/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var monthLbl: UILabel!
    
    @IBOutlet weak var ColView: UICollectionView!
    
    var dateSelector = Date()
    var tDays = [String]()
    
    func setCellsView(){
        
        let width = (ColView.frame.size.width - 2) / 8
        let height = (ColView.frame.size.height - 2) / 8
        
        let flowLayout = ColView.collectionViewLayout as! UICollectionViewLayout
        

    }
    
    
    @IBAction func PrMonth(_ sender: Any) {
    }
    
    
    @IBAction func NxtMonth(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
    }


}

