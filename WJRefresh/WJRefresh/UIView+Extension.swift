//
//  UIView+Extension.swift
//  RuntimeText
//
//  Created by 汪俊 on 2017/3/3.
//  Copyright © 2017年 Codans. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    var wj_x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            let xframe = CGRect(x: newValue, y: self.frame.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
            self.frame = xframe
            print(self.frame)
        }
    }
    
    var wj_y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            let yFrame = CGRect(x: self.frame.origin.x, y: newValue, width: self.bounds.size.width, height: self.bounds.size.height)
            self.frame = yFrame
        }
    }
    
    var wj_Width: CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            let wFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newValue, height: self.bounds.size.height)
            self.frame = wFrame
        }
    }
    
    var wj_Height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            let hFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.size.width, height: newValue)
            self.frame = hFrame
        }
    }
    
}

/*
 *
 * 动画
 *
 */
extension UIView {
    // MARK: - 旋转动画
    func rotate(angle:Double, time:CGFloat, delegate: Any) {
        var transform = CGAffineTransform()
        transform = self.transform.rotated(by: CGFloat(-Double.pi/2))
        UIView.beginAnimations("rotate", context: nil)
        UIView.setAnimationDuration(TimeInterval(time))
        UIView.setAnimationDelegate(delegate)
        self.transform = transform
        UIView.commitAnimations()
    }
    
    
}
