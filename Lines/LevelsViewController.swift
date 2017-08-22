//
//  LevelsCollectionViewController.swift
//  Lines
//
//  Created by Fraser King on 2017-08-07.
//  Copyright © 2017 Fraser King. All rights reserved.
//

import UIKit
import Hero

private let reuseIdentifier = "Cell"

class LevelsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedIndex = 0
    var currentLevel: Int {
        get {
            return UserDefaultsInteractor.getCurrentLevel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient(landing: false, luminosity: .bright)
        if isIpad() {
            collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        } else {
            collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: UICollectionViewScrollPosition.centeredVertically, animated: false)
    }
    
    @IBAction func backPressed(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sharePressed(sender: UIButton) {
        let text = "I've made it to level \(currentLevel+1) on Kobon. Think you can make more tiangles than me? Get it on the App store today!"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showNewGame") {
            let vc = segue.destination as! GameViewController
            vc.levelNumber = selectedIndex
            vc.delegate = self
        }
    }
}

extension LevelsViewController: UICollectionViewDataSource  {

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Levels.levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LevelCollectionViewCell
    
        guard let numberOfTriangles = Levels.levels[indexPath.row].numberOfTrianglesRequired else {
            return cell
        }
        
        guard let numberOfLines = Levels.levels[indexPath.row].numberOfLinesProvided else {
            return cell
        }
        
        let triangleText: String = numberOfTriangles == 1 ? "triangle" : "triangles"
        let lineText: String = numberOfLines == 1 ? "line" : "lines"
        
        if indexPath.row > currentLevel {
            cell.beginImageView.image = UIImage(named: "lock")
            cell.blurOverlay.isHidden = false
            cell.title2.text = "Unlock to view description"
        } else {
            if indexPath.row == currentLevel {
                cell.beginImageView.image = UIImage(named: "start")
            } else {
                cell.beginImageView.image = UIImage(named: "checkmark")
            }
            cell.blurOverlay.isHidden = true
            cell.title2.text = "Create \(String(describing: Levels.levels[indexPath.row].numberOfTrianglesRequired!)) \(triangleText) from \(String(describing: Levels.levels[indexPath.row].numberOfLinesProvided!)) \(lineText)"
        }
        
        cell.image.image = UIImage(named: "level\(indexPath.row+1)")
        cell.title1.text = "Level \(indexPath.row+1)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            headerView.backgroundColor = UIColor.clear
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension LevelsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row > currentLevel {
            return false
        }
        
        return true
    }
 
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isIpad() {
            return CGSize(width: 415, height: 550)
        } else {
            return CGSize(width: 280, height: 375)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showNewGame", sender: self)
    }
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
