//
//  FullListViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 10/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FullListViewController: UIViewController {
    
    @IBOutlet weak var moleculeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var moleculeList = MoleculeBank().list
    
    var filteredMolecules = [Molecule]()
    var searching = false
    
     let filterLauncher = FilterLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moleculeList = MoleculeBank().list.sorted(by: { $0.moleculeName < $1.moleculeName} )
        
        
        moleculeTableView.delegate = self
        moleculeTableView.dataSource = self
        searchBar.delegate = self
        self.moleculeTableView.rowHeight = 110
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        filterLauncher.filterDelegate = self
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
            filterLauncher.showFilteringOptions()
            searchBar.resignFirstResponder()
    }
}
extension FullListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredMolecules.count
        } else {
            return moleculeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FullListTableViewCell
        
        
        
        if searching {
            
            cell.cellImage.image = filteredMolecules[indexPath.row].image
            cell.cellLabel.text = filteredMolecules[indexPath.row].moleculeName
        } else {
            cell.cellImage.image = moleculeList[indexPath.row].image
            cell.cellLabel.text = moleculeList[indexPath.row].moleculeName
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension FullListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        var moleculesNames = [String]()
        for molecules in moleculeList {
           moleculesNames.append(molecules.moleculeName)
        }
        
        filteredMolecules = moleculeList.filter { molecule in

            let isMatchingSearchText = molecule.moleculeName.lowercased().contains(searchText.lowercased()) || searchText.lowercased().count == 0
            return isMatchingSearchText
        }
        
        searching = true
        moleculeTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        moleculeTableView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FullListViewController: FilterDelegate {
    func didFilter() {
        moleculeList = filterLauncher.filter()
        moleculeTableView.reloadData()
    }
}

