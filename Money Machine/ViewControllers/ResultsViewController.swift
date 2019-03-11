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
    public var reportType = ""

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
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell\(indexPath.row)")
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            
            
            if let transObject = resultsArray?[indexPath.row] {
                
                let date = dateFormatterPrint.string(from: transObject.transactionDate)
                
                var resultsText = ""
                
                if reportType == "day" {
                    resultsText = "\(date)"
                    resultsText = "\(resultsText) | \(self.createReport(object: transObject))"
                }else if reportType == "week" {
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisWeekStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisWeekEnd()!)
                    resultsText = "\(startDate) - \(endDate)"
                    resultsText = "\(resultsText) | \(self.createReport(object: transObject))"
                }else if reportType == "month" {
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisMonthStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisMonthEnd()!)
                    resultsText = "\(startDate) - \(endDate)"
                    resultsText = "\(resultsText) | \(self.createReport(object: transObject))"
                }else if reportType == "year" {
                    let startDate = dateFormatterPrint.string(from: DataManager.getThisYearStart()!)
                    let endDate = dateFormatterPrint.string(from: DataManager.getThisYearEnd()!)
                    resultsText = "\(startDate) - \(endDate)"
                    resultsText = "\(resultsText) | \(self.createReport(object: transObject))"
                }else {
                    resultsText = "\(transObject.userId) - \(date) - $\(transObject.transactionAmount) - \(transObject.type) - \(transObject.category)"
                    
                    if transObject.transactionDescription.count > 0 {
                        resultsText = resultsText + " - \(transObject.transactionDescription)"
                    }
                }
                
                
                
                cell?.textLabel?.numberOfLines = 0
                cell?.textLabel?.lineBreakMode = .byWordWrapping
                cell?.textLabel?.text = resultsText
                
                cell?.selectionStyle = .none
            }
            
           
           
        }
        
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    // Parser
    
    func createReport(object: TransactionObject) -> String {
        
        var returnString = ""
        
        
        
        return returnString
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
