//
//  GCDViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {

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
}
