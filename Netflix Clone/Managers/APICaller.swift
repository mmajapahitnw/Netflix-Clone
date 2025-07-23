//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Majapahit Wisisono on 23/07/25.
//

import Foundation

struct Constants {
    static let API_KEY = "7e177aa2ea0287b9d6ad6d423bfc9053"
    static let READ_ACCESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZTE3N2FhMmVhMDI4N2I5ZDZhZDZkNDIzYmZjOTA1MyIsIm5iZiI6MTc1MzIyNTcwNS4yMTI5OTk4LCJzdWIiOiI2ODgwMTllOTJkOTA1NTI1NmRkOTk4MDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.TLQwSYIW9fkBmYdfrRRaeyygUq1z0jTBH-Z2Gnke70g"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {

        let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(Constants.READ_ACCESS_TOKEN)"
        ]


        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("error getting data")
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(results)
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
        //        do {
        //            let (data, _) = try await URLSession.shared.data(for: request)
        //            print(String(decoding: data, as: UTF8.self))
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        
    }
}
