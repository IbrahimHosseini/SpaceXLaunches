//
//  MissionCoordinator.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import UIKit

class MissionCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

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

    public func pushToDetailsViewController(with id: String) {

        let viewModel = MissionDetailsViewModel()

        let viewController = MissionDetailsViewController(viewModel)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)

    }

    // MARK: - pop to questionnaires list view
    public func popToRootViewController() {
        navigationController.popToRootViewController(animated: false)
    }
}
