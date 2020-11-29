//
//  QuickLearnViewController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 06/03/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift
import ReactiveCocoa

class QuickLearnViewController: UIViewController {
    
    var moleculeList = MoleculeBank().list.sorted(by: { $0.name < $1.name} )
    
    var nameIsShown = true
    var imageIsShown = true
    
    private let moleculeCollectionView : UICollectionView = {
        let layout = CCFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
//        cv.backgroundColor = .systemBackground
        cv.backgroundColor = Colors.mainColor
        cv.decelerationRate = .fast
        return cv
    }()
    
    private let revealButton : UIButton = {
        let button = UIButton()
//        button.backgroundColor = Colors.purple
        button.setTitle("REVEAL", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        return button
    }()
    
    private let learningTypeControl : UISegmentedControl = {
        let items = [LearningType.showAll.description,
                     LearningType.hideName.description,
                     LearningType.hideMolecule.description]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = Colors.blueLearning
        return control
    }()
    
    private let viewModel : QuickLearnViewModel
    
    init(viewModel: QuickLearnViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.revealButton.addSoftUIEffectForButton(cornerRadius: 10, themeColor: Colors.mainColor)
        self.learningTypeControl.addSoftUIEffectForView()
    }
    
    private func bindViewModel() {
        learningTypeControl.reactive.controlEvents(.valueChanged)
            .map { return $0.selectedSegmentIndex }
            .observeValues { index in
                if index == 0 {
                    self.viewModel.learningType.value = .showAll
                } else if index == 1 {
                    self.viewModel.learningType.value = .hideName
                } else {
                    self.viewModel.learningType.value = .hideMolecule
                }
        }
        
        self.viewModel.learningType.producer.observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .startWithValues { [weak self] learningType in
                guard let self = self else { return }
                self.resetDisplay(learningType)
        }
        
        revealButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
            self.generator.notificationOccurred(.success)
            let center = self.view.convert(self.moleculeCollectionView.center,
                                           to: self.moleculeCollectionView)
            let indexPath = self.moleculeCollectionView.indexPathForItem(at: center)
            guard let selectedIndexPath = indexPath else { return }
            let selectedCell = self.moleculeCollectionView.cellForItem(at: selectedIndexPath) as? QuickLearnCVCell
            selectedCell?.revealEverything()
        }
    }
    
    private func setupCollectionView() {
        moleculeCollectionView.delegate = self
        moleculeCollectionView.dataSource = self
        moleculeCollectionView.register(QuickLearnCVCell.self,
                                        forCellWithReuseIdentifier: QuickLearnCVCell.reuseID)
        moleculeCollectionView.layoutIfNeeded()
        let initialIndexPath = IndexPath.init(item: 0, section: 0)
        moleculeCollectionView.scrollToItem(at: initialIndexPath,
                                        at: .centeredHorizontally,
                                        animated: false)
    }
    
    private func setupUI() {
//        self.view.backgroundColor = .systemBackground
        self.view.backgroundColor = Colors.mainColor
        self.view.addSubview(revealButton)
        self.view.addSubview(learningTypeControl)
        self.view.addSubview(moleculeCollectionView)
        addConstraints()
    }
    
    private func addConstraints() {
        revealButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.bottom.equalToSuperview().offset(-120)
        }
        
        learningTypeControl.snp.makeConstraints { make in
//            make.height.equalTo(31)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        moleculeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(learningTypeControl.snp.bottom).offset(40)
            make.bottom.equalTo(revealButton.snp.top).offset(-40)
        }
        
    }
    
    func resetDisplay(_ learningType: LearningType) {
        revealButton.isHidden = learningType.hideRevealButton
        revealButton.setTitle(learningType.revealButtonTitle, for: .normal)
        moleculeCollectionView.reloadData()
    }
}

extension QuickLearnViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moleculeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickLearnCVCell.reuseID,
                                                      for: indexPath) as! QuickLearnCVCell

        let molecule =  moleculeList[indexPath.item]
        cell.configureCell(with: molecule, and: self.viewModel.learningType.value)
        
        return cell
    }
}

extension QuickLearnViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height * 0.80
        let width  = collectionView.frame.width * 0.70
        return CGSize(width: width, height: height)
    }
}



