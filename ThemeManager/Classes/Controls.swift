//
//  Controls.swift
//
//  Created by Kesava on 07/06/2016.
//  Copyright © 2016 Small Screen Science Ltd. All rights reserved.
//

import Foundation
import UIKit

private enum PlistElement {
    case color
    case bgColor
    case imageTintColor
    case borderColor
}

private class ControlUtils {
    static func fetch(_ element:PlistElement, dict:[String:AnyObject]) -> AnyObject? {
        
        switch element {
        case .color:
            if let colorStr = dict[ThemeConstants.plistKeyColorHex] as? String {
                if let colorDict = ThemeManager.sharedInstance.plistDict[colorStr],
                    let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                    return UIColor(rgba: color)
                } else {
                    return UIColor(rgba: colorStr)
                }
            }
            
        case .bgColor:
            if let colorStr = dict[ThemeConstants.plistKeyBGColorHex] as? String {
                if let colorDict = ThemeManager.sharedInstance.plistDict[colorStr],
                    let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                    return UIColor(rgba: color)
                }  else {
                    return UIColor(rgba: colorStr)
                }
            }
            
        case .imageTintColor:
            if let colorStr = dict[ThemeConstants.plistKeyImageTintHex] as? String {
                if let colorDict = ThemeManager.sharedInstance.plistDict[colorStr],
                    let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                    return UIColor(rgba: color)
                }  else {
                    return UIColor(rgba: colorStr)
                }
            }
        case .borderColor:
            if let colorStr = dict[ThemeConstants.plistKeyBorderHex] as? String {
                if let colorDict = ThemeManager.sharedInstance.plistDict[colorStr],
                    let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                    return UIColor(rgba: color)
                }  else {
                    return UIColor(rgba: colorStr)
                }
            }
        }
        return nil
    }
}

@IBDesignable
class TMLabel: UILabel {
    
    @IBInspectable
    var type: String = "" {
        didSet {
            guard let dict = ThemeManager.sharedInstance.plistDict[type] else {
                return
            }
            
            if let fontName = dict[ThemeConstants.plistKeyFont] as? String,
                let size = dict[ThemeConstants.plistKeyTextSize] as? CGFloat {
                if fontName == "SystemFont" {
                    if let fontWeight = dict[ThemeConstants.plistKeyFontWeight] as? String {
                        font = UIFont.systemFont(ofSize: size, weight: (fontWeight == "Bold" ? UIFontWeightBold : (fontWeight == "Medium" ? UIFontWeightMedium: UIFontWeightRegular)))
                    }
                } else {
                    font = UIFont(name: fontName, size:size)
                }
            }
        }
    }
    
    @IBInspectable
    var color: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[color] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                textColor = UIColor(rgba: color)
            }
        }
    }
    
    @IBInspectable
    var bgColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[bgColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                backgroundColor = UIColor(rgba: color)
            }
        }
    }
    
    @IBInspectable var inset: CGFloat = 0.0
}

@IBDesignable
class TMButton: UIButton {
    
    @IBInspectable
    var type: String = "" {
        didSet {
            guard let dict = ThemeManager.sharedInstance.plistDict[type] else {
                return
            }
            
            if let fontName = dict[ThemeConstants.plistKeyFont] as? String,
                let size = dict[ThemeConstants.plistKeyTextSize] as? CGFloat {
                if fontName == "SystemFont" {
                    if let fontWeightStr = dict[ThemeConstants.plistKeyFontWeight] as? String {
                        var fontWeightValue:CGFloat = UIFontWeightRegular
                        switch fontWeightStr {
                        case "Bold":
                            fontWeightValue = UIFontWeightBold
                        case "Medium":
                            fontWeightValue = UIFontWeightMedium
                        case "Light":
                            fontWeightValue = UIFontWeightLight
                        default:
                            break
                        }
                        titleLabel?.font = UIFont.systemFont(ofSize: size, weight: fontWeightValue)
                    }
                } else {
                    titleLabel?.font = UIFont(name: fontName, size:size)
                }
            }
            
            if let color = ControlUtils.fetch(.color, dict: dict) as? UIColor {
                setTitleColor(color, for: UIControlState())
            }
            
            if let bgColor = ControlUtils.fetch(.bgColor, dict: dict) as? UIColor {
                backgroundColor = bgColor
            }
            
            if let cornerRadius = dict[ThemeConstants.plistKeyCornerRadius] as? CGFloat {
                layer.cornerRadius = cornerRadius
            }
            
            if let leftInset = dict[ThemeConstants.plistKeyTitleLeftInset] as? CGFloat {
                titleEdgeInsets = UIEdgeInsetsMake(0, leftInset, 0, 0)
            }
            
            if let tintColor = ControlUtils.fetch(.imageTintColor, dict: dict) as? UIColor {
                imageView?.tintColor = tintColor
            }
            
            if let borderColor = ControlUtils.fetch(.borderColor, dict: dict) as? UIColor {
                layer.borderColor = borderColor.cgColor
                layer.borderWidth = 1
                layer.cornerRadius = 3
            }
        }
    }
    
    @IBInspectable
    var shadow: String = "" {
        didSet {
            guard let shadowDict = ThemeManager.sharedInstance.plistDict[shadow] else {
                return
            }
            
            if let color = ControlUtils.fetch(.bgColor, dict: shadowDict) as? UIColor {
                self.backgroundColor = color
            }
            
            if let radius = shadowDict[ThemeConstants.plistKeyShadowRadius] as? CGFloat {
                layer.shadowRadius = radius
            }
            if let opacity = shadowDict[ThemeConstants.plistKeyShadowOpacity] as? Float {
                layer.shadowOpacity = opacity
            }
            if let offsetX = shadowDict[ThemeConstants.plistKeyShadowOffsetX] as? CGFloat,
                let offsetY = shadowDict[ThemeConstants.plistKeyShadowOffsetY] as? CGFloat {
                layer.shadowOffset = CGSize(width: offsetX,height: offsetY)
            }
        }
    }
    
    @IBInspectable
    var titleColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[titleColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                setTitleColor(UIColor(rgba: color), for: UIControlState())
            }
        }
    }
    
    @IBInspectable
    var borderColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[borderColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                layer.borderColor = UIColor(rgba: color).cgColor
                layer.borderWidth = 1
                layer.cornerRadius = 10
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var bgColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[bgColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                self.backgroundColor = UIColor(rgba: color)
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
}

@IBDesignable
class TMImageView: UIImageView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var imageName: String = ThemeConstants.themeImgViewEmpty {
        didSet {
            guard let imageDict = ThemeManager.sharedInstance.plistDict[imageName],
            let imageNameStr = imageDict[ThemeConstants.plistKeyImageName] as? String,
                let image = UIImage(named: imageNameStr) else {
                return
            }
            self.image = image
        }
    }

    @IBInspectable
    var borderColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[borderColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                layer.borderColor = UIColor(rgba: color).cgColor
            }
        }
    }
    
    
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var tntColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[tntColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                tintColor = UIColor(rgba: color)
            }
        }
    }
}

@IBDesignable
class TMView: UIView {
    
    @IBInspectable
    var bgColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[bgColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                backgroundColor = UIColor(rgba: color)
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var shadow: String = "" {
        didSet {
            guard let shadowDict = ThemeManager.sharedInstance.plistDict[shadow] else {
                return
            }
            
            if let color = ControlUtils.fetch(.bgColor, dict: shadowDict) as? UIColor {
                backgroundColor = color
            }
            
            if let radius = shadowDict[ThemeConstants.plistKeyShadowRadius] as? CGFloat {
                layer.shadowRadius = radius
            }
            if let opacity = shadowDict[ThemeConstants.plistKeyShadowOpacity] as? Float {
                layer.shadowOpacity = opacity
            }
            if let offsetX = shadowDict[ThemeConstants.plistKeyShadowOffsetX] as? CGFloat,
                let offsetY = shadowDict[ThemeConstants.plistKeyShadowOffsetY] as? CGFloat {
                layer.shadowOffset = CGSize(width: offsetX,height: offsetY)
            }
        }
    }
    
    @IBInspectable
    var borderColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[borderColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                layer.borderColor = UIColor(rgba: color).cgColor
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}

@IBDesignable
class TMTextField: UITextField {
    
    @IBInspectable
    var type: String = "" {
        didSet {
            guard let dict = ThemeManager.sharedInstance.plistDict[type] else {
                return
            }
            
            if let fontName = dict[ThemeConstants.plistKeyFont] as? String,
                let size = dict[ThemeConstants.plistKeyTextSize] as? CGFloat {
                if fontName == "SystemFont" {
                    if let fontWeight = dict[ThemeConstants.plistKeyFontWeight] as? String {
                        font = UIFont.systemFont(ofSize: size, weight: (fontWeight == "Bold" ? UIFontWeightBold : (fontWeight == "Medium" ? UIFontWeightMedium: UIFontWeightRegular)))
                    }
                } else {
                    font = UIFont(name: fontName, size:size)
                }
            }
            
            if let color = ControlUtils.fetch(.color, dict: dict) as? UIColor {
                textColor = color
            }
            
            if let bgColor = ControlUtils.fetch(.bgColor, dict: dict) as? UIColor {
                backgroundColor = bgColor
            }
            
            if let cornerRadius = dict[ThemeConstants.plistKeyCornerRadius] as? CGFloat {
                layer.cornerRadius = cornerRadius
            }
        }
    }
    
    @IBInspectable
    var insetX: CGFloat = 20
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: 0)
    }
}

@IBDesignable
class TMTextView: UITextView {
    
    @IBInspectable
    var type: String = "" {
        didSet {
            guard let dict = ThemeManager.sharedInstance.plistDict[type] else {
                return
            }
            
            if let fontName = dict[ThemeConstants.plistKeyFont] as? String,
                let size = dict[ThemeConstants.plistKeyTextSize] as? CGFloat {
                if fontName == "SystemFont" {
                    if let fontWeight = dict[ThemeConstants.plistKeyFontWeight] as? String {
                        font = UIFont.systemFont(ofSize: size, weight: (fontWeight == "Bold" ? UIFontWeightBold : (fontWeight == "Medium" ? UIFontWeightMedium: UIFontWeightRegular)))
                    }
                } else {
                    font = UIFont(name: fontName, size:size)
                }
            }
            
            if let color = ControlUtils.fetch(.color, dict: dict) as? UIColor {
                textColor = color
            }
            
            if let bgColor = ControlUtils.fetch(.bgColor, dict: dict) as? UIColor {
                backgroundColor = bgColor
            }
            
            if let cornerRadius = dict[ThemeConstants.plistKeyCornerRadius] as? CGFloat {
                layer.cornerRadius = cornerRadius
            }
        }
    }
    
    @IBInspectable
    var offset: CGFloat = 0 {
        didSet {
            textContainerInset = UIEdgeInsetsMake(offset, offset, offset, offset)
        }
    }
    
    @IBInspectable
    var bgColor: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[bgColor] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                backgroundColor = UIColor(rgba: color)
            }
        }
    }
    
    @IBInspectable
    var color: String = "" {
        didSet {
            guard let colorDict = ThemeManager.sharedInstance.plistDict[color] else {
                return
            }
            
            if let color = colorDict[ThemeConstants.plistKeyColorHex] as? String {
                textColor = UIColor(rgba: color)
            }
        }
    }
}
