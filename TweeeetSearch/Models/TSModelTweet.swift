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
    var urlMedia: String?
    
    init(_ parameters: (String, JSON)) {
        
        if let url = parameters.1["entities"]["media"][0]["media_url_https"].rawString() {
            if url.length > 7 {
                urlMedia = url
            }
        }
                
        if let textTitle = parameters.1["text"].rawString() {
            text = textTitle
        }
    }
}
