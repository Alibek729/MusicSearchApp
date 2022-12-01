//
//  NetworkService.swift
//  MusicAPP
//
//  Created by Alibek Kozhambekov on 01.12.2022.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print("Error: \(error.localizedDescription)")
                    //completion(nil, error)
                    completion(.failure(error))
                    return
                }
                guard let safeData = data else { return }
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: safeData)
                    //completion(tracks, nil)
                    completion(.success(tracks))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    //completion(nil, jsonError)
                    completion(.failure(jsonError))
                }
                
//                let someString = String(data: safeData, encoding: .utf8)
//                print(someString ?? "no data")
            }
        }.resume()
    }
    
}
