//
//  MissionDetailsCoordinator.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/20/24.
//

import UIKit

class MissionDetailsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    private let docs: Docs

    public var parentCoordinator: MainCoordinator?

    init(navigationController: UINavigationController,
         docs: Docs) {
        self.navigationController = navigationController
        self.docs = docs
    }

    func start() {
        guard let id = docs.id
        else { return }

        let storageService = UserDefaultStorage(key: "bookmarks")

        let service = MissionDetailsServiceImp(
            docs: docs,
            storageService: storageService,
            id: id
        )

        let viewModel = MissionDetailsViewModel(service: service)

        let viewController = MissionDetailsViewController(viewModel)

        viewController.coordinator = self

        navigationController.pushViewController(
            viewController,
            animated: true
        )
    }

    func openUrl(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }

    func didFinishDetails() {
        parentCoordinator?.childDidFinish(self)
    }

}
