//
//  QuoteAPIClient.swift
//  QuotesForYou
//
//  Created by Joyce Matos on 12/29/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import Foundation
import UIKit

class QuoteAPIClient {
    
    class func getQuotes(completion: @escaping ([String : String]) -> Void) {
        let urlString = QuoteAPI.baseURLString
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
                completion(responseJSON)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
