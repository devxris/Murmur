//
//  MessageService.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
	
	static let instance = MessageService()
	
	var channels = [Channel]()
	
	func findAllChannels(completion: @escaping CompletionHandler) {
		
		// create get channels web request
		Alamofire.request(URLs.getChannels, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Header.bearer).responseJSON { (response) in
			if response.result.error == nil {
				guard let data = response.data else { return }
				
				// parse data with Decodable object
				do {
					self.channels = try JSONDecoder().decode([Channel].self, from: data)
				} catch let error { print(error.localizedDescription) }
				print("\(self.channels.count) channels found...")
				completion(true)
				
				/* parse data with SwiftyJSON
				if let json = JSON(data: data).array {
					for item in json {
						let name = item["name"].stringValue
						let desc = item["description"].stringValue
						let id = item["_id"].stringValue
						let channel = Channel(_id: id, name: name, description: desc)
						self.channels.append(channel)
					}
					completion(true) }
				*/
			} else {
				completion(false); debugPrint(response.result.error as Any)
			}
		}
	}
}
