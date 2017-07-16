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
    
    var tweets:[[String:Any]]?
    
    func createRequest(withSearchString strSearch: String)
    {
        var arrayViewModel: [TSViewModelTweet] = []
        
        TweetKit.getTweets(withSearchTerm: strSearch) { (tweets) in
            self.tweets = tweets
            
            for arrayType in self.tweets! {
                let dictFromArray = arrayType as NSDictionary
                let modelParsed = TSModelTweet(dictFromArray)
                let viewModel = TSViewModelTweet(modelParsed)
                
                arrayViewModel.append(viewModel)
            }
            
            self.delegate?.sendData(arrayOfViewModel: arrayViewModel)
       }
    }
}

protocol TSProtocolManagerTweets
{
    func sendData(arrayOfViewModel: Array<TSViewModelTweet>)
}
