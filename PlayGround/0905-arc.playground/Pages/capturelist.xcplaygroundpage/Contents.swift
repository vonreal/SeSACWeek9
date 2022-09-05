//: [Previous](@previous)

import Foundation

class User {
    var nickName = "JIUN"
    
    lazy var introduce = { [weak self] in           // [weak self]를 제거하면 deinit이 출력되지 않는다. (캡쳐리스트)
        return "저는 \(self?.nickName ?? "손님")입니다."
    }
    
    init() {
        print("User init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User()

user?.introduce

user = nil

//: [Next](@next)
