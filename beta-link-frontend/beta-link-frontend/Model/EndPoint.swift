//
//  EndPoint.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 6/30/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation


class EndPoint {
    func read() {
        let starbuckURL = "http://localhost:8000/merchants/29992901/"
        let url = URL(string: starbuckURL)
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
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                let allHeaderFields:[AnyHashable : Any] = response.allHeaderFields
                print("All headers: \(allHeaderFields)")
//                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()
    }
}


