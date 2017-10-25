//
//  AvatarPickerVC.swift
//  Murmur
//
//  Created by Chris Huang on 25/10/2017.
//  Copyright © 2017 Chris Huang. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {

	// outlets
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var avatarCollection: UICollectionView! {
		didSet {
			avatarCollection.dataSource = self
			avatarCollection.delegate = self
		}
	}
	
	// target actions
	@IBAction func back(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
	
	@IBAction func themeChanged(_ sender: UISegmentedControl) {
	}
}

extension AvatarPickerVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 28 }
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AvatarCell
		return cell
	}
}
