//
//  NetworkManager.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import Foundation
import FirebaseRemoteConfigInternal

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchBooks(completion: @escaping (RemoteConfigData?) -> Void) {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 3600) { status, error in
            if status == .success, error == nil {
                RemoteConfig.remoteConfig().activate { _, _ in
                    if let jsonString = RemoteConfig.remoteConfig()["json_data"].stringValue,
                       let jsonData = jsonString.data(using: .utf8) {
                        let decoder = JSONDecoder()
                        do {
                            let data = try decoder.decode(RemoteConfigData.self, from: jsonData)
                            completion(data)
                        } catch {
                            print("Error decoding JSON: \(error)")
                            completion(nil)
                        }
                    }
                }
            } else {
                print("Error fetching remote config: \(String(describing: error))")
                completion(nil)
            }
        }
    }
}
