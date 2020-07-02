//
//  EndPoint.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 6/30/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation

/*
 reference for connecting endpoints
 site = http://localhost:8000

 # for user dashboard
 userDetail = /users/customer/<userID>
 userImpact = /orders/userImpact/<userID>
 transactionHistory = /orders/giftRelatedTo/<userID>/

 # for main page
 Favorites = /programs/enrollment/getFavoriteStore/<userId>

 # merchant by category
 merchantlist = /merchants/getMerchantByCategory/<distance>/<categoryCode>/<zipcode>/

 # leaderboard
 leaderBoard = /orders/getLeaderboard/<merchantID>

 # merchant detail
 merchantInfo = /merchants/<merchantID>/
 merchantGiftPurchased = /orders/giftForMerchant/<merchantID>/

 # loyalty program list page
 programList = /programs/enrollment/getActiveProgramsByUser/<userId>/

 # loyalty program detail page
 programDetail = /programs/enrollment/getProgramByUserAndMerchant/<userId>/<merchantID>/
 
 {'merchantID_id__merchantID': '16775022',
 'programID_id__description': 'send 5 gifts for one cup of cappuccino',
 'programID_id__programName': 'The Gift Sender',
 'merchantID_id__merchantName': 'DREAMY ANGELS',
 'merchantID_id__profilePic': 'default_merchant.png'}

 # friends
 friends = /users/friendship/getFriends/<userID>/
 
 28937146
 http://localhost:8000/orders/getLeaderboard/28937146
 http://localhost:8000/users/friendship/getFriends/1/
*/

let merchantURL = "http://localhost:8000/merchants/"
let userURL = "http://localhost:8000/users/customer"

var friendshipString: String = ""
var friendDictionaries: [[String: Any]?] = [] // keys: friendB_id__user__username, friendB_id__profilePic, friendB_id__id

var loyaltyProgramString: String = ""
var loyaltyProgramDictionaries: [[String: Any]?] = [] // keys: friendB_id__user__username, friendB_id__profilePic, friendB_id__id

var leadershipBoardString: String = ""
var leadershipBoardDictionaries: [String:[[String: Any]?]] = [:] //keys: senderID_id__user__username, senderID_id__profilePic, totalNumberSent

//var programDetailString: String = ""
//var programDetailDictionaries: [String:[[String: Any]?]] = [:] //keys: senderID_id__user__username, senderID_id__profilePic,

class EndPoint {
    func readFriendShip() {
        let url = URL(string: "http://localhost:8000/users/friendship/getFriends/1/")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                friendshipString = dataString
                let jsonStrs = divideJsonString(str: friendshipString)
                for s in jsonStrs {
                    print("old string")
                    print(s)
                    friendDictionaries.append(convertToDictionary(text: s))
                }
            }
            
        }
        task.resume()
    }
    
    func readLeadershipBoard(merchantID: String) {
        let url = URL(string: "http://localhost:8000/orders/getLeaderboard/" + merchantID)
//        print(url)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                leadershipBoardString = dataString
                let jsonStrs = divideJsonString(str: leadershipBoardString)
                var dict:[[String: Any]?] = []
                for s in jsonStrs {
                    dict.append(convertToDictionary(text: s))
                }
                leadershipBoardDictionaries[merchantID] = dict
            }
            
        }
        task.resume()
    }
    
    func readProgram() {
        let url = URL(string: "http://localhost:8000/programs/enrollment/getFavoriteStore/1")
        //        print(url)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                loyaltyProgramString = dataString
                let jsonStrs = divideJsonString(str: loyaltyProgramString)
                for s in jsonStrs {
                    loyaltyProgramDictionaries.append(convertToDictionary(text: s))
                    print(convertToDictionary(text: s))
                
                }
            }
            
        }
        task.resume()
    }
    
//    func readProgramDetail(merchantID: String) {
//        let url = URL(string: "http://localhost:8000/programs/enrollment/getProgramByUserAndMerchant/1/" + merchantID)
////        print(url)
//        guard let requestUrl = url else { fatalError() }
//        // Create URL Request
//        var request = URLRequest(url: requestUrl)
//        // Specify HTTP Method to use
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        // Send HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Check if Error took place
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            // Convert HTTP Response Data to a simple String
//            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                programDetailString = dataString
//                print("program string")
//                let jsonStrs = divideJsonString(str: programDetailString)
//                var dict:[[String: Any]?] = []
//                for s in jsonStrs {
//                    print(s)
//                    print(convertToDictionary(text: s))
//                    dict.append(convertToDictionary(text: s))
//                }
//                leadershipBoardDictionaries[merchantID] = dict
//            }
//            
//        }
//        task.resume()
//    }
    
}


func divideJsonString(str: String) -> [String] {
    let temp = str.split(separator: "}")
    var temp2: [String] = []
    for x in temp {
        temp2.append(x + "}")
    }
    var result: [String] = []
    for x in temp2 {
        result.append(x.replacingOccurrences(of: "'", with: "\""))
    }
    return result
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

