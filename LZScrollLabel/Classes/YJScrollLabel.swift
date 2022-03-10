//
//  ScrollLabel.swift
//  ScrollLabel
//
//  Created by Kingpin on 2017/5/3.
//  Copyright © 2017年 yuejieee. All rights reserved.
//

import UIKit

public class YJScrollLabel: UIView {
    
    private var scrollView: UIScrollView!
    private var contentLabel: UILabel!
    public var scrollInterval: Double = 10 // scrollInterval: defualt 10s
    
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
        
        self.contentLabel = UILabel()
        self.contentLabel.frame = frame
        self.scrollView.addSubview(self.contentLabel)
        self.contentLabel.textColor = UIColor.black
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = CGSize.init(width: self.contentLabel.frame.size.width, height: 0)
        
        self.contentLabel.center = CGPoint.init(x: self.contentLabel.frame.size.width / 2, y: self.scrollView.center.y)
        if self.contentLabel.frame.size.width > self.scrollView.frame.size.width {
            self.setAnimate()
        }
    }
    
    private func setAnimate() {
        let offsetX = self.scrollView.contentOffset.x
        let labelW = self.contentLabel.frame.size.width
        let scrollW = self.scrollView.frame.size.width
        
        if offsetX == 0 {
            UIView.animate(withDuration: self.scrollInterval, animations: {
                self.scrollView.contentOffset = CGPoint.init(x: labelW - scrollW, y: 0)
            }) { (finish) in
                if finish {
                    self.setAnimate()
                }
            }
        } else {
            UIView.animate(withDuration: self.scrollInterval, animations: {
                self.scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
            }) { (finish) in
                if finish {
                    self.setAnimate()
                }
            }
        }
    }
    
    // MARK: - public method
    /*
     * title: label内容
     * alignment: 文字对齐方式
     * font: 字体大小
     */
    public func setTitle(_ title: NSString, _ color: UIColor = UIColor.black, _ alignment: NSTextAlignment = .left, _ font: UIFont = UIFont.systemFont(ofSize: 15)) {
        self.contentLabel.text = title as String
        self.contentLabel.textAlignment = alignment
        self.contentLabel.font = font
        self.contentLabel.textColor = color
        self.contentLabel.sizeToFit()
    }
}
