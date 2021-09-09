//
//  URL+Ext.swift
//  DiscordLogin
//
//  Created by Papillon on 2021/09/09.
//

import Foundation

extension URL {
    
    func queryValue(for key: String) -> String? {
        let queryItems = URLComponents(string: absoluteString)?.queryItems
        return queryItems?.filter { $0.name == key }.compactMap { $0.value }.first
    }
}
