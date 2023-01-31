//
//  Bill+Extras.swift
//  BillManager
//

import Foundation
import UserNotifications

extension Bill {
    
    static let notificationCategoryID: String = "Reminder notifications"
    
    var hasReminder: Bool {
        return (remindDate != nil)
    }
    
    var isPaid: Bool {
        return (paidDate != nil)
    }
    
    var formattedDueDate: String {
        let dateString: String
        
        if let dueDate = self.dueDate {
            dateString = dueDate.formatted(date: .numeric, time: .omitted)
        } else {
            dateString = ""
        }
        
        return dateString
    }
    
    mutating func removeReminders() {
        if let id = notificationID {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
            remindDate = nil
            notificationID = nil
        }
    }
    
    
    
    mutating func scheduleReminders(date: Date, completeion: @escaping (Bill) -> ()) {
        
        var updatedBill = self
        updatedBill.removeReminders()
        checkAuthorization { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completeion(updatedBill)
                }
                return
            }
            // making the content if authorization if granted
            let content = UNMutableNotificationContent()
            content.title = "Bill Reminder"
            content.body = "amount due is \(updatedBill.amount ?? 0) to \(updatedBill.payee ?? "") on \(updatedBill.dueDate ?? date) "
            content.categoryIdentifier = Bill.notificationCategoryID
        
            
            let triggerDateComponents = Calendar.current.dateComponents([.second, .minute, .hour, .month, .day, .year], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
            
            let notificationId = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error: Error?) in
                
                DispatchQueue.main.async {
                    if let error = error{
                        print(error.localizedDescription)
                    } else {
                        updatedBill.notificationID = notificationId
                        updatedBill.remindDate = date
                    }
                    DispatchQueue.main.async {
                        completeion(updatedBill)
                    }
                }
            }
            
            
            
        }
        
    }
    
    private func checkAuthorization(completion: @escaping (Bool) -> ()) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case  .authorized:
                completion(true)
            case .notDetermined:
                notificationCenter.requestAuthorization( options: [.alert, .sound],completionHandler: { (granted, _) in
                    completion(granted)
                })
            case .denied, .provisional, .ephemeral:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }

    
}
