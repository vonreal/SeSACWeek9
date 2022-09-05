import UIKit

class Guild {
    var name: String
    weak var owner: User? // 이 길드장은 누구?
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

class User {
    var name: String
    var guild: Guild? // 고래밥이 새싹 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User(name: "고래밥") // User: RC 1
var guild: Guild? = Guild(name: "딸기잼") // Guild: RC 1 인스턴스 생성

// 순환참조 중인 요소를 먼저 nil. 인스턴스의 참조 관계 먼저 해제
// 아래 2줄 추가로 Deinit이 출력되지 않음 -> 왜? 인스턴스에 남아있음 -> 왜? '순환참조'
user?.guild = guild // Guild: RC 2
guild?.owner = user // User: RC 2

user = nil
//guild = nil

guild?.owner
//user?.guild

// << 순환참조 발생 >>
//user?.guild = guild // Guild: RC 2
//guild?.owner = user // User: RC 2

//// 아래 2줄은 1줄만 입력해도 Deinit이 출력됨, 대신 어떤 코드를 활성화하냐에 따라 출력 순서가 달라짐
//// Deinit이 되는 이유는 guild 내에 생성된 User인스턴스를 해제하면서 User가 완전히 제거 되고 Guild의 owner(User 인스턴스)가 가르킬 곳이 없기 때문에 제거된다.
//guild?.owner = nil // Gulid: RC 1
//// user?.guild = nil // User: RC 1
//
//guild = nil // Guild: RC 0 인스턴스 해제
//user = nil // User: RC 0
//// ViewDidLoad
