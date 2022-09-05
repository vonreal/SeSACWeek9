import UIKit

class Guild {
    init() {
        print("Guild Init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

class User {
    var name: String
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User(name: "고래밥")

var guild: Guild? = Guild() // Guild: RC 1 인스턴스 생성

guild = nil // Guild: RC 0 인스턴스 해제

// ViewDidLoad
