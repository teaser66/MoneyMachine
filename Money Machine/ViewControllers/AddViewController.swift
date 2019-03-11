//
//  AddViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit
import SwiftForms


class AddViewController: FormViewController {
    
    var entryType:String = ""
    
    
    struct Static {
        static let userTag = "user"
        static let dateTag = "date"
        static let amountTag = "amount"
        static let descriptionTag = "description"
        static let categoryTag = "category"
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddViewController.submit(_:)))
        
        
    }
    
    
    // Actions
    
    @objc func submit(_: UIBarButtonItem!) {
        
        let message = ""
        
        let alertController = UIAlertController(title: "Save Details?", message: message, preferredStyle: .alert)
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(cancel)
        
        let save = UIAlertAction(title: "Save", style: .default) { (action) in
            
            // Save to DB
            
        }
        
        alertController.addAction(save)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        
        let form = FormDescriptor(title: (entryType == "expense" ? "Expense Form" : "Saving Form"))
        
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        var row = FormRowDescriptor(tag: Static.categoryTag, type: .multipleSelector, title: "Users")
        
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
        
        row = FormRowDescriptor(tag: Static.userTag, type: .name, title: "Add User ID")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Rob15" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        
        row = FormRowDescriptor(tag: Static.dateTag, type: .date, title: "Transaction Date")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        
        
        row = FormRowDescriptor(tag: Static.textView, type: .multilineText, title: "Description")
        section2.rows.append(row)
        

        row = FormRowDescriptor(tag: Static.amountTag, type: .decimal, title: "Amount")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 0.00" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        
        row = FormRowDescriptor(tag: Static.categoryTag, type: .multipleSelector, title: "Categories")
        
        let categoryOptions = DataManager.transactionCategories()
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
            return "\(categoryOptions[option])"
        }
        section2.rows.append(row)
        
        form.sections = [section1,section2]
        
        self.form = form
    }


}

