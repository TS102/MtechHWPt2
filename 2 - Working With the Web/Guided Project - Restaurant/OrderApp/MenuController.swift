//
//  MenuController.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/7/22.
//

import Foundation
import UIKit

class MenuController {

    var userActivity = NSUserActivity(activityType: "com.example.OrderApp.order")
        
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
            
        }
    
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
            userActivity.order = order
        }
    }
    
    static let shared = MenuController()
    
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    
    let baseUrl = URL(string: "http://localhost:8080/")!
    
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        case imageDataMissing
    }
    // fetching the right image similair to other fetch request exept that we don't have to convert to json
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw MenuControllerError.imageDataMissing
        }
        
        return image
    }
    
    
    func fetchCategories() async throws -> [String] {
        let categoriesUrl = baseUrl.appendingPathComponent("categories")
        
        let (data, response) = try await URLSession.shared.data(from: categoriesUrl)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.categoriesNotFound
        }
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
        
        return categoriesResponse.categories
    }
    
    
    func fetchMenuItems(forCategory categoryName: String) async throws -> [MenuItem] {
        let initialMenuURL = baseUrl.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let (data, response) = try await URLSession.shared.data(from: menuURL)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }
        
        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
        
        return menuResponse.items
    }
    
    
    typealias MinutesToPrepare = Int
    
    func submitOrder(forMenuIDs menuIDs: [Int]) async throws -> MinutesToPrepare {
        let orderUrl = baseUrl.appendingPathComponent("order")
        var request = URLRequest(url: orderUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuIDsDict = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(menuIDsDict)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.orderRequestFailed
        }
        
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        
        return orderResponse.prepTime
    }
 
    func updateUserActivity(with controller: StateResorationController) {
        switch controller {
        case .menu(let category):
            userActivity.menuCategory = category
        case .menuItemDetail(let menuItem):
            userActivity.menuItem = menuItem
        case .order, .categories:
            break
        }
    }

}
