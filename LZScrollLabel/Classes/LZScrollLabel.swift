//
//  ScrollLabel.swift
//  ScrollLabel
//
//  Created by Lizhi on 2022/3/3.
//  Copyright © 2022年 lizhi. All rights reserved.
//

import UIKit

public class LZScrollLabel: UIView {
    
    private(set) var scrollView: UIScrollView!
    private(set) var mainLabel: UILabel!
    private var label2:UILabel!
    /// 速度
    public var scrollSpeed: Double = 100 
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews(frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(_ frame: CGRect) {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.scrollView.frame = frame
        self.scrollView.isScrollEnabled = false
        
        self.mainLabel = UILabel()
        self.label2 = UILabel()
        self.mainLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.label2.frame = CGRect(x: frame.width, y: 0, width: frame.width, height: frame.height)
        self.scrollView.addSubview(self.mainLabel)
        self.scrollView.addSubview(self.label2)
        self.mainLabel.textColor = UIColor.black
        self.label2.textColor = UIColor.black
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSize.init(width: self.mainLabel.frame.size.width, height: 0)
        
        self.mainLabel.center = CGPoint.init(x: self.mainLabel.frame.size.width / 2, y: self.scrollView.center.y)
        self.label2.center = CGPoint(x: self.mainLabel.center.x + self.mainLabel.frame.width, y: self.mainLabel.center.y)
        if self.mainLabel.frame.size.width > self.scrollView.frame.size.width {
            self.setAnimate()
        }
    }
    
    private func setAnimate() {
        let labelW = self.mainLabel.frame.size.width
//        let scrollW = self.scrollView.frame.size.width
        let scrollInterval = labelW/scrollSpeed
        
        UIView.animate(withDuration: scrollInterval, delay: 0, options: UIView.AnimationOptions.curveLinear) {
            self.scrollView.contentOffset = CGPoint(x: labelW, y: 0)
        } completion: { finished in
            if finished {
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                self.setAnimate()
            }
        }

    }
    
    // MARK: - public method
    /*
     * title: label内容
     * alignment: 文字对齐方式
     * font: 字体大小
     */
    public func setTitle(_ title: NSString, _ color: UIColor = UIColor.red, _ alignment: NSTextAlignment = .left, _ font: UIFont = UIFont.systemFont(ofSize: 15)) {
        self.mainLabel.text = title as String
        self.mainLabel.textAlignment = alignment
        self.mainLabel.font = font
        self.mainLabel.textColor = color
        self.mainLabel.sizeToFit()
        
        self.label2.text = title as String
        self.label2.textAlignment = alignment
        self.label2.font = font
        self.label2.textColor = color
        self.label2.sizeToFit()
    }
}
