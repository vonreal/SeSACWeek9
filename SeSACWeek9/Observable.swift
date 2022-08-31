//
//  Observable.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/31.
//

import Foundation

class Observable<T> { //양방향 바인딩
    var value: T {
        didSet {
            
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}

class User {
    var value: String
    
    init(name: String) {
        value = name
    }
}
