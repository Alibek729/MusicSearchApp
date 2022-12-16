//
//  NetworkService.swift
//  MusicAPP
//
//  Created by Alibek Kozhambekov on 01.12.2022.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                    return
                }
                guard let safeData = data else { return }
                completion(.success(safeData))
            }
        }.resume()
    }
    
}
