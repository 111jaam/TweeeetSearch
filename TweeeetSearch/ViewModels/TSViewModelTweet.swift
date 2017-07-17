//
//  TSViewModelTweet.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import Foundation

class TSViewModelTweet {
    var title: String?
    var webLink: String?
    var memberType: String?
    
    init(_ model: TSModelTweet){
        if let modelResult = model.text {
            title = "\(modelResult)"
            webLink = model.urlMedia
            memberType = " "            
        }
    }
}
