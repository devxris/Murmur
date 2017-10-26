//
//  Channel.swift
//  Murmur
//
//  Created by Chris Huang on 26/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import Foundation

struct Channel: Decodable {
	public private(set) var _id: String
	public private(set) var name: String
	public private(set) var description: String
	public private(set) var __v: Int?
}
