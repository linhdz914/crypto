//
//  UIView+Extensions.swift
//  iStudy
//

import UIKit
import SwifterSwift

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return loadFromNib(named: String(describing: self)) as! T
    }
    
    func rotate(seconds: CFTimeInterval) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = seconds
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    /**
     Rounds the given set of corners to the specified radius
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addCardShadow() {
        addShadow(ofColor: .lightGray,
                  radius: 16,
                  offset: .zero,
                  opacity: 0.3)
    }
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}

// MARK: - Localized helpers
extension UIButton {
    @IBInspectable var localizeStringKey: String {
        get {
            titleLabel?.text ?? ""
        }
        set {
            let titleLocalized = localizedString("Localizable", newValue)
            setTitle(titleLocalized, for: .normal)
        }
    }
}

extension UILabel {
    @IBInspectable var localizeStringKey: String {
        get {
            text ?? ""
        }
        set {
            let titleLocalized = localizedString("Localizable", newValue)
            text = titleLocalized
        }
    }
}

extension UITextField {
    @IBInspectable var placeHolderLocalizedKey: String {
        get {
            self.placeholder ?? ""
        }
        set {
            let titleLocalized = localizedString("Localizable", newValue)
            placeholder = titleLocalized
        }
    }
}

var isEnglish: Bool {
    guard let currentAppLanguage = UserDataManager().userLanguage() else {
        if #available(iOS 16, *) {
            //            return Locale.current.language.languageCode?.identifier.lowercased() == "en"
            return Locale.current.languageCode?.lowercased() == "en"
        } else {
            return Locale.current.languageCode?.lowercased() == "en"
        }
    }
    
    return currentAppLanguage == .english
}

func localizedString(
    _ table: String,
    _ key: String,
    _ args: CVarArg...
) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: "Localizable")
    var currentLocale = Locale.current
    if let currentAppLanguage = UserDataManager().userLanguage() {
        currentLocale = currentAppLanguage.toLocale
    }
    return String(format: format, locale: currentLocale, arguments: args)
}

private final class BundleToken {
    static var bundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        guard let currentAppLanguage = UserDataManager().userLanguage(),
              let path = Bundle(for: BundleToken.self)
            .path(forResource: currentAppLanguage.languageCode, ofType: "lproj") else {
            return Bundle(for: BundleToken.self)
        }
        return Bundle(path: path) ?? Bundle(for: BundleToken.self)
#endif
    }
}
