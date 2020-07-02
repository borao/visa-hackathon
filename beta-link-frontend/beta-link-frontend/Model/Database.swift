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
var allUsers: [User] = []
var allFriends: [Friend] = []
var allOrders: [String] = []
var loggedInUser: User?

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

    let merchantTable = Table("merchant_merchant")
    let merchantName = Expression<String>("merchantName")
    let merchantCategory = Expression<String>("category")
    let merchantID = Expression<String>("merchantID")
    let merchantCity = Expression<String>("city")
    let merchantLongitude = Expression<String>("longitude")
    let merchantLatitude = Expression<String>("latitude")
    let merchantState = Expression<String>("state")
    let merchantAddress = Expression<String>("streetAddress")
    let merchantPicturePath = Expression<String>("profilePic")
    
    let userTable = Table("users_customer")
    let userID = Expression<Int>("id")
    let userStreet = Expression<String>("street")
    let userCity = Expression<String>("city")
    let userState = Expression<String>("state")
    let userZipcode = Expression<String>("zipcode")
    let userLongitude = Expression<String>("longitude")
    let userLatitude = Expression<String>("latitude")
    let userPhoneNumber = Expression<Int>("phone_number")
    let userPicturePath = Expression<String>("profilePic")
    
    let orderTable = Table("order_order")
    let orderID = Expression<String>("merchantID_id")

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

    func readMerchants() {
        do {
            let merchants = try self.db!.prepare(self.merchantTable)
            for merchant in merchants {
                let name = try merchant.get(self.merchantName).uppercased()
                let category = try merchant.get(self.merchantCategory).lowercased()
                let id = try merchant.get(self.merchantID)
                let city = try merchant.get(self.merchantCity).uppercased()
                let state = try merchant.get(self.merchantState)
                let lonTemp = try merchant.get(self.merchantLongitude)
                let latTemp = try merchant.get(self.merchantLatitude)
                let addr = try merchant.get(self.merchantAddress).lowercased()
                var picture = try merchant.get(self.merchantPicturePath)
                if picture == "default_merchant.png" {
                    picture = "media/default_merchant.png"
                }
                let lonx = try Double(lonTemp) ?? -122.2763649
                let latx = try Double(latTemp) ?? 37.5592521
                
                allMerchants.append(Merchant(name: name, category: classifyMerchant(cat: category), id: id, lon: lonx, lat: latx, state: state, address: addr, city: city, picturePath: picture))
            }
        } catch {
            print(error)
        }
    }
    
    func readUsers() {
        do {
            let users = try self.db!.prepare(self.userTable)
            for user in users {
                let id = try user.get(self.userID)
                let street = try user.get(self.userStreet)
                let city = try user.get(self.userCity)
                let state = try user.get(self.userState)
                let zipcode = try user.get(self.userZipcode)
                let lonTemp = try user.get(self.userLongitude)
                let latTemp = try user.get(self.userLatitude)
                let phone = try user.get(self.userPhoneNumber)
                let picture = try user.get(self.userPicturePath)
                let lonx = try Double(lonTemp) ?? -122.2763649
                let latx = try Double(latTemp) ?? 37.5592521
                
                allUsers.append(User(userID: id, street: street, city: city, state: state, zipcode: zipcode, longitude: lonx, latitude: latx, phoneNumber: phone, profilePicture: picture))
            }
        } catch {
            print(error)
        }
    }
    
    func readOrders() {
        do {
            let orders = try self.db!.prepare(self.orderTable)
            for order in orders {
                let id = try order.get(self.orderID)
                allOrders.append(id)
            }
        } catch {
            print(error)
        }
    }
}

//
//class JsonHelper {
//    func readLocalFile(forName name: String) -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name,
//                                                 ofType: "json"),
//                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
//    }
//
//    func parse(jsonData: Data) {
//        do {
//            let decodedData = try JSONDecoder().decode(userJson.self,
//                                                       from: jsonData)
//            allUsers.append(userJson(user: decodedData.user, street: decodedData.street, city: decodedData.city, state: decodedData.state, zipcode: decodedData.zipcode, longitude: decodedData.longitude, latitude: decodedData.latitude, phoneNumber: decodedData.phoneNumber, profilePicture: decodedData.profilePicture))
//        } catch {
//            print("decode error")
//        }
//    }
//}
