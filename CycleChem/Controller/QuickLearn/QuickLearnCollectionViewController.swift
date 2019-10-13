//
//  QuickLearnCollectionViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit



class QuickLearnCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var moleculeList = MoleculeBank().list.sorted(by: { $0.moleculeName < $1.moleculeName} )
    var nameIsShown = true
    var imageIsShown = true
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moleculeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuickLearnCollectionViewCell

        cell.moleculeImage.image = moleculeList[indexPath.item].image
        cell.nameLabel.text = moleculeList[indexPath.item].moleculeName
        
        cell.layer.cornerRadius = 35
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 6
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        if imageIsShown == false {
            cell.moleculeImage.isHidden = true
        } else {
            cell.moleculeImage.isHidden = false
        }
        
        if nameIsShown == false {
            cell.nameLabel.isHidden = true
        } else {
            cell.nameLabel.isHidden = false
        }

        return cell
    }
    

    @IBOutlet weak var learningTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var moleculeCollectionView: UICollectionView!
    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        moleculeCollectionView.delegate = self
        moleculeCollectionView.dataSource = self
        moleculeCollectionView.layoutIfNeeded()
        moleculeCollectionView.scrollToItem(at: IndexPath.init(item: Int(round(Double(moleculeList.count/2))), section: 0), at: .centeredHorizontally, animated: false)
        

        
        
        moleculeCollectionView.decelerationRate = .fast
        
        let moleculeCollectionViewLayout = self.moleculeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidth = moleculeCollectionViewLayout.itemSize.width
        let cellWidth = self.view.frame.width * 0.73
        let frameWidth = self.view.frame.width
        moleculeCollectionViewLayout.sectionInset.right = (frameWidth-cellWidth)/2

        resetDisplay()
        
        
    }
    
    
    
    @IBAction func revealButtonTapped(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        if learningTypeSegmentedControl.selectedSegmentIndex == 1 {
            nameIsShown = true
        } else if learningTypeSegmentedControl.selectedSegmentIndex == 2 {
            imageIsShown = true
        }
        moleculeCollectionView.reloadData()
    }
    
    @IBAction func didChangeLearningType(_ sender: UISegmentedControl) {
        resetDisplay()
    }
    
    
    func resetDisplay() {
        if learningTypeSegmentedControl.selectedSegmentIndex == 1 {
            revealButton.isHidden = false
            revealButton.setTitle("REVEAL NAME", for: .normal)
            nameIsShown = false
            imageIsShown = true
        } else if learningTypeSegmentedControl.selectedSegmentIndex == 2 {
            revealButton.isHidden = false
            revealButton.setTitle("REVEAL MOLECULE", for: .normal)
            nameIsShown = true
            imageIsShown = false
        } else {
            revealButton.isHidden = true
            nameIsShown = true
            imageIsShown = true
        }
        moleculeCollectionView.reloadData()
        
    }
    
 
    
    
}

extension QuickLearnCollectionViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.moleculeCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize.width = self.view.frame.width * 0.73
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        //        let cellWidthIncludingSpacing = layout.itemSize.width
        var offset = targetContentOffset.pointee
        
        let cellWidth = layout.itemSize.width
        let frameWidth = self.view.frame.width
        let leftInset = (frameWidth-cellWidth)/2
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        scrollView.contentInset.left = leftInset
 
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
        resetDisplay()
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        let layout = self.moleculeCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
////        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        let cellWidth = layout.itemSize.width
//        let frameWidth = self.view.frame.width
//        let leftInset = (frameWidth-cellWidth)/2
//        let rightInset = leftInset
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//
//    }

   

}

extension QuickLearnCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 40
        let width  = collectionView.frame.width * 0.73
        return CGSize(width: width, height: height)
    }
    

   
}



