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

    private var errorLabel: UILabel {
        let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: view.bounds.midY),
                                          size: CGSize(width: view.bounds.width, height: 50)))
        label.text = "error"
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }

    private lazy var tableView = UITableView()

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

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task {
            await viewModel?.fetch()
        }
    }

    // MARK: - functions

    private func viewLayouts() {

        view.backgroundColor = .systemBackground

        view.addSubview(errorLabel)
        errorLabel.center = view.center

        setupTable()

    }

    private func bind() {
        viewModel?.$launchesList
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { list in
                self.tableView.reloadData()
            })
            .store(in: &cancellable)

        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { error in
                self.errorLabel.text = error
            })
            .store(in: &cancellable)
    }
}

// MARK: - table view
extension MissionListViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTable() {
        view.addSubview(tableView)
        tableView.fillSuperview()

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
        return viewModel?.launchesList?.docs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.reuseIdentifier, for: indexPath) as? MissionTableViewCell,
              let lists = viewModel?.launchesList
        else { return UITableViewCell() }

        cell.config(with: lists.docs?[indexPath.row])

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.pushToDetailsViewController(with: viewModel?.launchesList?.docs?[indexPath.row].id ?? "")
    }
}
