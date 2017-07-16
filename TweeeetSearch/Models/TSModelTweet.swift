//
//  TSModelTweet.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import Foundation

struct TSModelTweet {
    
    var text: String?
    
    init(_ parameters: NSDictionary) {
        text = parameters.value(forKey: "text") as? String
    }
}
