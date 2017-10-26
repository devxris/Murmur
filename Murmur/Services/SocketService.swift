//
//  SocketService.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
	
	override init() { super.init() } // for NSObject super.init
	
	static let instance = SocketService()

	// app send message to server API and "socket.emit" to all plateform
	// app listen "socket.on" to receive message from server API
	lazy var socket: SocketIOClient? = {
		guard let baseURL = URL(string: URLs.base) else { return nil }
		return SocketIOClient(socketURL: baseURL)
	}()
	
	// also initiate connection in AppDelegate applicationDidBecomeActive(_ application: UIApplication)
	func establishConnection() { socket?.connect() }
	func closeConnection() { socket?.disconnect() }
	
	func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
		socket?.emit("newChannel", name, description) // items must be in order
		completion(true)
	}
	
	func getChannels(completion: @escaping CompletionHandler) {
		socket?.on("channelCreated", callback: { (dataArray, acknowledge) in
			guard let channelName = dataArray[0] as? String else { return }
			guard let channelDesc = dataArray[1] as? String else { return }
			guard let channelId = dataArray[2] as? String else { return }
			let channel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: nil)
			MessageService.instance.channels.append(channel)
			completion(true)
		})
	}
}
