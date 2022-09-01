//
//  Observable.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/31.
//

import Foundation

class Observable<T> { //양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

class User {
    
    private var listener: ((String) -> Void)?
    
    var value: String {
        didSet {
            print("Changed Data")
            listener?(value)
        }
    }
    
    init(_ value: String) {
        self.value = value
    }
}
