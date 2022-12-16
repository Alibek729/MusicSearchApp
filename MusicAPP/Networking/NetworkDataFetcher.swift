//
//  File.swift
//  MusicAPP
//
//  Created by Alibek Kozhambekov on 02.12.2022.
//

import Foundation

class NetworkDataFetcher {
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, response: @escaping (SearchResponse?) -> Void){
        networkService.request(urlString: urlString) { result in
            switch result {
                
            case .success(let safeData):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: safeData)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error receiving requested data", error.localizedDescription)
                response(nil)
            }
        }
    }
}
