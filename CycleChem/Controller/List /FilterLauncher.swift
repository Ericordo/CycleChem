//
//  FilterLauncher.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 01/05/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

//class FilterOption: NSObject {
//    let name: String
//    let imageName: String
//
//    init(name: String, imageName: String) {
//        self.name = name
//        self.imageName = imageName
//    }
//}

class FilterOption: NSObject {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct SectionData {
    var name: String
    var filterOptions : [FilterOption]
}

struct FilterCriteria {
    var ringSize3 = false
    var ringSize4 = false
    var ringSize5 = false
    var ringSize6 = false
    var ringSize0 = false
    var hasOxygen = false
    var hasNitrogen = false
    var hasSulfur = false
    var isSaturated = false
    var isUnsaturated = false
}

class FilterLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var finalFilterResults : [Molecule] = [] 
    
    let darkView = UIView()
    var rowHeight: CGFloat = 44
    let rowHeightSmallScreen : CGFloat = 32
    var headerHeight : CGFloat = 30
    let headerHeightSmallScreen : CGFloat = 25
    
    
    
    var filterCriteria = FilterCriteria()
    var criteriaCount = 0
    
    var filterDelegate : FilterDelegate!
    
//    let filterOptions: [FilterOption] = {
//        return [FilterOption(name: "Remove all filters", imageName: "nil"), FilterOption(name: "1 ring - 3 atoms", imageName: "threeatoms"), FilterOption(name: "1 ring - 4 atoms", imageName: "fouratoms"), FilterOption(name: "1 ring - 5 atoms", imageName: "fiveatoms"), FilterOption(name: "1 ring - 6 atoms", imageName: "sixatoms"), FilterOption(name: "1 ring - 7 atoms", imageName: "sevenatoms"), FilterOption(name: "2 rings", imageName: "twocycles"), FilterOption(name: "Oxygen", imageName: "oxygen"), FilterOption(name: "Nitrogen", imageName: "nitrogen"), FilterOption(name: "Sulfur", imageName: "sulfur"), FilterOption(name: "Saturated rings", imageName: "saturated"), FilterOption(name: "Unsaturated rings", imageName: "unsaturated")]
//    }()
    
//    let filterOptions: [FilterOption] = {
//        return [FilterOption(name: "Remove all filters"), FilterOption(name: "1 ring - 3 atoms"), FilterOption(name: "1 ring - 4 atoms"), FilterOption(name: "1 ring - 5 atoms"), FilterOption(name: "1 ring - 6 atoms"), FilterOption(name: "2 rings"), FilterOption(name: "Oxygen"), FilterOption(name: "Nitrogen"), FilterOption(name: "Sulfur"), FilterOption(name: "Saturated rings"), FilterOption(name: "Unsaturated rings")]
//    }()
    
    let headers = ["", "Heterocycle Size", "Heteroatoms", "Saturation"]
    
    let filterLauncherData : [SectionData] = {
        return [SectionData(name: "", filterOptions: [FilterOption(name: "Remove all filters")]), SectionData(name: "Heterocycle Size", filterOptions: [FilterOption(name: "1 ring - 3 atoms"), FilterOption(name: "1 ring - 4 atoms"), FilterOption(name: "1 ring - 5 atoms"), FilterOption(name: "1 ring - 6 atoms"), FilterOption(name: "2 rings")]), SectionData(name: "Heteroatoms", filterOptions: [FilterOption(name: "Oxygen"), FilterOption(name: "Nitrogen"), FilterOption(name: "Sulfur")]), SectionData(name: "Saturation", filterOptions: [FilterOption(name: "Saturated rings"), FilterOption(name: "Unsaturated rings")])]
    }()
    
    let choicesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.allowsMultipleSelection = true
        return cv
        
    }()
    
//    let choicesCollectionViewHeight : CGFloat = 605
    let choicesCollectionViewHeight : CGFloat = 610
    
    let choicesCollectionViewHeightSmallScreen : CGFloat = 430
    
    
    
    
    func showFilteringOptions() {
        if let view = UIApplication.shared.keyWindow {
            darkView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            view.addSubview(darkView)
            view.addSubview(choicesCollectionView)
            
            
            
            let yChoicesCollectionView = view.frame.height - choicesCollectionViewHeight
            let yChoicesCollectionViewSmallScreen = view.frame.height - choicesCollectionViewHeightSmallScreen
            
            if view.frame.height > 700 {
            choicesCollectionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width
                , height: choicesCollectionViewHeight)
            } else {
                choicesCollectionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width
                    , height: choicesCollectionViewHeightSmallScreen)
            }
            
            
            darkView.frame = view.frame
            darkView.alpha = 0
            
            darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.darkView.alpha = 1
                
                if view.frame.height > 700 {
                self.choicesCollectionView.frame = CGRect(x: 0, y: yChoicesCollectionView, width: view.frame.width, height: self.choicesCollectionViewHeight)
                } else {
                    self.choicesCollectionView.frame = CGRect(x: 0, y: yChoicesCollectionViewSmallScreen, width: view.frame.width, height: self.choicesCollectionViewHeightSmallScreen)
                }
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations:  {
            self.darkView.alpha = 0
            if let view = UIApplication.shared.keyWindow {
                
                if view.frame.height > 700 {
                
                self.choicesCollectionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width
                    , height: self.choicesCollectionViewHeight)
                } else {
                    self.choicesCollectionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width
                        , height: self.choicesCollectionViewHeightSmallScreen)
                }
            }
        })
        filterDelegate.didFilter()
    }
    
    func filter() -> [Molecule] {
        let originalList = MoleculeBank().list.sorted(by: { $0.name < $1.name} )
        var filterResultsRingSize3 : [Molecule] = []
        var filterResultsRingSize4 : [Molecule] = []
        var filterResultsRingSize5 : [Molecule] = []
        var filterResultsRingSize6 : [Molecule] = []
        var filterResultsRingSize0 : [Molecule] = []
        var filterResultsOxygen : [Molecule] = []
        var filterResultsNitrogen : [Molecule] = []
        var filterResultsSulfur : [Molecule] = []
        var filterResultsSaturated : [Molecule] = []
        var filterResultsUnsaturated : [Molecule] = []
        finalFilterResults.removeAll()
        if filterCriteria.ringSize3 == true {
            filterResultsRingSize3 = originalList.filter({$0.ringSize == 3})
            }
        if filterCriteria.ringSize4 == true {
            filterResultsRingSize4 = originalList.filter({$0.ringSize == 4})
        }
        if filterCriteria.ringSize5 == true {
            filterResultsRingSize5 = originalList.filter({$0.ringSize == 5})
        }
        if filterCriteria.ringSize6 == true {
            filterResultsRingSize6 = originalList.filter({$0.ringSize == 6})
        }
        if filterCriteria.ringSize0 == true {
            filterResultsRingSize0 = originalList.filter({$0.ringSize == 0})
        }
        if filterCriteria.hasOxygen == true {
            filterResultsOxygen = originalList.filter({$0.hasOxygen == true})
        }
        if filterCriteria.hasNitrogen == true {
            filterResultsNitrogen = originalList.filter({$0.hasNitrogen == true})
        }
        if filterCriteria.hasSulfur == true {
            filterResultsSulfur = originalList.filter({$0.hasSulfur == true})
        }
        if filterCriteria.isSaturated == true {
            filterResultsSaturated = originalList.filter({$0.isSaturated == true})
        }
        if filterCriteria.isUnsaturated == true {
            filterResultsUnsaturated = originalList.filter({$0.isSaturated == false})
        }
        
        
        
        
        let rawFilterResults = filterResultsRingSize3 + filterResultsRingSize4 + filterResultsRingSize5 + filterResultsRingSize6 + filterResultsRingSize0 + filterResultsOxygen + filterResultsNitrogen + filterResultsSulfur + filterResultsSaturated + filterResultsUnsaturated
        
        var counts : [String : Int] = [:]
        rawFilterResults.forEach { counts[$0.name, default: 0] += 1 }
        print(counts)
        var finalFilterResultsString : [String] = []
        
        for (key, value) in counts {
            if value == criteriaCount {
                finalFilterResultsString.append(key)
            }
        }
        for molecule in originalList {
            for name in finalFilterResultsString {
                if molecule.name == name {
                    if !finalFilterResults.contains(where: {$0.name == name}) {
                    finalFilterResults.append(molecule)
                    }
                }
            }
        }
        finalFilterResults = finalFilterResults.sorted(by: { $0.name < $1.name} )
        if criteriaCount == 0 {
            return originalList
        } else {
        return finalFilterResults
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterLauncherData[section].filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        let filterOption = filterLauncherData[indexPath.section].filterOptions[indexPath.item]
        cell.filterOption = filterOption
        if indexPath == [0,0] {
            cell.iconImageView.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let view = UIApplication.shared.keyWindow {
            if view.frame.height < 700 {
                rowHeight = rowHeightSmallScreen
            }
        }
        return CGSize(width: collectionView.frame.width, height: rowHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == [0,0] {
        collectionView.deselectAllItems(animated: true)
            filterCriteria.ringSize3 = false
            filterCriteria.ringSize4 = false
            filterCriteria.ringSize5 = false
            filterCriteria.ringSize6 = false
            filterCriteria.ringSize0 = false
            filterCriteria.hasOxygen = false
            filterCriteria.hasNitrogen = false
            filterCriteria.hasSulfur = false
            filterCriteria.isSaturated = false
            filterCriteria.isUnsaturated = false
            criteriaCount = 0
        }
        switch indexPath {
        case [1,0]:
            filterCriteria.ringSize3 = true
            criteriaCount += 1
            if filterCriteria.ringSize4 == true {
                collectionView.deselectItem(at: [1,1], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize4 = false
            }
            if filterCriteria.ringSize5 == true {
                collectionView.deselectItem(at: [1,2], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize5 = false
            }
            if filterCriteria.ringSize6 == true {
                collectionView.deselectItem(at: [1,3], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize6 = false
            }
            if filterCriteria.ringSize0 == true {
                collectionView.deselectItem(at: [1,4], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize0 = false
            }
        case [1,1]:
            filterCriteria.ringSize4 = true
            criteriaCount += 1
            if filterCriteria.ringSize3 == true {
                collectionView.deselectItem(at: [1,0], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize3 = false
            }
            if filterCriteria.ringSize5 == true {
                collectionView.deselectItem(at: [1,2], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize5 = false
            }
            if filterCriteria.ringSize6 == true {
                collectionView.deselectItem(at: [1,3], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize6 = false
            }
            if filterCriteria.ringSize0 == true {
                collectionView.deselectItem(at: [1,4], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize0 = false
            }
        case [1,2]:
            filterCriteria.ringSize5 = true
            criteriaCount += 1
            if filterCriteria.ringSize4 == true {
                collectionView.deselectItem(at: [1,1], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize4 = false
            }
            if filterCriteria.ringSize3 == true {
                collectionView.deselectItem(at: [1,0], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize3 = false
            }
            if filterCriteria.ringSize6 == true {
                collectionView.deselectItem(at: [1,3], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize6 = false
            }
            if filterCriteria.ringSize0 == true {
                collectionView.deselectItem(at: [1,4], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize0 = false
            }
        case [1,3]:
            filterCriteria.ringSize6 = true
            criteriaCount += 1
            if filterCriteria.ringSize4 == true {
                collectionView.deselectItem(at: [1,1], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize4 = false
            }
            if filterCriteria.ringSize5 == true {
                collectionView.deselectItem(at: [1,2], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize5 = false
            }
            if filterCriteria.ringSize3 == true {
                collectionView.deselectItem(at: [1,0], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize3 = false
            }
            if filterCriteria.ringSize0 == true {
                collectionView.deselectItem(at: [1,4], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize0 = false
            }
        case [1,4]:
            filterCriteria.ringSize0 = true
            criteriaCount += 1
            if filterCriteria.ringSize4 == true {
                collectionView.deselectItem(at: [1,1], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize4 = false
            }
            if filterCriteria.ringSize5 == true {
                collectionView.deselectItem(at: [1,2], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize5 = false
            }
            if filterCriteria.ringSize6 == true {
                collectionView.deselectItem(at: [1,3], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize6 = false
            }
            if filterCriteria.ringSize3 == true {
                collectionView.deselectItem(at: [1,0], animated: true)
                criteriaCount -= 1
                filterCriteria.ringSize3 = false
            }
        case [2,0]:
            filterCriteria.hasOxygen = true
            criteriaCount += 1
        case [2,1]:
            filterCriteria.hasNitrogen = true
            criteriaCount += 1
        case [2,2]:
          filterCriteria.hasSulfur = true
            criteriaCount += 1
        case [3,0]:
            filterCriteria.isSaturated = true
            if filterCriteria.isUnsaturated == true {
                collectionView.deselectItem(at: [3,1], animated: true)
                criteriaCount -= 1
                filterCriteria.isUnsaturated = false
            }
            criteriaCount += 1
        case [3,1]:
          filterCriteria.isUnsaturated = true
          if filterCriteria.isSaturated == true {
            collectionView.deselectItem(at: [3,0], animated: true)
            criteriaCount -= 1
            filterCriteria.isSaturated = false
          }
            criteriaCount += 1
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch indexPath {
        case [1,0]:
            filterCriteria.ringSize3 = false
            criteriaCount -= 1
        case [1,1]:
            filterCriteria.ringSize4 = false
            criteriaCount -= 1
        case [1,2]:
            filterCriteria.ringSize5 = false
            criteriaCount -= 1
        case [1,3]:
            filterCriteria.ringSize6 = false
            criteriaCount -= 1
        case [1,4]:
            filterCriteria.ringSize0 = false
            criteriaCount -= 1
        case [2,0]:
            filterCriteria.hasOxygen = false
            criteriaCount -= 1
        case [2,1]:
            filterCriteria.hasNitrogen = false
            criteriaCount -= 1
        case [2,2]:
            filterCriteria.hasSulfur = false
            criteriaCount -= 1
        case [3,0]:
            filterCriteria.isSaturated = false
            criteriaCount -= 1
        case [3,1]:
            filterCriteria.isUnsaturated = false
            criteriaCount -= 1
        default:
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filterLauncherData.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let view = UIApplication.shared.keyWindow {
            if view.frame.height < 700 {
                headerHeight = headerHeightSmallScreen
            }
        }
        
        if section == 0 {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.frame.width, height: headerHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = choicesCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! HeaderView
        
            header.headerLabel.text = headers[indexPath.section]
        
        return header
    }
    
    override init() {
        super.init()
        choicesCollectionView.delegate = self
        choicesCollectionView.dataSource = self
        choicesCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: "FilterCell")
        choicesCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
}

extension UICollectionView {
    
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}

protocol FilterDelegate {
    func didFilter()
}
