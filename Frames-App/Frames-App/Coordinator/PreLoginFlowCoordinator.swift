//
//  InitialScreenCoordinator.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/13/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift

class PreLoginFlowCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = InitialLaunchViewModel()
        let vc = InitialLaunchViewController.initFromStoryboard(name: InitialLaunchViewController.storyboardIdentifier)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.backItem?.backBarButtonItem?.tintColor = .black
        navigationController.navigationItem.backBarButtonItem?.title = ""
        
        vc.viewModel = viewModel
        
        viewModel.didTapSignIn
            .subscribe(onNext: { [weak self] in
                self?.showSignIn(in: navigationController)
            })
            .disposed(by: disposeBag)
        
        viewModel.didTapSignUp
            .subscribe(onNext: { [weak self] in
                self?.showSignUp(in: navigationController)
            })
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        return Observable.never()
    }
    
    func showSignIn(in navigationController: UINavigationController) {
        let viewModel = SignInViewModel()
        let vc = SignInViewController.initFromStoryboard(name: SignInViewController.storyboardIdentifier)

        vc.viewModel = viewModel
        
        viewModel.didTapSignIn
            .subscribe(onNext: { [weak self] in
                self?.showMainApp()
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(vc, animated: true)
    }

    func showSignUp(in navigationController: UINavigationController ) {
        let viewModel = SignUpViewModel()
        let vc = SignUpViewController.initFromStoryboard(name: SignUpViewController.storyboardIdentifier)

        vc.viewModel = viewModel

        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMainApp() {
        let appTabBarCoordinator = AppTabBarCoordinator(window: window)
        coordinate(to: appTabBarCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
