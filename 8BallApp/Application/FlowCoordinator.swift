//
//  FlowCoordinator.swift
//  8BallApp
//
//  Created by Rita on 19.12.2021.
//

import UIKit

class FlowCoordinator {
    
    private weak var _viewController: UIViewController?
    private var _temporaryStoredViewController: UIViewController?
    
    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension FlowCoordinator {
    
    public var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController ?? UIViewController()
    }
    
    public var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}
