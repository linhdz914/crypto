//
//  BubbleTabBarController.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit

open class BubbleTabBarController: UITabBarController {

    fileprivate var shouldSelectOnTabBar = true

    let customTabBarView: UIView = {

            //  daclare coustmeTabBarView as view
            let view = UIView(frame: .zero)

            // to make the cornerRadius of coustmeTabBarView
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            view.clipsToBounds = true

            // to make the shadow of coustmeTabBarView
            view.backgroundColor = .gray
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: -2.0)
            view.layer.shadowOpacity = 0.15
            view.layer.shadowRadius = 10.0
            return view
        }()
    
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = BubbleTabBar()
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.setValue(tabBar, forKey: "tabBar")
        
        addcoustmeTabBarView()
        hideTabBarBorder()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = tabBar.frame
        tabFrame.size.height = 90
        tabFrame.origin.y = view.frame.size.height - 90
        tabBar.frame = tabFrame
        customTabBarView.frame = tabFrame
    }
    
    private func addcoustmeTabBarView() {
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    open override func viewDidAppear(_ animated: Bool) {
//        var newSafeArea = UIEdgeInsets()
//        // Adjust the safe area to the height of the bottom views.
//        newSafeArea.bottom += coustmeTabBarView.bounds.size.height
//
//        // Adjust the safe area insets of the
//        //  embedded child view controller.
//        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
        
        super.viewDidAppear(animated)
    }

    private var _barHeight: CGFloat = 94
    open var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.index(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }

}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
