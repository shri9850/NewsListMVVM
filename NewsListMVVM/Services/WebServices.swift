//
//  WebServices.swift
//  NewsListMVVM
//
//  Created by shree on 10/01/22.
//

import Foundation
class WebServices {
    static func getAllNews(completion: @escaping([News]?)->()){
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=51d8f9dad8f74ff7829e090593b329bf") else { completion(nil)
            return }
        URLSession.shared.dataTask(with: url) { (data, responses, error) in
            guard let safeData = data, error == nil else{ completion(nil)
                return
            }
            let decodedData = try? JSONDecoder().decode(NewsModel.self, from: safeData)
            if let safeData = decodedData?.articles{
                completion(safeData)
            }else{
                completion(nil)
            }
        }.resume()
        
    }
    
    func loadAllNews<T>(resources: Resources<T>, completion: @escaping(Result<T, NetWorkError>)-> ()){
        var request = URLRequest(url: resources.url)
        request.httpMethod = resources.method.rawValue
        request.httpBody = resources.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, responses, error) in
            guard let safeData = data, error == nil else{ completion(.failure(.domainError))
                return
            }
            let data = try? JSONDecoder().decode(T.self, from: safeData)
            if let safeData = data{
                completion(.success(safeData))
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}

enum NetWorkError: Error{
    case domainError
    case NetWorkError
    case UrlError
    case decodingError
}

struct Resources<T: Codable> {
    let url: URL
    let method: HttpMethod = .get
    let body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}
