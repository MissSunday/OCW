//
//  swiftClass.swift
//  OCW
//
//  Created by 朵朵 on 2021/7/23.
//

import Foundation
import UIKit
class test1: NSObject {
    
   @objc func show() -> UIImage {
    print("swift类 %@",NSStringFromClass(self.classForCoder))
    return UIImage(named: "directory")!.reImage(color: UIColor.red, size: 200)
    }
}
