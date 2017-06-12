//
//  MessageController.swift
//  BullitonBoard2
//
//  Created by ALIA M NEELY on 6/12/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
    
    // the specific frequency
    static let messagesWereUpdatesNotification = Notification.Name("messagesWereUpdated")
    
    static var messages: [Message] = [] {
        didSet {
            DispatchQueue.main.async {
            
                //The radio tower sending out the specific frecuency

            NotificationCenter.default.post(name: messagesWereUpdatesNotification, object: self)
            }
        }
    }
    
    static func addMessageWith(text: String) {
        
        let message = Message(text: text)
        
        
        CKContainer.default().publicCloudDatabase.save(message.cloudKitRecord) { (record, error) in
            
            if let error = error { NSLog(error.localizedDescription) } else {
                self.messages.append(message)
            }
        }
    }
    
    static func fetchMessages() {
        
        //Fetch all messages without a filter, think of predicate as a filter
        let predicate = NSPredicate(value: true)
        
        //query the record type using the predicate filters
        let query = CKQuery(recordType: Message.typeKey, predicate: predicate)
        
        //where do you want to perform the query, then flatmap using the cloudkit record
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error { NSLog(error.localizedDescription) }
            
            guard let records = records else { return }
            
            let messages = records.flatMap({ Message(cloudKitRecord: $0) })
            
            self.messages = messages
            
        }
        
    }
    
    
    
    
    
    
}
