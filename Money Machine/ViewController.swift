//
//  ViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var expenseButton:UIButton?
    @IBOutlet var saveButton:UIButton?
    @IBOutlet var reportButton:UIButton?
    @IBOutlet var searchButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.title = "Money Machine"
    }
    
    
    // Actions
    
    @IBAction func goExpense(sender:UIButton) {
        performSegue(withIdentifier: "goAdd", sender: sender)
    }
    
    @IBAction func goSave(sender:UIButton) {
        performSegue(withIdentifier: "goAdd", sender: sender)
    }
    
    @IBAction func goReports(sender:UIButton) {
        performSegue(withIdentifier: "goReports", sender: sender)
    }
    
    @IBAction func goSearch(sender:UIButton) {
        performSegue(withIdentifier: "goSearch", sender: sender)
    }
    
    
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goAdd") {
            
            let destinationVC = segue.destination as! AddViewController
            
            if ((sender as! UIButton) == expenseButton) {
                
            }else if ((sender as! UIButton) == saveButton) {
                
            }
            
        }
    }


}

