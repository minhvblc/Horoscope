//
//  database.swift
//  Horoscopes
//
//  Created by Nguyễn Minh on 09/02/2021.
//

import UIKit
import Foundation
import SQLite3
func openDatabase(_ random : Int) -> String {
    let fileURL = Bundle.main.path(forResource: "LifePalmistry-1", ofType: "db")
    print(fileURL)
    // open database
    var result = String()
    var db: OpaquePointer?
    guard sqlite3_open(fileURL, &db) == SQLITE_OK else {
       
        print("error opening database")
        sqlite3_close(db)
        db = nil
        result = ""
        return result
    }
    var queryStatement: OpaquePointer?
    // 1
    let queryStatementString = "SELECT * FROM 'Face' WHERE ID = \(random);"
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
        SQLITE_OK {
        // 2
        if sqlite3_step(queryStatement) == SQLITE_ROW {
            // 3
          
            // 4
            guard let queryResultCol1 = sqlite3_column_text(queryStatement, 5) else {
                print("Query result is nil")
                result = ""
                return result
            }
            result = String(cString: queryResultCol1)
            // 5
            print("\nQuery Result:")
            print("\(result)")
          
        } else {
            print("\nQuery returned no results.")
            result = ""
            return result
        }
    } else {
        // 6
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("\nQuery is not prepared \(errorMessage)")
    }
    // 7
    sqlite3_finalize(queryStatement)
    return result
}



