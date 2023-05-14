//
//  RootTabBarCoordinator.swift
//  iStudy
//

import Foundation
import SwifterSwift

enum TabRoute: Int, Route {
    case mainAuth   = -1
    case home       = 0
    case digitizing = 1
    case review     = 2
    case community  = 3
}

class RootTabBarCoordinator: TabBarCoordinator<TabRoute> {
    //swiftlint:disable weak_delegate
    var tabbarDelegate: TabbarDelegate?
    //swiftlint:enable weak_delegate
    
    private let homeCoordinator: AppCoordinator
    private let digitizingCoordinator: AppCoordinator
    private let reviewCoordinator: AppCoordinator
    private let communityCoordinator: AppCoordinator
    
    var currentCoordinator: AppCoordinator? {
        let route = TabRoute(rawValue: rootViewController.selectedIndex)
        switch route {
        case .home: return homeCoordinator
        case .digitizing: return digitizingCoordinator
        case .review: return reviewCoordinator
        default: break
        }
        return nil
    }
    
    init() {
        self.homeCoordinator                                = AppCoordinator(initialRoute: .home)
        homeCoordinator.rootViewController.tabBarItem       = UITabBarItem(title: Strings.Tabbar.home,
                                                                           image: #imageLiteral(resourceName: "ic_menu_home"), tag: 0)
        
        self.digitizingCoordinator                          = AppCoordinator(initialRoute: .digitizing)
        digitizingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: Strings.Tabbar.digitizing,
                                                                           image: #imageLiteral(resourceName: "scan-documents"), tag: 1)
        
        self.reviewCoordinator                              = AppCoordinator(initialRoute: .review)
        reviewCoordinator.rootViewController.tabBarItem     = UITabBarItem(title: Strings.Tabbar.review,
                                                                           image: #imageLiteral(resourceName: "BookBookmark"), tag: 2)
        
        self.communityCoordinator                           = AppCoordinator(initialRoute: .community)
        communityCoordinator.rootViewController.tabBarItem  = UITabBarItem(title: Strings.Tabbar.community,
                                                                           image: #imageLiteral(resourceName: "ic_community"), tag: 3)
        
        let controllers                                     = [homeCoordinator.rootViewController,
                                                               digitizingCoordinator.rootViewController,
                                                               reviewCoordinator.rootViewController,
                                                               communityCoordinator.rootViewController]
        
        let tabBarController                                = BubbleTabBarController()
        tabBarController.viewControllers                    = controllers
        tabBarController.tabBar.tintColor                   = #colorLiteral(red: 0.3019607843, green: 0.5411764706, blue: 0.9411764706, alpha: 1)
        
        //        super.init(tabs: controllers)
        
        super.init(tabs: [homeCoordinator, digitizingCoordinator, reviewCoordinator, communityCoordinator], select: homeCoordinator)
        
        //
        //        (rootViewController as? BubbleTabBarController)?.viewControllers = controllers
        //        (rootViewController as? BubbleTabBarController)?.tabBar.tintColor = #colorLiteral(red: 0.3019607843, green: 0.5411764706, blue: 0.9411764706, alpha: 1)
        
        //        if #available(iOS 15.0, *) {
        //            let appearance = UITabBarAppearance()
        //            appearance.configureWithOpaqueBackground()
        //            appearance.backgroundColor = UIColor(hex: 0xFFFFFF)
        //            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Napoli, NSAttributedString.Key.font: StyleKit.appFont(with: .xxSmall, and: .medium)]
        //            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ButtonGrayTitle, NSAttributedString.Key.font: StyleKit.appFont(with: .xxSmall, and: .medium)]
        //
        //            rootViewController.tabBar.standardAppearance = appearance
        //            rootViewController.tabBar.scrollEdgeAppearance = rootViewController.tabBar.standardAppearance
        //        }
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        //
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        
        self.tabbarDelegate = TabbarDelegate(router: weakRouter)
        rootViewController.delegate = self.tabbarDelegate
    }
    
    override func prepareTransition(for route: TabRoute) -> TabBarTransition {
        switch route {
        case .mainAuth:
            let coordinator = AppCoordinator(initialRoute: .selectLanguage)
            AppDelegate.shared?.appCoordinator = coordinator
            return .presentOnRoot(coordinator)
        case .home:
            return .select(homeCoordinator.strongRouter)
        case .digitizing:
            return .select(digitizingCoordinator.strongRouter)
        case .review:
            return .select(reviewCoordinator.strongRouter)
        case .community:
            return .select(communityCoordinator.strongRouter)
        }
    }
}

class TabbarDelegate: NSObject, UITabBarControllerDelegate {
    
    var router: WeakRouter<TabRoute>
    
    init(router: WeakRouter<TabRoute>) {
        self.router = router
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let baseVC = (viewController as? BaseViewController<BaseViewModel>) {
            tabBarController.tabBar.isHidden = baseVC.setting.isHiddenTabbar
        }
    }
}
