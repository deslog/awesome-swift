//
//  MySingletonViewController.swift
//  DesignPattern
//
//  Created by LeeJiSoo on 2023/02/06.
//

import UIKit

class MySingletonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        1️⃣ 싱글턴 패턴을 사용하지 않았을 경우 메모리 번호 살펴보기
//        let firstObject = MySingleton()
//        // 디버깅: 메모리 0x600002531940 에 올라가있음
//        let secondObject = MySingleton()
//        //0x600002531950

//        2️⃣ 싱글턴 패턴을 이용해보자.
        let firstObject = MySingleton.shared // 0x600000c75c10
        let secondObject = MySingleton.shared // 0x600000c75c10
//        지금 같은 mysingleton을 바라보고있음. 두개의 객체는 결국 같다.
    }
}
