//
//  NavigationManager.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 4/3/25.
//

import UIKit

final class NavigationManager: NSObject {
    // MARK: - Properties
    static let shared = NavigationManager()
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    private override init() {
        super.init()
    }
    
    // MARK: - Setup
    func setup(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Navigation
    func setRoot(_ viewController: UIViewController, animated: Bool = false) {
        navigationController?.setViewControllers([viewController], animated: animated)
    }
    
    func navigate(to viewController: UIViewController, 
                  using transition: NavigationTransition) {
        switch transition {
        case .push(let animated):
            navigationController?.pushViewController(viewController, animated: animated)
        case .present(let style):
            configurePresentation(viewController, style: style)
            navigationController?.present(viewController, animated: true)
        case .panModal:
            break
        case .dismiss(let animated):
            navigationController?.dismiss(animated: animated)
        case .pop(let animated):
            navigationController?.popViewController(animated: animated)
        }
    }
    
    private func configurePresentation(_ viewController: UIViewController, 
                                       style: NavigationTransition.PresentationStyle) {
        switch style {
        case .fullScreen:
            viewController.modalPresentationStyle = .fullScreen
        case .overCurrentContext:
            viewController.modalPresentationStyle = .overCurrentContext
        case .overFullScreen:
            viewController.modalPresentationStyle = .overFullScreen
        case .custom(let style):
            viewController.modalPresentationStyle = style
        }
    }
}
