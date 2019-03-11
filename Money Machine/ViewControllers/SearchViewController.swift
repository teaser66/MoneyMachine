//
//  SearchViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit
import SwiftForms

class SearchViewController: FormViewController {

  
    var entryType:String = ""
    
    var transResults:[TransactionObject] = []
    
    let categoryOptions = DataManager.transactionCategories()
    let userOptions = DataManager.transactionUsers()
    
    struct Static {
        static let usersTag = "users"
        static let dateTag = "date"
        static let descriptionTag = "description"
        static let categoriesTag = "categories"
        static let typeTag = "type"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let button = "button"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(SearchViewController.searchIt(_:)))
        
        
    }
    
    
    // Actions
    
    @objc func searchIt(_: UIBarButtonItem!) {
        
       //Go search!
        
        var theDict:Dictionary<String,Any> = [:]
        
        let formValues = self.form.formValues()
        
      
        
        var userId:String?
        var date:NSDate?
        var category:String?
        
        var hasSearchCriteria = false
        
        for (key, value) in formValues {
            
            if key == Static.typeTag {
                if let type = value as? Int {
                    if type == 0 {
                        theDict["type"] = "Expense"
                        hasSearchCriteria = true
                    }else if type == 1 {
                        theDict["type"] = "Saving"
                        hasSearchCriteria = true
                    }
                }
            }
          
            
            if key == Static.usersTag {
                if let user = value as? Int {
                        userId = userOptions[user]
                        theDict["userId"] = userId
                    hasSearchCriteria = true
                }
            }
            
            
            if key == Static.dateTag {
                if let theDate = value as? NSDate {
                    date = theDate
                    theDict["date"] = date
                    hasSearchCriteria = true
                }
            }
            
           
            
            if key == Static.categoriesTag {
                if let cat = value as? Int {
                        category = categoryOptions[cat]
                        theDict["category"] = category
                    hasSearchCriteria = true
                }
            }
        }
        
       
        
        if hasSearchCriteria == true {
            transResults = DataManager.searchForItWith(attributes: theDict)
            
            if transResults.count > 0 {
                self.performSegue(withIdentifier: "goResults", sender: self)
            }else {
                let alert = UIAlertController(title: "No Results", message: "Try refining your attributes", preferredStyle: .alert)
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
        }else {
            let alert = UIAlertController(title: "Nothing to search", message: "Please choose at least one attribute", preferredStyle: .alert)
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
    
    
   
    
    
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        
        let form = FormDescriptor(title: "Search Form")
        
        
        let section1 = FormSectionDescriptor(headerTitle: "Choose one or more options", footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.typeTag, type: .segmentedControl, title: "Transaction Type")
        row.configuration.selection.options = ([0, 1] as [Int]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "Expense"
            case 1:
                return "Saving"
            default:
                return ""
            }
        }
        
        row.configuration.cell.appearance = ["titleLabel.font" : UIFont.systemFont(ofSize: 20.0), "segmentedControl.tintColor" : UIColor.black]
        
        section1.rows.append(row)
        
        
        
        row = FormRowDescriptor(tag: Static.usersTag, type: .multipleSelector, title: "Users")
        
        let userOptions = DataManager.transactionUsers()
        var userInts:[Int] = []
        if userOptions.count > 0 {
            for i in 0...userOptions.count - 1 {
                userInts.append(i)
            }
        }
        
        row.configuration.selection.options = (userInts) as [AnyObject]
        row.configuration.selection.allowsMultipleSelection = false
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            return "\(userOptions[option])"
        }
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
       
        
        row = FormRowDescriptor(tag: Static.dateTag, type: .date, title: "Transaction Date")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        
        
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        
        row = FormRowDescriptor(tag: Static.categoriesTag, type: .multipleSelector, title: "Categories")
        
        var optionInts:[Int] = []
        if categoryOptions.count > 0 {
            for i in 0...categoryOptions.count - 1 {
                optionInts.append(i)
            }
        }
        
        row.configuration.selection.options = (optionInts) as [AnyObject]
        row.configuration.selection.allowsMultipleSelection = false
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            return "\(self.categoryOptions[option])"
        }
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Clear Form")
        row.configuration.button.didSelectClosure = { _ in
            self.loadForm()
        }
        //section3.rows.append(row)
        
        form.sections = [section1,section2,section3]
        
        self.form = form
        
    }
    
    
    // Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goResults") {
            
            let destinationVC = segue.destination as! ResultsViewController
            
                destinationVC.resultsArray = transResults
            
        }
    }



}

