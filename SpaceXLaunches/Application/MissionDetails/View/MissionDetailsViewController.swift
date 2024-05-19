//
//  MissionDetailsViewController.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import UIKit
import Combine

class MissionDetailsViewController: UIViewController {

    // MARK: - properties

    private let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private var item = UIBarButtonItem()

    private let viewModel: MissionDetailsViewModel

    private var cancellable = Set<AnyCancellable>()

    public var coordinator: MissionCoordinator?

    // MARK: - initializer

    init(_ viewModel: MissionDetailsViewModel) {
        
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - cycle view

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView()

        bind()
    }

    // MARK: - layout view
    private func layoutView() {

        view.backgroundColor = .systemBackground

        let margin: CGFloat = 8.0

        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = margin*2

        view.addSubview(vStack)

        vStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            padding: .init(
                top: margin,
                left: 0,
                bottom: 0,
                right: 0
            )
        )

        vStack.leadingAnchor(greaterThanOrEqualTo: view.leadingAnchor, constant: margin*2)
        vStack.trailingAnchor(greaterThanOrEqualTo: view.trailingAnchor, constant: margin*2)
        vStack.bottomAnchor(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: margin*16)

        // add image to vStack
        vStack.addArrangedSubview(missionImageView)

        let width = view.frame.width - margin*4

        missionImageView.constrain(widthConstant: width)
        missionImageView.constrain(heightConstant: width*(2/3))

        // a horizontal stack of name and date
        vStack.addArrangedSubview(dateLabel)

        // add description to vStack
        vStack.addArrangedSubview(descriptionLabel)

        // add link to vStack
        vStack.addArrangedSubview(linkButton)

        linkButton.addTarget(nil, action: #selector(openLink), for: .touchUpInside)

    }

    private func updateBookmarkState(with isMarked: Bool) {

        var isMarked = isMarked

        let icon = isMarked ? "bookmark.fill" : "bookmark"

        item = UIBarButtonItem(
            image: UIImage(systemName: icon),
            style: .plain,
            cancellables: &cancellable,
            action: { [weak self] in
                guard let self else { return }
                // change the state after tapped on bar button item
                isMarked.toggle()

                self.viewModel.bookmarkChanges(isMarked)
            }
        )

        addItemToRightNavigation(item)
    }

    private func addItemToRightNavigation(_ item: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = item
    }

    @objc private func openLink() {
        guard let url = linkButton.titleLabel?.text
        else { return }

        coordinator?.openUrl(url)
    }

    private func bind() {
        viewModel.$missionName
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                self?.title = value
            })
            .store(in: &cancellable)

        viewModel.$missionDetails
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                self?.descriptionLabel.text = value
            })
            .store(in: &cancellable)

        viewModel.$missionDate
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                self?.dateLabel.text = value
            })
            .store(in: &cancellable)

        viewModel.$imageUrl
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                self?.missionImageView.load(with: value)
            })
            .store(in: &cancellable)

        viewModel.$wikiLink
            .receive(on: RunLoop.main)
            .sink { [weak self] link in
                self?.linkButton.isHidden = link.isEmpty
                self?.linkButton.setTitle(link, for: .normal)
            }
            .store(in: &cancellable)

        viewModel.$isMarked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isMarked in
                self?.updateBookmarkState(with: isMarked)
            }
            .store(in: &cancellable)

    }
}
