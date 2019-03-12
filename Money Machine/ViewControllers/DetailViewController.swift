//
//  DetailViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var dateLabel:UILabel?
    @IBOutlet var userLabel:UILabel?
    @IBOutlet var amountLabel:UILabel?
    @IBOutlet var categoryLabel:UILabel?
    @IBOutlet var descriptionLabel:UILabel?
    
    @IBOutlet var typeImageView:UIImageView?
    
    public var transactionObject:TransactionObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.title = "Detail"
        setupView()
    }
    
    
   // Methods
    
    func setupView() {
        
        userLabel?.text = "User: \(transactionObject!.userId)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date = dateFormatterPrint.string(from: transactionObject!.transactionDate)
            
        dateLabel?.text = "Date: \(date)"
        let amount: Decimal = transactionObject!.transactionAmount
        amountLabel?.text = "Amount: $\(amount)"
        categoryLabel?.text = "Category: \(transactionObject!.category)"
        
        if let theText = transactionObject?.transactionDescription {
            descriptionLabel?.text = "Optional Description: \(theText)"
        }
        
        
        typeImageView?.image = UIImage(named: (transactionObject!.type == "Expense" ? "receipt" : "pig_icon"))
        
    }


}

