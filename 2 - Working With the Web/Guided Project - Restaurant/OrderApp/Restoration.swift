//
//  Restoration.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/20/22.
//

import Foundation

    extension NSUserActivity {
        
    
            var controllerIdentifier: StateResorationController.Identifier? {
                get {
                    if let controllerIdentifierString = userInfo? ["controllerIdentifier"] as? String {
                        return StateResorationController.Identifier(rawValue: controllerIdentifierString)
                    } else {
                        return nil
                    }
                }
            }

            var menuCategory: String? {
                get {
                    return userInfo?["menuCategory"] as? String
                } set {
                    userInfo?["menuCategory"] = newValue
                }
            }
        
            var menuItem: MenuItem? {
                get {
                    guard let jsonData = userInfo?["menuItem"] as? Data else {
                        return nil
                    }
                    return try? JSONDecoder().decode(MenuItem.self, from: jsonData)       }
                set {
                    if let newValue = newValue, let jsondData = try? JSONEncoder().encode(newValue) {
                        addUserInfoEntries(from: ["menuItem": jsondData])
                    } else {
                        userInfo?["menuItem"] = nil
                    }
                }
            }
        
        var order: Order? {
            get {
                guard let jsonData = userInfo?["order"] as? Data else {
                    return nil
                }
                
                return try? JSONDecoder().decode(Order.self, from: jsonData)
            }
            set {
                if let newValue = newValue, let jsonData = try? JSONEncoder().encode(newValue) {
                    addUserInfoEntries(from: ["order": jsonData])
                } else {
                    userInfo?["order"] = nil
                }
            }
            
  
        }
        
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
        
    }

