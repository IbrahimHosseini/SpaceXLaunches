//
//  MissionCoordinator.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import UIKit
import SafariServices

class MissionCoordinator: Coordinator {

    var navigationController: UINavigationController

    private let apiHandler: APIHandler

    private let responseHandler: ResponseHandler

    init(
        navigationController: UINavigationController = UINavigationController(),
        apiHandler: APIHandler = APIHandlerImp(),
        responseHandler: ResponseHandler = ResponseHandlerImp()
    ) {
        self.navigationController = navigationController
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }

    public func start() {
        // implement network layer
        let network = Network<LaunchesAPI>(
            apiHandler: APIHandlerImp(),
            responseHandler: ResponseHandlerImp()
        )

        // implement mission list service
        let service = LaunchesListServiceImp(network: network)

        // implement view model
        let viewModel = MissionListViewModel(service: service)

        // return view controller by implemented via view model
        let viewController = MissionListViewController(viewModel: viewModel)

        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    public func pushToDetailsViewController(docs: Docs?) {

        guard let docs,
              let id = docs.id
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
}
