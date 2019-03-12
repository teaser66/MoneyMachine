//
//  Money_MachineTests.swift
//  Money MachineTests
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import XCTest
@testable import Money_Machine

class Money_MachineTests: XCTestCase {
    
    var transactionObject: TransactionObject!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
   
        // Create an object:
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: "2019-03-11") // replace Date String
        
        transactionObject = TransactionObject(userId: "test_user", transactionDate: date!, transactionDescription: "Test Case 1", transactionAmount: 1.23, category: "Health", type: "Expense")
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        transactionObject = nil
    }

    func testTransactionObjectIsCreated() {
        
        // 1. given
        let targetUserId = "test_user"
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: "2019-03-11") // replace Date String
        
        let targetDate = date
        let targetDescription = "Test Case 1"
        let targetAmount = 1.23
        let targetCategory = "Health"
        let targetType = "Expense"
        
        // 2. when
        let  actualUserId = transactionObject.userId
        let  actualDate = transactionObject.transactionDate
        let  actualDescription = transactionObject.transactionDescription
        let  actualAmount = transactionObject.transactionAmount
        let  actualCategory = transactionObject.category
        let  actualType = transactionObject.type
        
        // 3. then
        XCTAssertEqual(actualUserId, targetUserId, "User Id is not \"test_user\"")
        XCTAssertEqual(actualDate, targetDate, "Date is not \"2019-03-11\"")
        XCTAssertEqual(actualDescription, targetDescription, "Description is not \"Test Case 1\"")
        XCTAssertEqual(actualAmount, Decimal(targetAmount), "Amount is not 1.23")
        XCTAssertEqual(actualCategory, targetCategory, "Category is not \"Health\"")
        XCTAssertEqual(actualType, targetType, "Type is not \"Expense\"")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
