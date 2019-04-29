//
//  DZMRMFontTypeView.swift
//  DZMeBookRead
//
//  Created by dengzemiao on 2019/4/18.
//  Copyright © 2019年 DZM. All rights reserved.
//

import UIKit

class DZMRMFontTypeView: DZMRMBaseView {

    private var fontNames:[String] = ["系统","黑体","楷体","宋体"]
    
    private var items:[UIButton] = []
    
    private var selectItem:UIButton!
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func addSubviews() {
        
        super.addSubviews()
        
        backgroundColor = UIColor.clear
        
        let count = fontNames.count
        
        for i in 0..<count {
            
            let fontName = fontNames[i]
            
            let item = UIButton(type: .custom)
            item.tag = i
            item.layer.cornerRadius = DZM_SPACE_SA_6
            item.layer.borderColor = DZM_READ_COLOR_MENU_COLOR.cgColor
            item.layer.borderWidth = DZM_SPACE_SA_1
            item.titleLabel?.font = DZM_FONT_SA_12
            item.setTitle(fontName, for: .normal)
            item.setTitleColor(DZM_READ_COLOR_MENU_COLOR, for: .normal)
            item.setTitleColor(DZM_READ_COLOR_MAIN, for: .selected)
            item.addTarget(self, action: #selector(clickItem(_:)), for: .touchUpInside)
            addSubview(item)
            items.append(item)
            
            if i == DZMReadConfigure.shared().fontIndex.intValue { clickItem(item) }
        }
    }
    
    @objc private func clickItem(_ item:UIButton) {
        
        if selectItem == item { return }
        
        selectItem?.isSelected = false
        
        selectItem?.layer.borderColor = DZM_READ_COLOR_MENU_COLOR.cgColor
        
        item.isSelected = true
        
        item.layer.borderColor = DZM_READ_COLOR_MAIN.cgColor
        
        selectItem = item
        
        DZMReadConfigure.shared().fontIndex = NSNumber(value: item.tag)
        
        DZMReadConfigure.shared().save()
        
        readMenu?.delegate?.readMenuClickFont?(readMenu: readMenu)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let count = fontNames.count
        
        let w = frame.size.width
        let h = frame.size.height
        
        let itemW = DZM_SPACE_SA_70
        let itemH = DZM_SPACE_SA_30
        let itemY = (h - itemH) / 2
        let itemSpaceW = (w - CGFloat(count) * itemW) / (CGFloat(count - 1))
        
        for i in 0..<count {
            
            let item = items[i]
            item.frame = CGRect(x: CGFloat(i) * (itemW + itemSpaceW), y: itemY, width: itemW, height: itemH)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
