//
//  StringExtension.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/10/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

//import Foundation
//extension String {
//    func boolValueFromString() -> Bool {
//        return NSString(string: self).boolValue
//    }
//}


//  Created by Manvendra on 06/08/19.
//  Copyright ©2018 iosManvendra. All rights reserved.
//
import UIKit
extension String {
    func getAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

extension NSMutableAttributedString {
    func apply(attribute: [NSAttributedString.Key: Any], subString: String)  {
        if let range = self.string.range(of: subString) {
            self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
        }
    }
    func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
        if range.location != NSNotFound {
            self.setAttributes(attribute, range: range)
        }
    }
    func apply(color: UIColor, subString: String) {
        
        if let range = self.string.range(of: subString) {
            self.apply(color: color, onRange: NSRange(range, in:self.string))
        }
    }
    func apply(color: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                           range: onRange)
    }
    func apply(font: UIFont, subString: String)  {
        
        if let range = self.string.range(of: subString) {
            self.apply(font: font, onRange: NSRange(range, in: self.string))
        }
    }
    func apply(font: UIFont, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.font: font], range: onRange)
    }
    func apply(backgroundColor: UIColor, subString: String) {
        if let range = self.string.range(of: subString) {
            self.apply(backgroundColor: backgroundColor, onRange: NSRange(range, in: self.string))
        }
    }
    func apply(backgroundColor: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.backgroundColor: backgroundColor],
                           range: onRange)
    }
    func underLine(subString: String) {
        if let range = self.string.range(of: subString) {
            self.underLine(onRange: NSRange(range, in: self.string))
        }
    }
    func underLine(onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue],
                           range: onRange)
    }
    func strikeThrough(thickness: Int, subString: String)  {
        if let range = self.string.range(of: subString) {
            self.strikeThrough(thickness: thickness, onRange: NSRange(range, in: self.string))
        }
    }
    func strikeThrough(thickness: Int, onRange: NSRange)  {
        
        self.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.thick.rawValue],
                           range: onRange)
    }
    func applyStroke(color: UIColor, thickness: Int, subString: String) {
        if let range = self.string.range(of: subString) {
            self.applyStroke(color: color, thickness: thickness, onRange: NSRange(range, in: self.string))
        }
    }
    func applyStroke(color: UIColor, thickness: Int, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.strokeColor : color],
                           range: onRange)
        self.addAttributes([NSAttributedString.Key.strokeWidth : thickness],
                           range: onRange)
    }
    func applyShadow(shadowColor: UIColor, shadowWidth: CGFloat,
                     shadowHeigt: CGFloat, shadowRadius: CGFloat,
                     subString: String) {
        if let range = self.string.range(of: subString) {
            self.applyShadow(shadowColor: shadowColor, shadowWidth: shadowWidth,
                             shadowHeigt: shadowHeigt, shadowRadius: shadowRadius,
                             onRange: NSRange(range, in: self.string))
            
        }
    }
    func applyShadow(shadowColor: UIColor, shadowWidth: CGFloat,
                     shadowHeigt: CGFloat, shadowRadius: CGFloat,
                     onRange: NSRange) {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: shadowWidth, height: shadowHeigt)
        shadow.shadowColor = shadowColor
        shadow.shadowBlurRadius = shadowRadius
        self.addAttributes([NSAttributedString.Key.shadow : shadow], range: onRange)
    }
    func alignment(alignment: NSTextAlignment, subString: String) {
        if let range = self.string.range(of: subString) {
            self.alignment(alignment: alignment, onRange: NSRange(range, in: self.string))
        }
    }
    func alignment(alignment: NSTextAlignment, onRange: NSRange) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        self.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: onRange)
    }
    func apply(link: String, subString: String)  {
        if let range = self.string.range(of: subString) {
            self.apply(link: link, onRange: NSRange(range, in: self.string))
        }
    }
    func apply(link: String, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.link: link], range: onRange)
    }
    func addImage(image: UIImage) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        let imageString = NSAttributedString(attachment: imageAttachment)
        self.append(imageString)
    }
    func convert(html: String) -> NSAttributedString? {
        let data = Data(html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        } else {
            return nil
        }
    }
}
