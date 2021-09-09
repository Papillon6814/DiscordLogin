//
//  Model.swift
//  DiscordLogin
//
//  Created by Papillon on 2021/09/09.
//

import Foundation
import Alamofire
import SwiftyJSON

class Model {
    
    private static let clientId = "885399115763183656"
    private static let clientSecret = "3vAOY4F6faifW4Ya0Y6YaLRHtuRS6Ryo"
    
    func retrieveTokens(code: String, completion: @escaping (Bool) -> Void) {
        let url = "https://discordapp.com/api/oauth2/token"
        
        let params: Parameters = [
            "client_id": Model.clientId,
            "client_secret": Model.clientSecret,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": "https://e-players-web.web.app/"
        ]
        
        AF.request(url, method: .post, parameters: params)
        .responseJSON { response in
            guard response.data != nil else {
                print("connection error")
                return
            }
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let accessToken = json["access_token"].string,
                      let refreshToken = json["refresh_token"].string else {
                    return
                }
                
                let auth = Auth()
                auth.accessToken = accessToken
                auth.code = code
                auth.refreshToken = refreshToken
                
                RealmHelper.shared.setAuth(auth: auth)
                
                completion(true)
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserInfo(completion: @escaping (String, String) -> Void) {
        guard let accessToken = RealmHelper.shared.getAccessToken() else {
            return
        }
        
        let url = "https://discordapp.com/api/users/@me"
        let headers: HTTPHeaders = [.authorization(bearerToken: accessToken)]
        
        AF.request(url, method: .get, headers: headers)
        .responseJSON { response in
            guard response.data != nil else {
                print("connection error")
                return
            }
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let username = json["username"].string,
                      let discriminator = json["discriminator"].string else {
                    return
                }
                
                completion(username, discriminator)
            case .failure(let error):
                print(error)
            }
        }
    }
}
