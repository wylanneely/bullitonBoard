//
//  Message.swift
//  BullitonBoard2
//
//  Created by ALIA M NEELY on 6/12/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation
import CloudKit

class Message{
    
    static let typeKey = "Message"
    
    private let textKey = "text"
    private let timestampKey = "timestamp"
    
    
    let text: String
    let timestamp: Date
    
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Message.typeKey)
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        return record
        
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let text = cloudKitRecord[textKey] as? String,
            let timestamp = cloudKitRecord[timestampKey] as? Date else {return nil}
        
        self.text = text
        self.timestamp = timestamp
        
        
    }
    
}
