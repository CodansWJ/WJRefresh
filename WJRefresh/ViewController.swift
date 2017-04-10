//
//  ViewController.swift
//  WJRefresh
//
//  Created by 汪俊 on 2017/3/6.
//  Copyright © 2017年 Codans. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mainTableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let naviView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 64))
        let lab = UILabel(frame: naviView.bounds)
        lab.center = CGPoint(x: naviView.bounds.width / 2.0, y: (naviView.bounds.height / 2.0) + 10.0)
        lab.text = "WJRefresh"
        lab.textAlignment = .center
        naviView.addSubview(lab)
        naviView.backgroundColor = UIColor(white: 1, alpha: 0.4)
        self.view.addSubview(naviView)
        
        mainTableView = UITableView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: HEIGHT - 64))
        mainTableView.addWJRefresh { 
            gDelay(time: 1, task: {
                self.mainTableView.endRefresh()
            })
        }
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.view.addSubview(mainTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_flag = "defultFlag"
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_flag)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cell_flag)
        }
        
        cell?.textLabel?.text = "你好"
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    


}

