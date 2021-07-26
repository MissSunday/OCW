//
//  swiftClass.swift
//  OCW
//
//  Created by 朵朵 on 2021/7/23.
//

import Foundation

class test1: NSObject {
    
   @objc func show() {
    print("swift类 %@",NSStringFromClass(self.classForCoder))
    }
    
    
}
