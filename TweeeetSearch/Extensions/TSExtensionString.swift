//
//  TSExtensionString.swift
//  TweeeetSearch
//
//  Created by Bharat Byan on 16/07/17.
//  Copyright © 2017 Bharat Byan. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    func sliceUpto(to: String) -> String? {
        
        var firstPart = ""
        if let range = self.range(of: to) {
            firstPart = self[self.startIndex..<range.lowerBound]
        }
        return firstPart
    }
    
    mutating func beforeOccurenceString(_ string: String) {
        var components = self.components(separatedBy: string)
        self = components[0]
    }
    
    var byWords: [String] {
        var result:[String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            guard let word = $0 else { return }
            _ = $1
            _ = $2
            _ = $3
            //            print($1,$2,$3)
            result.append(word)
        }
        return result
    }
    
    var lastWord: String {
        return byWords.last ?? ""
    }
    
    func lastWords(_ max: Int) -> [String] {
        return Array(byWords.suffix(max))
    }
}
