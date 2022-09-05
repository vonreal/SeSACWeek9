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

func myClosure() {
    var number = 0
    print("1: \(number)")
    
    let closure: () -> Void = { [number] in // 값을 캡쳐! -> 독립적으로 사용 가능 (해당 인자를 작성하지 않으면 40번 줄에서 값이 변화됨)
        print("closure: \(number)")
    }
    
    closure()
    
    number = 100
    print("2: \(number)")
    
    closure()
}

myClosure()

//: [Next](@next)
