//
//  MainCoordinator.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import UIKit
import SafariServices

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }

    func start() {
        // implement network layer
        let network = Network<LaunchesAPI>()

        // implement mission list service
        let service = LaunchesListServiceImp(network: network)

        // implement view model
        let viewModel = MissionListViewModel(service: service)

        // return view controller by implemented via view model
        let viewController = MissionListViewController(viewModel: viewModel)

        viewController.coordinator = self

        navigationController.delegate = self

        navigationController.pushViewController(viewController, animated: true)
    }

    public func pushToDetailsViewController(docs: Docs?) {
        
        guard let docs else { return }

        let child = MissionDetailsCoordinator(
            navigationController: self.navigationController,
            docs: docs
        )

        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()

    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let missionDetailsViewController = fromViewController as? MissionDetailsViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(missionDetailsViewController.coordinator)
        }
    }
}
