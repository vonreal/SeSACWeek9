//
//  Sample.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> ()) {
        completionHandler(value)
        listener = completionHandler
    }
}
