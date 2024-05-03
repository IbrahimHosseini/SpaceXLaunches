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

        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        return label
    }()

    private let missionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024-02-12'T'19:00:00.000Z"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let linkLabel: UILabel = {
        let label = UILabel()
        label.text = "https://apple.com"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()

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
        let margin: CGFloat = 8.0
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = margin

        view.addSubview(vStack)
        vStack.fillSuperview(
            padding: .init(
                top: margin,
                left: margin*2,
                bottom: margin,
                right: margin*2
            )
        )

        // add image to vStack
        vStack.addArrangedSubview(missionImageView)

        // a horizontal stack of name and date
        let hStack = UIStackView()
        hStack.addArrangedSubview(missionNameLabel)
        hStack.addArrangedSubview(dateLabel)

        // add hStack to vStack
        vStack.addArrangedSubview(hStack)

        // add description to vStack
        vStack.addArrangedSubview(descriptionLabel)

        // add link to vStack
        vStack.addArrangedSubview(linkLabel)

    }

    private func bind() {
        viewModel.$missionName
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.missionNameLabel.text = value
            })
            .store(in: &cancellable)

        viewModel.$missionDetails
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.descriptionLabel.text = value
            })
            .store(in: &cancellable)

        viewModel.$missionDate
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.dateLabel.text = value
            })
            .store(in: &cancellable)

        viewModel.$imageUrl
            .receive(on: RunLoop.main)
            .sink(receiveValue: { value in
                self.missionImageView.image = UIImage(named: value)
            })
            .store(in: &cancellable)

    }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    MissionDetailsViewController(MissionDetailsViewModel())
}
#endif
