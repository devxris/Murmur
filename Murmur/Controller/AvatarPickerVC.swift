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
	
	// variables
	var avatarType: AvatarType = .dark
	
	// target actions
	@IBAction func back(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
	
	@IBAction func themeChanged(_ sender: UISegmentedControl) {
		avatarType = segmentedControl.selectedSegmentIndex == 0 ? .dark : .light
		avatarCollection.reloadData()
	}
}

extension AvatarPickerVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 28 }
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AvatarCell
		cell.configure(index: indexPath.item, type: avatarType)
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let numOfColumns: CGFloat = UIScreen.main.bounds.width > 320 ? 4 : 3
		let spaceBetweenCells: CGFloat = 10
		let padding: CGFloat = 20 * 2 // left and right insets
		let cellSize = (avatarCollection.bounds.width - padding - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
		
		return CGSize(width: cellSize, height: cellSize)
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		UserDataService.instance.setAvatarName("\(avatarType == .dark ? "dark" : "light")\(indexPath.item)")
		self.dismiss(animated: true, completion: nil)
	}
}
