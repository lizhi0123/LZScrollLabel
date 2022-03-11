//
//  ViewController.swift
//  ScrollLabel
//
//  Created by Kingpin on 2017/5/3.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit
import LZScrollLabel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let titleRect = CGRect.init(x: 0, y: 0, width: 300, height: 40)
        let titleLabel = UILabel.init(frame: titleRect)
        titleLabel.center = CGPoint.init(x: self.view.center.x, y: 200)
        self.view.addSubview(titleLabel)
        titleLabel.text = "YJScrollLabel"
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        
        let rect = CGRect.init(x: 0, y: 0, width: 250, height: 30)
        let scrollLabel = LZScrollLabel.init(frame: rect)
        scrollLabel.center = self.view.center
        scrollLabel.backgroundColor = .yellow
//        scrollLabel.textColor = .red
//        scrollLabel.text = "123456789😀😁🤣😂😄😅😆😇😉😊🙂😊🙂🙃☺️😋😌😍😘ABCDEFG"
        scrollLabel.setTitle("1 2 3 4 5 6 7 8 9 0 A B C D E F G H I J K L M NOPQRSTUVWXYZ")
        scrollLabel.startAnimate()
        scrollLabel.clipsToBounds = true
        self.view.addSubview(scrollLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

