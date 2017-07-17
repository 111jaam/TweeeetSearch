//
//  TSNetManagerTweets.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import Foundation
import TweetKit

class TSNetManagerTweets{
    
    static let sharedInstance = TSNetManagerTweets()
    var delegate: TSProtocolManagerTweets?
    
    var tweets:Any?
    
    func createRequest(withSearchString strSearch: String, strLocation: String, strTime: String)
    {
        var arrayViewModel: [TSViewModelTweet] = []
        
        TweetKit.getTweets(withSearchTerm: strSearch, location: strLocation, recent: strTime) { (tweets) in
            
            self.tweets = tweets
            
//            if let dataDict = tweets as? [String:Any],
//                let statuses = dataDict["statuses"] as? [[String:Any]] {
//                print(statuses)
//            }
            
            do {
                let json = try JSON(data: self.tweets as! Data)
//                if let userName = json["statuses"][2]["entities"].rawString() {
//                    //Now you got your value
//                    
//                }
                
                
                for arrayType in json["statuses"] {
                    let jsonDictFromArray = arrayType as (String, JSON)
                    let modelParsed = TSModelTweet(jsonDictFromArray)
                    
                    if (modelParsed.urlMedia != nil) {
                        let viewModel = TSViewModelTweet(modelParsed)
                        arrayViewModel.append(viewModel)
                    }
                }
            }
            catch _ {
                // Error handling
            }
            
            self.delegate?.sendData(arrayOfViewModel: arrayViewModel)
       }
    }
}

protocol TSProtocolManagerTweets
{
    func sendData(arrayOfViewModel: Array<TSViewModelTweet>)
}
