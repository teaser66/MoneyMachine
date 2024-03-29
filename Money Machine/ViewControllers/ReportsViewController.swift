//
//  ReportsViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit
import SwiftForms

class ReportsViewController: FormViewController {

    var entryType:String = ""
    var reportType:String = ""
    
    var transResults:[TransactionObject] = []
    var resultsToPass:[TransactionObject] = []
    
    let categoryOptions = DataManager.transactionCategories()
    let userOptions = DataManager.transactionUsers()
    
    struct Static {
        static let segmented = "segmented"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Generate", style: .plain, target: self, action: #selector(SearchViewController.searchIt(_:)))
        
        
    }
    
    
    // Methods
    
   
    
    
    // Actions
    
    @objc func searchIt(_: UIBarButtonItem!) {
        
        //Go search!
        
        var theDict:Dictionary<String,Any> = [:]
        
        let formValues = self.form.formValues()
        
        // Loop through form values and validate
        for (key, value) in formValues {
            
            
            if key == Static.segmented {
                if let type = value as? Int {
                    if type == 0 {
                        theDict["range"] = "day"
                        reportType = "day"
                    }else if type == 1 {
                        theDict["range"] = "week"
                        reportType = "week"
                    }else if type == 2 {
                        theDict["range"] = "month"
                        reportType = "month"
                    }else if type == 3 {
                        theDict["range"] = "year"
                        reportType = "year"
                    }
                }
            }
        
        transResults = DataManager.searchForItWith(attributes: theDict)
        
        if transResults.count > 0 {
            // Got results, move to report page
            resultsToPass = TransactionManager.combineResults(results: transResults)
            self.performSegue(withIdentifier: "goReportDetail", sender: self)
        }else {
            // No results, tell user
            let alert = UIAlertController(title: "No Results", message: "Try another date range", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
        
    }
    
    
    
    
    
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        // Genearate form UI, using SwiftForms
        let form = FormDescriptor(title: "Report Generator")
        
        
        let section1 = FormSectionDescriptor(headerTitle: "Choose a date range", footerTitle: nil)
        
        let row = FormRowDescriptor(tag: Static.segmented, type: .segmentedControl, title: "")
        row.configuration.selection.options = ([0, 1, 2, 3] as [Int]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "Daily"
            case 1:
                return "Weekly"
            case 2:
                return "Monthly"
            case 3:
                return "Yearly"
            default:
                return ""
            }
        }
        
        row.configuration.cell.appearance = ["titleLabel.font" : UIFont.systemFont(ofSize: 20.0), "segmentedControl.tintColor" : UIColor.black]
        
        section1.rows.append(row)
        
        
        
        form.sections = [section1]
        
        self.form = form
        
    }
    
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goReportDetail") {
            
            
            let destinationVC = segue.destination as! ResultsViewController
            
            // Pass data to next screen
            destinationVC.resultsArray = resultsToPass
            destinationVC.reportDetailsArray = transResults
            destinationVC.reportType = reportType
            
        }
    }
    


}

