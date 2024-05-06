//
//  MissionTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import UIKit

class MissionTableViewCell: UITableViewCell {

    private let flightNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .heavy)
        return label
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemGray
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutViews() {

        contentView.backgroundColor = .systemBackground

        let margin = 8.0

        let hStack = UIStackView()
        hStack.spacing = margin*2
        hStack.distribution = .fill
        hStack.alignment = .center

        contentView.addSubview(hStack)
        hStack.fillSuperview(
            padding: .init(
                top: margin,
                left: margin*2,
                bottom: margin,
                right: margin*2
            )
        )

        // MARK: Flight number and Status stack
        let flightNOAndStatusStack = UIStackView()
        flightNOAndStatusStack.spacing = margin/2
        flightNOAndStatusStack.axis = .vertical
        flightNOAndStatusStack.distribution =  .equalSpacing
        flightNOAndStatusStack.alignment = .center
        flightNOAndStatusStack.constrain(widthConstant: 70)

        // add flight number
        flightNOAndStatusStack.addArrangedSubview(flightNumberLabel)
        flightNOAndStatusStack.addArrangedSubview(statusLabel)

        // MARK: Date and description stack
        let dateAndDescriptionStack = UIStackView()
        dateAndDescriptionStack.spacing = margin
        dateAndDescriptionStack.axis = .vertical

        dateAndDescriptionStack.addArrangedSubview(dateLabel)
        dateAndDescriptionStack.addArrangedSubview(descriptionLabel)

        // MARK: HStack items
        hStack.addArrangedSubview(icon)
        icon.constrain(widthConstant: 30)
        icon.constrain(heightConstant: 30)

        hStack.addArrangedSubview(flightNOAndStatusStack)
        hStack.addArrangedSubview(dateAndDescriptionStack)

    }

    public func config(with model: Docs?) {
        guard let model else { return }

        flightNumberLabel.text = "\(model.flightNumber ?? 0)"

        statusLabel.text = (model.success ?? false) ? "Success" : "Fail"
        statusLabel.textColor = (model.success ?? false) ? .systemGreen : .systemRed

        descriptionLabel.text = model.details

        dateLabel.text = model.dateUTC?.toStringDate

        if let icon = model.links?.patch?.small {
            self.icon.load(with: icon)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flightNumberLabel.text = nil
        statusLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
        icon.image = nil
    }

}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    MissionTableViewCell()
}
#endif
