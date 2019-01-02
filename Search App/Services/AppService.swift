//
//  AppService.swift
//  Search App
//
//  Created by SE on 10/3/18.
//  Copyright © 2018 IT15049582_IT15060822. All rights reserved.
//

import Foundation
class AppService {
    
    let processingQueue = OperationQueue()
    
    func searchStoreForTerm(_ searchTerm: String, completion : @escaping (_ results: Any?, _ error : NSError?) -> Void){
        
        guard let searchURL = storeSearchURLForSearchTerm(searchTerm) else {
            let APIError = NSError(domain: "StoreSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        let task = URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            
            guard error == nil else {
                print(error!)
                OperationQueue.main.addOperation({
                    completion(nil, error! as NSError)
                })
                return
            }
    
            
            do {
                if(data != nil) {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                  //                print(json)
                
                  OperationQueue.main.addOperation({
                    completion(json, nil)
                   })
                }
            } catch {
                print("JSON Error")
            }
            
            print("Netwok response")
        }
        
        task.resume()
    }
    func storeSearchURLForSearchTerm(_ searchTerm:String) -> URL? {
        
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        let URLString = "https://itunes.apple.com/search?term=\(escapedTerm)&limit=200&entity=software"
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
    
}


