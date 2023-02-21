//
//  AppDelegate.swift
//  BillManager
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let remindActionID: String = "Remind action"
    let markAsPaidAction: String = "Paid Action"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let remindAction = UNNotificationAction(identifier: remindActionID, title: "Payment", options: [.authenticationRequired])
        
        let markAsPaidAction = UNNotificationAction(identifier: markAsPaidAction, title: "Paid", options: [.authenticationRequired])
        
        
        // putting in the actions above into a category
        let category = UNNotificationCategory(identifier: Bill.notificationCategoryID, actions: [remindAction, markAsPaidAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        guard var bill = Database.shared.getBillAgain(with: id) else { completionHandler(); return }
        
        switch response.actionIdentifier {
        case remindActionID:
            let newRemindDate = Date().addingTimeInterval(60 * 60)
            
            bill.scheduleReminders(date: newRemindDate, completeion: { (updatedBill) in
                Database.shared.updateAndSave(updatedBill)
            }) 
        case markAsPaidAction:
            bill.paidDate = Date()
            Database.shared.updateAndSave(bill)
        default:
            break
        }
        
        completionHandler()
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

