//
//  FullListViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 10/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit

class FullListViewController: UIViewController {
    
    private let searchBar : UISearchBar = {
        let bar = UISearchBar()
        
        return bar
    }()
    
    private let moleculeTableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.mainColor
        tableView.contentOffset.y = -50
        return tableView
    }()
    
    
    var moleculeList = MoleculeBank().list
    
    var filteredMolecules = [Molecule]()
    var searching = false
    
     let filterLauncher = FilterLauncher()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        moleculeList = MoleculeBank().list.sorted(by: { $0.name < $1.name} )
        
        
        moleculeTableView.delegate = self
        moleculeTableView.dataSource = self
        moleculeTableView.register(FullListCell.self,
                                   forCellReuseIdentifier: FullListCell.reuseID)
        searchBar.delegate = self
        self.moleculeTableView.rowHeight = 110
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = Colors.blueLearning
        filterLauncher.filterDelegate = self
    }
    

    
    private func setupUI() {
        view.backgroundColor = Colors.mainColor
        view.addSubview(searchBar)
        view.addSubview(moleculeTableView)
        addConstraints()
    }
    
    private func addConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        moleculeTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
            filterLauncher.showFilteringOptions()
            searchBar.resignFirstResponder()
    }
}
extension FullListViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searching {
//            return filteredMolecules.count
//        } else {
//            return moleculeList.count
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FullListCell.reuseID,
                                                 for: indexPath) as! FullListCell
        let molecule = searching ? filteredMolecules[indexPath.section] : moleculeList[indexPath.section]
        cell.configure(with: molecule)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.mainColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searching ? filteredMolecules.count : moleculeList.count
    }
}

extension FullListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        var moleculesNames = [String]()
        for molecules in moleculeList {
           moleculesNames.append(molecules.name)
        }
        
        filteredMolecules = moleculeList.filter { molecule in

            let isMatchingSearchText = molecule.name.lowercased().contains(searchText.lowercased()) || searchText.lowercased().count == 0
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

