//
//  ResultsViewController.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/11/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    public var resultsArray:[TransactionObject]?
    public var resultsArrayToPass:[TransactionObject]?
    public var reportDetailsArray:[TransactionObject]?
    public var reportType = ""
    var transObjectToPass:TransactionObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    // Table Data/Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell\(indexPath.row)")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell\(indexPath.row)")
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            
            
            if let transObject = resultsArray?[indexPath.row] {
                
                let date = dateFormatterPrint.string(from: transObject.transactionDate)
                
                var headerText = ""
                var subText = ""
                var isReport = false
                if reportType == "day" {
                    isReport = true
                    headerText = "\(date)"
                    subText = "\(self.createReport(object: transObject))"
                }else if reportType == "week" {
                    isReport = true
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisWeekStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisWeekEnd()!)
                    headerText = "\(startDate) - \(endDate)"
                    subText = "\(self.createReport(object: transObject))"
                }else if reportType == "month" {
                    isReport = true
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisMonthStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisMonthEnd()!)
                    headerText = "\(startDate) - \(endDate)"
                    subText = "\(self.createReport(object: transObject))"
                }else if reportType == "year" {
                    isReport = true
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisYearStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisYearEnd()!)
                    headerText = "\(startDate) - \(endDate)"
                    subText = "\(self.createReport(object: transObject))"
                }else {
                    headerText = "\(transObject.userId) - \(date) "
                    subText = "$\(transObject.transactionAmount) - \(transObject.category)"
                    
                    if transObject.transactionDescription.count > 0 {
                        subText = subText + "\n\(transObject.transactionDescription)"
                    }
                }
                
                
                
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.lineBreakMode = .byWordWrapping
                cell?.textLabel?.text = headerText
                cell?.detailTextLabel?.numberOfLines = 0
                cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
                cell?.detailTextLabel?.text = subText
                cell?.imageView?.contentMode = .scaleAspectFit
                
                if isReport == false {
                    cell?.imageView?.image = UIImage(named: (transObject.type == "Expense" ? "receipt" : "pig_icon"))
                }else {
                    cell?.imageView?.image = UIImage(named: "budget-md")
                }
                
                let itemSize = CGSize(width:42.0, height:42.0)
                UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0)
                let imageRect = CGRect(x:0.0, y:0.0, width:itemSize.width, height:itemSize.height)
                cell?.imageView?.image!.draw(in:imageRect)
                cell?.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                
                cell?.accessoryType = .disclosureIndicator
            }
            
           
           
        }
        
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let transObject = resultsArray?[indexPath.row] {
            
         
            if reportType == "day" || reportType == "week" || reportType == "month" || reportType == "year" {
                // Go Results
                 resultsArrayToPass = reportDetailsArray?.filter({$0.userId == transObject.userId})

                self.performSegue(withIdentifier: "loopResults", sender: self)
            }else {
                // Go Detail
                self.transObjectToPass = transObject
                self.performSegue(withIdentifier: "goDetail", sender: self)
            }
        }
        
        
    }
    
   
    
    
    // Parser
    
    func createReport(object: TransactionObject) -> String {
        
        var returnString = ""
        
        returnString = returnString + object.userId
        returnString = returnString + " - Expenses: $\(object.totalExpense)"
        returnString = returnString + " - Saving: $\(object.totalSaving)"
        returnString = returnString + "\nCategories: \(object.category)"
        
        
        return returnString
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goDetail") {
            
            let destinationVC = segue.destination as! DetailViewController
            
            destinationVC.transactionObject = self.transObjectToPass
            
        }else if (segue.identifier == "loopResults") {
            
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.resultsArray = resultsArrayToPass
            
        }
    }
    

}
