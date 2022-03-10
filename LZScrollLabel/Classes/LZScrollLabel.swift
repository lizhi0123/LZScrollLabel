//
//  ScrollLabel.swift
//  ScrollLabel
//
//  Created by Lizhi on 2022/3/3.
//  Copyright © 2022年 lizhi. All rights reserved.
//

import UIKit

open class LZScrollLabel: UIView {
    private(set) var scrollView: UIScrollView!
    private(set) var mainLabel: UILabel!
    private var label2: UILabel!
    /// 速度
    open var scrollSpeed: Double = 100
    open var labelSpacing = 20
    open var text: String? {
        didSet {
            self.setTitle(self.text ?? "", self.mainLabel.textColor, self.mainLabel.textAlignment, self.mainLabel.font)
        }
    }

    private var isAutoScroll = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupSubviews(frame)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.stopAnimate()
    }
    
    private func setupSubviews(_ frame: CGRect) {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.scrollView.frame = frame
        self.scrollView.isScrollEnabled = false
        
        self.mainLabel = UILabel()
        self.label2 = UILabel()
        self.scrollView.addSubview(self.mainLabel)
        self.scrollView.addSubview(self.label2)
        self.mainLabel.textColor = UIColor.orange
        self.label2.textColor = UIColor.orange
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
       
        let mainLabelW = self.mainLabel.frame.size.width
        let scrollW = self.scrollView.frame.size.width
        self.isAutoScroll = mainLabelW > scrollW
        if self.isAutoScroll {
            self.label2.isHidden = false
            self.scrollView.contentSize = CGSize(width: self.mainLabel.frame.size.width + CGFloat(2 * self.labelSpacing), height: 0)
            self.mainLabel.center = CGPoint(x: self.mainLabel.frame.size.width / 2 + CGFloat(self.labelSpacing), y: self.scrollView.center.y)
            self.label2.center = CGPoint(x: self.mainLabel.center.x + self.mainLabel.frame.width + CGFloat(self.labelSpacing), y: self.mainLabel.center.y)
            self.setAnimate()
        } else {
            self.scrollView.contentOffset = CGPoint.zero
            self.mainLabel.center = self.scrollView.center
            self.scrollView.layer.removeAllAnimations()
            self.label2.isHidden = true
        }
    }
    
    private func setAnimate() {
        guard isAutoScroll == true else {
            return
        }
        let labelW = self.mainLabel.frame.size.width + CGFloat(self.labelSpacing)
        let scrollInterval = labelW / self.scrollSpeed
//        self.scrollView.layer.removeAllAnimations()
        UIView.animate(withDuration: scrollInterval, delay: 0, options: UIView.AnimationOptions.curveLinear) { [weak self] in
            guard let self = self else { return }
        self.scrollView.contentOffset = CGPoint(x: labelW, y: 0)
        } completion: { [weak self] finished in
            guard let self = self else { return }
            if finished {
            } else {
                print("-- 动画被停止了")
            }
            if self.isAutoScroll {
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                self.setAnimate()
            }
        }
    }
    open func startAnimate()  {
        isAutoScroll = self.mainLabel.frame.size.width > self.scrollView.frame.size.width
        if self.isAutoScroll {
            self.setAnimate()
        }
        
    }
    open func stopAnimate()  {
        isAutoScroll = false
        self.scrollView.layer.removeAllAnimations()
    }
    
    // MARK: - public method

    /*
     * title: label内容
     * alignment: 文字对齐方式
     * font: 字体大小
     */
    open func setTitle(_ title: String, _ color: UIColor = UIColor.red, _ alignment: NSTextAlignment = .left, _ font: UIFont = UIFont.systemFont(ofSize: 15)) {
        self.configLabel(self.mainLabel, title: title, color: color, alignment: alignment, font: font)
        
        self.configLabel(self.label2, title: title, color: color, alignment: alignment, font: font)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func configLabel(_ label: UILabel, title: String, color: UIColor, alignment: NSTextAlignment, font: UIFont) {
        label.text = title
        label.textAlignment = alignment
        label.font = font
        label.textColor = color
        label.sizeToFit()
    }
}

