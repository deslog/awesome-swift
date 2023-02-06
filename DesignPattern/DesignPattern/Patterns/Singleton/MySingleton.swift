//
//  MySingleton.swift
//  DesignPattern
//
//  Created by LeeJiSoo on 2023/02/06.
//

import Foundation

final class MySingleton: NSObject {

    static let shared = MySingleton()

    private override init() { }
}
