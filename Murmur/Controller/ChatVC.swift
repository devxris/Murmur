//
//  ChatVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

	// outlets
	@IBOutlet weak var channelLabel: UILabel!
	@IBOutlet weak var menuButton: UIButton! {
		didSet {
			// SWRevealViewController built-in toggle action for rear and front viewControllers
			menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
		}
	}
	@IBOutlet weak var messageBox: UITextField!
	@IBOutlet weak var sendButton: UIButton! {
		didSet {
			sendButton.layer.cornerRadius = sendButton.frame.width / 2
			sendButton.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var messageTable: UITableView! {
		didSet {
			messageTable.dataSource = self
			messageTable.delegate = self
			messageTable.estimatedRowHeight = 80
			messageTable.rowHeight = UITableViewAutomaticDimension
		}
	}
	@IBOutlet weak var userTypingIndication: UILabel!
	
	// variables
	var isTyping = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// SWRevealViewController built-in slide back(pan) and tap back gestures
		self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		// listen to the Notification userDatDidChange
		NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NotificationName.userDataDidChange, object: nil)
		// listen to the Notification channelDidSelect
		NotificationCenter.default.addObserver(self, selector: #selector(channelDidSelect(_:)), name: NotificationName.channelDidSelect, object: nil)
		
		// listen to the SocketService.on for real time message callback
		SocketService.instance.getMessage { (newMessage) in
			if newMessage.channelId == MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
				MessageService.instance.messages.append(newMessage)
				self.messageTable.reloadData()
				// scroll down table to the bottom if many messages
				if MessageService.instance.messages.count > 0 {
					let endIndexPath = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
					self.messageTable.scrollToRow(at: endIndexPath, at: .bottom, animated: true)
				}
			}
		}
		// listen to the SocketService.on for real time typing users callback
		SocketService.instance.getOtherTypingUsers { (typingUsers) in
			guard let channelId = MessageService.instance.selectedChannel?._id else { return }
			var names = ""
			var numberOfTypers = 0
			for (typingUser, typingUserChannelId) in typingUsers {
				// neglect current user while typing
				if typingUser != UserDataService.instance.name && typingUserChannelId == channelId {
					if names == "" {
						names = typingUser
					} else {
						names += ", \(typingUser)"
					}
					numberOfTypers += 1
				}
			}
			if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
				var verb = "is"
				if numberOfTypers > 1 {
					verb = "are"
				}
				self.userTypingIndication.text = "\(names) \(verb) typing..."
			} else {
				self.userTypingIndication.text = ""
			}
		}
		
		// check previous user logged in or not
		if AuthService.instance.isLoggedIn {
			AuthService.instance.findUserByEmail(completion: { (success) in
				if success { print("previous user logged in!"); print("populating user data...")
					NotificationCenter.default.post(name: NotificationName.userDataDidChange, object: nil)
				}
			})
		}
		
		// bind keyboard for typing user experience and tap to dismiss
		view.bindToKeyboard()
		let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
		view.addGestureRecognizer(tap)
		
		// default to hide sendButton
		sendButton.isHidden = true
	}
	
	// helper functions
	private func updateWithSelectedChannel() {
		print("updating channel...")
		channelLabel.text = "#\(MessageService.instance.selectedChannel?.name ?? "")"
		getMessages()
	}

	private func onLoginGetMessages() {
		MessageService.instance.findAllChannels { (success) in
			if success { print("loading all channels...")
				if MessageService.instance.channels.count > 0 { // if have channels, set selected channel to first one
					MessageService.instance.selectedChannel = MessageService.instance.channels.first
					self.updateWithSelectedChannel()
				} else {
					self.channelLabel.text = "No Channel Yet"
				}
			}
		}
	}
	
	private func getMessages() {
		guard let channelId = MessageService.instance.selectedChannel?._id else { return }
		MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
			if success { print("loading all messages...")
				self.messageTable.reloadData()
			}
		}
	}
	
	// selector functions
	@objc func userDataDidChange(_ notification: Notification) {
		if AuthService.instance.isLoggedIn {
			onLoginGetMessages() // get channels
		} else {
			channelLabel.text = "Please Log In"
			messageTable.reloadData()
		}
	}
	
	@objc func channelDidSelect(_ notification: Notification) { updateWithSelectedChannel() }
	@objc func closeKeyboard() { view.endEditing(true) }
	
	// target actions
	@IBAction func send(_ sender: UIButton) {
		if AuthService.instance.isLoggedIn {
			// get message, userId and channelId for sending
			guard let message = messageBox.text else { return }
			guard let channelId = MessageService.instance.selectedChannel?._id else { return }
			let userId = UserDataService.instance._id
			
			// emit newMessage to SocketService
			SocketService.instance.addMessage(messageBody: message, userId: userId, channelId: channelId, completion: { (success) in
				if success { print("sending new message...")
					self.messageBox.text = ""
					self.messageBox.resignFirstResponder()
					self.sendButton.isHidden = true
					self.isTyping = false
					// emit stopType
					SocketService.instance.socket?.emit("stopType", UserDataService.instance.name, channelId)
				}
			})
		}
	}
	
	@IBAction func messageBoxEditing(_ sender: UITextField) {
		
		guard let channelId = MessageService.instance.selectedChannel?._id else { return }
		
		// hide and show sendButton
		if messageBox.text == "" {
			isTyping = false
			sendButton.isHidden = true
			// emit stopType
			SocketService.instance.socket?.emit("stopType", UserDataService.instance.name, channelId)
		} else {
			if isTyping == false {
				sendButton.isHidden = false
				// emit startType
				SocketService.instance.socket?.emit("startType", UserDataService.instance.name, channelId)
			}
			isTyping = true
		}
	}
}

extension ChatVC: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int { return 1 }
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.messages.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
		cell.message = MessageService.instance.messages[indexPath.row]
		return cell
	}
}
