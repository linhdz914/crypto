//
//  BaseViewController.swift
//  Currrency
//
//  Created by Linh on 18/05/2023.
//

import UIKit

struct NavigationSetting {
    var title: String? = nil
    var isHiddenTabbar: Bool = false
    var isHiddenNavigation: Bool = false
    var backImage: String = "arrow_left"
    var navigationColor: UIColor = StyleKit.MainColorNavigationBar
    var navigationShadow: UIImage? = nil
    var rightButtons: [UIBarButtonItem]? = nil
    var leftButtons: [UIBarButtonItem]? = nil
}

extension NavigationSetting {
    static func singleTitle(_ title: String) -> Self {
        let lblTitle = UILabel()
        lblTitle.font = UIFont.appxmLargeMedium
        lblTitle.text = " \(title)"
        lblTitle.textAlignment = .left
        lblTitle.textColor = .white
        
        return NavigationSetting(
            isHiddenTabbar: false,
            isHiddenNavigation: false,
            leftButtons: [UIBarButtonItem(customView: lblTitle)]
        )
    }
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public var setting: NavigationSetting {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_left"), for: .normal)
        button.titleLabel?.font = UIFont.appxmLargeMedium
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.sizeToFit()
        
        return NavigationSetting(
            isHiddenTabbar: true,
            isHiddenNavigation: false,
            leftButtons: [UIBarButtonItem(customView: button)]
        )
    }
    
    private func styleNavigation() {
        if let leftButtons = setting.leftButtons {
            navigationItem.leftBarButtonItems = leftButtons
        } else {
            navigationItem.leftBarButtonItems = nil
        }
        
        if let rightButtons = setting.rightButtons {
            navigationItem.rightBarButtonItems = rightButtons
        } else {
            navigationItem.rightBarButtonItems = nil
        }
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
