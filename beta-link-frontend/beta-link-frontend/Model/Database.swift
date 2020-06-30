//
//  Database.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/26/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation
import SQLite

var allMerchants: [Merchant] = []

func classifyMerchant(cat: String) -> MerchantCaterogy {
    if (cat.contains("restaurant")) {
        return .food
    } else if (cat.contains("cloth")) {
        return .clothing
    } else if (cat.contains("grocery")) {
        return .grocery
    } else if (cat.contains("beauty")) {
        return .beauty
    } else if (cat.contains("sport")) {
        return .sport
    } else {
        return .other
    }
}

class DatabaseHelper {
    var db: Connection?

    let usersTable = Table("merchant_merchant")
    
    let merchantName = Expression<String>("merchantName")
    let merchantCategory = Expression<String>("category")
    let merchantID = Expression<String>("merchantID")
    let merchantCity = Expression<String>("city")
    let merchantLongitude = Expression<String>("longitude")
    let merchantLatitude = Expression<String>("latitude")
    let merchantState = Expression<String>("state")
    let merchantAddress = Expression<String>("streetAddress")

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
                let name = try user.get(self.merchantName).lowercased()
                let category = try user.get(self.merchantCategory).lowercased()
                let id = try user.get(self.merchantID)
                let city = try user.get(self.merchantCity).lowercased()
                let state = try user.get(self.merchantState)
                let lonTemp = try user.get(self.merchantLongitude)
                let latTemp = try user.get(self.merchantLatitude)
                let addr = try user.get(self.merchantAddress).lowercased()
                let lonx = try Double(lonTemp) ?? -122.2763649
                let latx = try Double(latTemp) ?? 37.5592521
                
                allMerchants.append(Merchant(name: name, category: classifyMerchant(cat: category), id: id, lon: lonx, lat: latx, state: state, address: addr, city: city))
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
