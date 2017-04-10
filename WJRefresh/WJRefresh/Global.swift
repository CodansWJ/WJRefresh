//
//  Global.swift
//  WJRefresh
//
//  Created by 汪俊 on 2017/3/6.
//  Copyright © 2017年 Codans. All rights reserved.
//

import Foundation
import UIKit

let WIDTH  = UIScreen.main.bounds.width                          // 屏幕宽
let HEIGHT = UIScreen.main.bounds.height                         // 屏幕高
let FRAME  = CGRect(x: 0, y: 64, width: WIDTH, height: HEIGHT)    // 屏幕frame
let HEAD_HEIGHT:CGFloat = 64.0                                   // 头部的高
		
//MARK: - GCD延时
func gDelay(time _time: TimeInterval, task: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+_time) {
        task()
    }
}
