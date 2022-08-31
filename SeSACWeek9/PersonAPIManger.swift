//
//  LottoAPIManger.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/30.
//

import Foundation

// shared - 단순한, 커스텀x, 응답 클로저, 백그라운드 x
// default configuration - shared 설정 유사, 커스텀o, 응답 클로저 + 딜리게이트

class PersonAPIManger {
    static func requestLotto(query: String, completion: @escaping (Person?, APIError?) -> Void) {
//        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=5d30a263c2ce99f0a519e8a598c4d176&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "3a29eaefa78ea14af55d80b7db79e71a"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    print(result)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }

            }
        }.resume()
    }

}
