//
//  LottoAPIManger.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/30.
//

import Foundation

// shared - 단순한, 커스텀x, 응답 클로저, 백그라운드 x
// default configuration - shared 설정 유사, 커스텀o, 응답 클로저 + 딜리게이트

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManger {
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
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
