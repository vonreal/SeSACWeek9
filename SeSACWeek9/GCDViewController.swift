//
//  GCDViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {

    
    @IBOutlet var imageList: [UIImageView]!
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // main thread에서 queue에 있는 작업이 모두 끝날때까지 기다렸다가 다음 작업 수행..
    @IBAction func serialSync(_ sender: UIButton) { // 사용할 일이 없딈
        print("Start", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
//        DispatchQueue.main.sync { // deadlock(교착상태) 자기 자신한테 기다리라고 하고 작업 대기중. (무한 대기)
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("end")
    }
    
    // main thread에 queue에 작업을 보내고 자신은 다음 작업을 수행
    @IBAction func serialAsync(_ sender: UIButton) {
        print("Start", terminator: " ")
        
//        DispatchQueue.main.async { // 하나의 task 전달
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 { // 100개의 task 전달( 출력은 위 주석과 동일하게 됨 )
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("end")
    }
    
    // global = 작업은 여러 thread에 분배함 하지만 sync = 작업이 끝나고 다음 작업을 수행함.
    @IBAction func globalSync(_ sender: UIButton) {
        print("Start", terminator: " ")
        
        DispatchQueue.global().sync { // 따라서 순서대로 실행됨 (mainthread에서 하는 것과 동일해서 내부적으로는 mainthread에 다 넣어버림 == 의미 없다!)
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("end")
    }
    
    // global = 작업을 여러 thread에
    @IBAction func globalAsync(_ sender: UIButton) {
        print("Start \(Thread.isMainThread)", terminator: " ")
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("end \(Thread.isMainThread)")
    }
    
    // qos의 우선순위에 따라 userInteractive > utility > background 실행
    @IBAction func qos(_ sender: UIButton) {
        
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        
        customQueue.async {
            print("start")
        }
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
            
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝") // tableView.reload
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }

            let image = UIImage(data: data)
            completionHandler(image)
                                  
        }.resume()
    }
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
//        request(url: url1) { image in
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                    print("end. 갱신")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
               print("1")
            }
        }
            
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
               print("2")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
               print("3")
            }
        }
        
        group.notify(queue: .main) {
            print("끝") // tableView.reload
        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()
        
        var imgList: [UIImage] = []
        
        group.enter() // enter 시 RC + 1 증가
        request(url: url1) { image in
            imgList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            imgList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imgList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            for i in 0..<imgList.count {
                self.imageList[i].image = imgList[i]
            }
        }
        
    }
    
    
    @IBAction func raceCondition(_ sender: UIButton) {
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)") 
        }
    }
    
}


/*
 리뷰남기기 -> 리뷰 얼럿: 1년에 한 디바이스 당 3회 제한 -> 정확히 찾아보기
 keyword: SKStoreReviewController
 */
