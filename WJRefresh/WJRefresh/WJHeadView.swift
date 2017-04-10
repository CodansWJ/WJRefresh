//
//  WJHeadView.swift
//  WJRefresh
//
//  Created by 汪俊 on 2017/3/7.
//  Copyright © 2017年 Codans. All rights reserved.
//

import UIKit

class WJHeadView: UIView {
    enum WJHeadType {
        case NoAction                                         // 无动作
        case LoosenToRefresh                                  // 松开刷新
        case Refreshing                                       // 正在刷新
    }
    
    // 刷新的闭包
    typealias headRefreshingBlock = ()->Void
    var headRefreshing:headRefreshingBlock?
    private var FScrollView:UIScrollView!                     // 滑动父视图
    private var scrollContext:CGPoint = CGPoint()             // 父视图偏移量
    var scrollViewOriginalInset = UIEdgeInsets()
    
    var imageView: UIImageView!                               // 图片
    var textLab: UILabel!                                     // 展示文字
    
    
    
    private var type = WJHeadType.NoAction {
        didSet{
            selfChangedType()
        }
    }
    
    var lastType =  WJHeadType.NoAction                               // 记录上一次状态
    
    // MARK: - 私有化初始化
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - 重写初始化
    init(frame: CGRect, fatherView:UIScrollView) {
        super.init(frame: frame)
        FScrollView = fatherView
        FScrollView.contentInset = scrollViewOriginalInset
        addScrollViewObserver()
        initHeadView()
    }
    
    
    // MARK: - heard页面布局
    func initHeadView() {
        textLab = UILabel(frame: CGRect(x: 0, y: 0, width: WIDTH / 2.0, height: wj_Height / 2.0))
        textLab.center = CGPoint(x: bounds.width / 2.0, y: self.bounds.height / 2.0)
        textLab.textAlignment = .center
        textLab.text = "向下拖拽刷新"
        textLab.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.addSubview(textLab)
//        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    
    // MARK: - KVO监听
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if context == &scrollContext {
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                makeChangeForNewValue(value: newValue as! CGPoint)
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // MARK: - 根据偏移量做处理
    func makeChangeForNewValue(value:CGPoint) {
        if Int(value.y) < -Int(HEAD_HEIGHT) {
            type = .LoosenToRefresh
        }else if Int(value.y) == -Int(HEAD_HEIGHT) {
            // 当拖动控件到达临界值时不作处理
            if FScrollView.isDragging {
                return
            }
            type = .Refreshing
        }else{
            type = .NoAction
        }
    }
    
    // MARK: - 状态监听
    private func selfChangedType() {
        
        // 实时监听做动作筛选
        switch type {
        case .LoosenToRefresh:
            if !FScrollView.isDragging {  // 松开且没有拖拽时
               FScrollView.wj_inset_Top = scrollViewOriginalInset.top + HEAD_HEIGHT
            }
        case .Refreshing:
            startRefreshing()
        default:
            break
        }
        // 状态改变监听：改变head内容
        if type != lastType {
            typeChanged(theType: type)
        }
        lastType = type
    }
    
    // MARK: - 状态改变时
    func typeChanged(theType:WJHeadType) {
        switch theType {
        case .LoosenToRefresh:
            print("松开刷新")
//            backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            textLab.text = "松手即可开始刷新"
        case .Refreshing:
            print("刷新>>>>>>>>>>>>>")
            textLab.text = "😳 努力刷新中"
//            backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        default:
//            backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            textLab.text = "向下拖拽刷新"
            print("正常")
        }
    }
    
    // MARK: - 开始刷新
    func startRefreshing() {
        //      FScrollView.bounces = false
        removeScrollViewObserver()
        if headRefreshing != nil {
            self.headRefreshing!()
        }
    }
    
    // MARK: - 结束刷新
    func headEndRefreshing() {
//        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        textLab.text = "刷新成功"
        // 0.5秒之后开始返回原先状态
        gDelay(time:0.5 , task: {
            UIView.animate(withDuration: 0.5, animations: {
                // 再0.5秒过程恢复
                self.FScrollView.wj_inset_Top = self.scrollViewOriginalInset.top
            }, completion: { (finished) in
                self.FScrollView.bounces = true
                self.addScrollViewObserver()
                self.textLab.text = "向下拖拽刷新"
            })
        })
    }
    
    // MARK: - 父视图scroll添加监听
    private func addScrollViewObserver() {
        FScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: &scrollContext)
    }
    
    // MARK: - 父视图scroll取消监听
    private func removeScrollViewObserver() {
        FScrollView.removeObserver(self, forKeyPath: "contentOffset", context: &scrollContext)
    }

    // MARK: - 消失销毁监听
    deinit {
        removeScrollViewObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
