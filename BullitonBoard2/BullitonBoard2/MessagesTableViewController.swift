//
//  MessagesTableViewController.swift
//  BullitonBoard2
//
//  Created by ALIA M NEELY on 6/12/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    
    var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        return formatter
    }()

    @IBOutlet weak var messageTextfield: UITextField!
    
    @IBAction func submitBUttonTapped(_ sender: Any) {
        
        guard let text = messageTextfield.text, text != "" else {return }
        MessageController.addMessageWith(text: text)
        messageTextfield.text = ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the car radio tuning into the notification
        NotificationCenter.default.addObserver(self, selector: #selector(refreshViews), name: MessageController.messagesWereUpdatesNotification, object: nil)
        MessageController.fetchMessages()

    }
    
    func refreshViews() {
        self.tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MessageController.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)

        let message = MessageController.messages[indexPath.row]
        
        let formattedDate = dateFormatter.string(from: message.timestamp)
        
        cell.textLabel?.text = "\(message.text)"
        cell.detailTextLabel?.text = formattedDate
        
        return cell
    }
    
}
