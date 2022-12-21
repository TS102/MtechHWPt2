//
//  SceneDelegate.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var orderTabBarItem: UITabBarItem!
    
    enum StateResorationController {
        
        enum Identifier: String {
            case categories, menu, menuItemDetail, order
        }
        case categories
        case menu(category: String)
        case menuItemDetail(MenuItem)
        case order
        
        var identifier: Identifier {
            switch self {
            case .categories: return Identifier.categories
            case .menu: return Identifier.menu
            case .menuItemDetail: return Identifier.menuItemDetail
            case .order: return Identifier.order
            }
        }
        
        init?(userActivity: NSUserActivity) {
            guard let identifier = userActivity.controllerIdentifier else {
                return nil
            }
            
            switch identifier {
            case .categories:
                self = .categories
            case .menu:
                if let category = userActivity.menuCategory {
                    self = .menu(category: category)
                } else {
                    return nil
                }
            case .menuItemDetail:
                if let menuItem = userActivity.menuItem {
                    self = .menuItemDetail(menuItem)
                } else {
                    return nil
                }
            case .order:
                self = .order
            }
            
        }
        
    }

    @objc func updateOrderBadge() {
        orderTabBarItem.badgeValue = String(MenuController.shared.order.menuItems.count)
        switch MenuController.shared.order.menuItems.count {
        case 0:
            orderTabBarItem.badgeValue = nil
        case 1:
            orderTabBarItem.badgeValue = String(MenuController.shared.order.menuItems.count)
        default:
        print("There are no orders added")
        }
    }
    
    
    // MARK: opt in to state restoration
    // this func is call when the scene enters the background
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return MenuController.shared.userActivity
    }
    // this func is called after the scene connects and the storyboard and views are loaded
    func scene(_ scene: UIScene, restoreInteractionStateWith stateRestorationActivity: NSUserActivity) {
        if let restoredOrder = stateRestorationActivity.order {
            MenuController.shared.order = restoredOrder
        }
        
        guard let resorationController = StateResorationController(userActivity: stateRestorationActivity),
              let tabBarController = window?.rootViewController as? UITabBarController,
              tabBarController.viewControllers?.count == 2,
              let categoryTableViewController = (tabBarController.viewControllers?[0] as? UINavigationController)?.topViewController as? CategoryTableViewController
        else {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        switch resorationController {
        case .categories:
            break
        case .order:
            tabBarController.selectedIndex = 1
        case .menu(let category):
            let menuTableViewController = storyBoard.instantiateViewController(identifier: resorationController.identifier.rawValue) { (coder) in
                return MenuTableTableViewController(coder: coder, category: category)
            }
            categoryTableViewController.navigationController?.pushViewController(menuTableViewController, animated: true)
        case .menuItemDetail(let menuItem):
            let menuTableViewController = storyBoard.instantiateViewController(identifier: StateResorationController.Identifier.menu.rawValue) { (coder) in
                return MenuTableTableViewController(coder: coder, category: menuItem.category)
            }
            let menuItemDetailViewController = storyBoard.instantiateViewController(identifier: resorationController.identifier.rawValue) { (coder) in
                return MenuItemDetailViewController(coder: coder, menuItems: menuItem)
            }
            categoryTableViewController.navigationController?.pushViewController(menuTableViewController, animated: false)
            categoryTableViewController.navigationController?.pushViewController(menuItemDetailViewController, animated: false)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrderBadge), name: MenuController.orderUpdateNotification, object: nil)
        
        orderTabBarItem = (window?.rootViewController as? UITabBarController)?.viewControllers?[1].tabBarItem
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

