//
//  Database.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/26/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation
import SQLite

enum MerchantCaterogy: Int {
    case coffee = 1
    case fastFood = 2
    case dessert = 3
    case clothing = 4
    case grocery = 5
    case beauty = 6
}

struct Merchant {
    var name: String
    var category: MerchantCaterogy
    var hour: String
}

var allMerchants: [Merchant] = []

class DatabaseHelper {
    var db: Connection?

    let usersTable = Table("merchant_merchant")
    let merchantName = Expression<String>("merchantName")
    let merchantCategory = Expression<Int>("category")
    let merchantHour = Expression<String>("hours")

    init() {
        do {
            guard let sourcesURL = Bundle.main.url(forResource: "db", withExtension: "sqlite3") else {
                fatalError("Could not find file")
            }
            let database = try Connection(sourcesURL.path)
            self.db = database
        } catch {
            print(error)
        }
    }

    func read() {
        do {
            let users = try self.db!.prepare(self.usersTable)
            for user in users {
                let name = try user.get(self.merchantName)
                let hour = try user.get(self.merchantHour)
                let category = try user.get(self.merchantCategory)
                allMerchants.append(Merchant(name: name, category: MerchantCaterogy(rawValue: category)!, hour: hour))
            }
            print(allMerchants)
        } catch {
            print(error)
        }
    }

//    func createTable() {
//        let createTable = self.usersTable.create { (table) in
//            table.column(self.id, primaryKey: true)
//            table.column(self.address)
//        }
//
//        do {
//            try self.db!.run(createTable)
//            print("Created Table")
//        } catch {
//            print(error)
//        }
//    }
}
