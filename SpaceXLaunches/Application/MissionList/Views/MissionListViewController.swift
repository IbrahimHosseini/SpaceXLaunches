//
//  MissionListViewController.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import UIKit
import Combine

class MissionListViewController: UIViewController {

    // MARK: - properties
    private var cancellable = Set<AnyCancellable>()

    private var viewModel: MissionListViewModel?

    private lazy var tableView = UITableView()

    private var docs = [Docs]()

    public var coordinator: MissionCoordinator?

    // MARK: - initializer
    init(viewModel: MissionListViewModel?) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle view
    override func viewDidLoad() {
        super.viewDidLoad()

        viewLayouts()

        bind()

        callAPI()

    }

    // MARK: - functions

    private func viewLayouts() {

        view.backgroundColor = .systemBackground

        title = "Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true

        setupTable()
    }

    private func bind() {
        viewModel?.$launchesList
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] list in
                guard let self,
                      let docs = list?.docs
                else { return }

                self.docs.append(contentsOf: docs)

                self.tableView.reloadData()
            })
            .store(in: &cancellable)

        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                guard let self else { return }
                self.updateMessageView(error)

            })
            .store(in: &cancellable)
    }

    private func callAPI(page: Int = 1, limit: Int = 20) {
        Task {
            await viewModel?.fetch(page, limit: limit)
        }
    }

    private func updateMessageView(_ message: String) {
        let statusView = UIView()
        let statusLabel = UILabel()
        statusLabel.textColor = .systemRed
        
        statusView.addSubview(statusLabel)

        statusLabel.text = message

        statusLabel.centerXInSuperview()
        statusLabel.centerYInSuperview()

        tableView.backgroundView = statusView
    }
}

// MARK: - table view
extension MissionListViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTable() {
        view.addSubview(tableView)
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        tableView.register(
            MissionTableViewCell.self,
            forCellReuseIdentifier: MissionTableViewCell.reuseIdentifier
        )

        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorInset.left = 16
        tableView.separatorInset.right = 16
        tableView.tableFooterView = UIView()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        docs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.reuseIdentifier, for: indexPath) as? MissionTableViewCell
        else { return UITableViewCell() }

        cell.config(with: docs[indexPath.row])

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docs = docs[indexPath.row]
        coordinator?.pushToDetailsViewController(docs: docs)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard docs.count > 0
        else { return }

        let lastIndex = docs.count - 1

        if indexPath.row == lastIndex,
           let list = viewModel?.launchesList,
           list.hasNextPage ?? false,
           let nextPage = list.nextPage {
            self.callAPI(page: nextPage, limit: 50)
        }
    }
}
