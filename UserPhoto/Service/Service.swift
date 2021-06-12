//
//  Service.swift
//  UserPhoto
//
//  Created by Egor Markov on 6/11/21.
//

import UIKit
import Foundation


class NetWorkService {
    
    static let shared = NetWorkService()
    
    
    func fetchApiUser(completion: @escaping([User]?, Error?) -> Void) {
        let urlApiString = "https://jsonplaceholder.typicode.com/users"
        fetchGenericJSON(urlString: urlApiString, completion: completion)
    }
    
    func fetchApiUserAlbum(idUser: Int , completion: @escaping([AlbumUser]?, Error?) -> Void) {
        let urlApiString = "https://jsonplaceholder.typicode.com/albums/\(idUser)/photos"
        fetchGenericJSON(urlString: urlApiString, completion: completion)
    }
    
  
    func fetchGenericJSON<T: Codable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                completion(nil,error)
                
                return
            }
         
            guard let dataInfo = data else {return}
            
            do {
                let result = try JSONDecoder().decode(T.self, from: dataInfo)
                
                completion(result, nil)
                
            }catch let errorJson {
                completion(nil, errorJson)
            }
            
        }.resume()
    }
    
}
