//
//  PlistManager.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

public enum PlistManagerError: Error {
    case fileDoesNotExist
    case fileUnavailable
}

class PlistManager {
       
    public static let shared = PlistManager()
    //This prevents others from using the default '()' initializer for this class.
    private init() {}
    
    public func getDictionaryFrom(_ name:String, completion:(_ result : NSDictionary?, _ error :PlistManagerError?) -> ()) {
        
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            completion (nil,.fileDoesNotExist)
            return }
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            guard let dictionary = NSDictionary(contentsOfFile: path) else {
                completion(nil,.fileUnavailable)
                return }
            completion(dictionary,nil)
        } else {
            completion(nil,.fileDoesNotExist)
        }
    }
    
    
}
