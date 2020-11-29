//
//  CCTabBarController.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 14/11/2020.
//  Copyright © 2020 Eric Ordonneau. All rights reserved.
//

import UIKit

class CCTabBarController: NeumorphismTabBarController {
    
    override var tabHorizontalMargin: CGFloat {
        get {
            return 20
        }
    }

    /// Override it if you want to adjust tab margin of bottom
    override var tabVerticalMargin: CGFloat {
        get {
            return 30
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = .systemTeal
//        viewControllers = [createQuickLearnViewController(),
//                           createGamesViewController(),
//                           createListViewController()]
//        view.backgroundColor = Colors.mainColor
//        let quickLearn = NeumorphismTabBarItem(icon: Images.quickLearn, title: AppStrings.quickLearn)
//        let games = NeumorphismTabBarItem(icon: Images.games, title: AppStrings.games)
//        let list = NeumorphismTabBarItem(icon: Images.list, title: AppStrings.list)
//        setTabBar(items: [quickLearn, games, list])
//        self.selectedColor = .systemTeal
    }
    
    override func setupView() {
        UITabBar.appearance().tintColor = .systemTeal
        viewControllers = [createQuickLearnViewController(),
                           createGamesViewController(),
                           createListViewController()]
        view.backgroundColor = Colors.mainColor
        let quickLearn = NeumorphismTabBarItem(icon: Images.quickLearn, title: AppStrings.quickLearn)
        let games = NeumorphismTabBarItem(icon: Images.games, title: AppStrings.games)
        let list = NeumorphismTabBarItem(icon: Images.list, title: AppStrings.list)
        setTabBar(items: [quickLearn, games, list])
        self.selectedColor = .systemTeal
    }

    func createQuickLearnViewController() -> UIViewController {
        let quickLearnVC = QuickLearnViewController(viewModel: QuickLearnViewModel())
        quickLearnVC.title = AppStrings.quickLearn
        quickLearnVC.tabBarItem = UITabBarItem(title: AppStrings.quickLearn, image: Images.quickLearn, tag: 0)
        return quickLearnVC
    }
    
    func createGamesViewController() -> UINavigationController {
        let gamesVC = GamesViewController()
        let navGamesVC = UINavigationController(rootViewController: gamesVC)
        navGamesVC.title = AppStrings.games
        navGamesVC.tabBarItem = UITabBarItem(title: AppStrings.games, image: Images.games, tag: 1)
        return navGamesVC
    }
    
    func createListViewController() -> UIViewController {
        let listVC = FullListViewController()
        listVC.title = AppStrings.list
        listVC.tabBarItem = UITabBarItem(title: AppStrings.list, image: Images.list, tag: 2)
        return listVC
    }
}
