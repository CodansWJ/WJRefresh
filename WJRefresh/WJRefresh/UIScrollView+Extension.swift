//
//  UIScrollView+Extension.swift
//  WJRefresh
//
//  Created by 汪俊 on 2017/3/7.
//  Copyright © 2017年 Codans. All rights reserved.
//

import UIKit

extension UIScrollView {
    var wj_inset_Top:CGFloat {
        get {
            return self.contentInset.top
        }
        set {
            var inset = self.contentInset
            inset.top = newValue
            self.contentInset = inset
        }
    }
    
    var wj_inset_Btm:CGFloat {
        get{
            return self.contentInset.bottom
        }
        set{
            var inset = self.contentInset
            inset.bottom = newValue
            self.contentInset = inset
        }
    }
    
    var wj_inset_left:CGFloat {
        get{
            return self.contentInset.left
        }
        set{
            var inset = self.contentInset
            inset.left = newValue
            self.contentInset = inset
        }
    }
    
    var wj_inset_right:CGFloat {
        get{
            return self.contentInset.right
        }
        set{
            var inset = self.contentInset
            inset.right = newValue
            self.contentInset = inset
        }
    }
}


extension UIScrollView {
    
    struct RunTimeKey {
        static let wj_headView_key = UnsafePointer<Any>(bitPattern: "headKey".hash)
        static let wj_scrollViewRefreshingBlock_key = UnsafePointer<Any>(bitPattern: "blockKey".hash)
    }
    
    
    var wj_headView:WJHeadView? {
        set {
            objc_setAssociatedObject(self, UIScrollView.RunTimeKey.wj_headView_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIScrollView.RunTimeKey.wj_headView_key) as? WJHeadView
        }
    }
    
    
    // MARK: - 添加刷新的方法
    func addWJRefresh(refreshing:@escaping ()->Void) {
        bounces = true
        wj_headView = WJHeadView(frame: CGRect(x: 0, y: -HEAD_HEIGHT, width: self.wj_Width, height: HEAD_HEIGHT), fatherView: self)
        wj_headView?.headRefreshing = {
            refreshing()
        }
        self.addSubview(wj_headView!)
    }
    
    // MARK: - 结束刷新
    func endRefresh() {
        if wj_headView != nil {
            wj_headView?.headEndRefreshing()
        }
    }
    
    /**
     *
     * 替代方法
     *
     */
    func swizzleMethod(cls:AnyClass!, originMethod:Selector, destinationMethod:Selector) {
        // class_getInstanceMethod获取属性方法
        // class_getClassMethod获取类方法
        let origin = class_getInstanceMethod(cls, originMethod)
        let swiz = class_getInstanceMethod(cls, destinationMethod)
        
        method_exchangeImplementations(origin, swiz)
    }
    
 
}
