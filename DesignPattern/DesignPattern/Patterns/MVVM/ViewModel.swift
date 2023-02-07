//
//  ViewModel.swift
//  DesignPattern
//
//  Created by LeeJiSoo on 2023/02/07.
//

import Foundation
import Combine

class ViewModel: ObservableObject {

    enum AddingType {
        case add, reset
    }

    // MARK: - property

    @Published var tempArr = [String]()
    var dataUpdateAction = PassthroughSubject<AddingType, Never>()
    var arrCnt = 0

    // MARK: - life cycle

    init() { }

    // MARK: - func

    @objc func addData(_ sender: Any) {
        arrCnt += 1
        tempArr.append("\(arrCnt)번째 데이터 추가")
        dataUpdateAction.send(.add)
    }

    @objc func resetData(_ sender: Any) {
        arrCnt = 0
        tempArr = []
        dataUpdateAction.send(.reset)
    }
}
