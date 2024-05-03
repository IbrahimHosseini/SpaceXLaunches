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
        label.text = "100"
        return label
    }()

    private let icon: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Success"
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemGray
        label.text = "Description"
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "2024-02-12'T'19:00:00.000Z"
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

        let margin = 8.0

        let hStack = UIStackView()
        hStack.spacing = margin*2
        hStack.distribution = .fill

        contentView.addSubview(hStack)
        hStack.fillSuperview(
            padding: .init(
                top: margin,
                left: margin*2,
                bottom: margin,
                right: margin*2
            )
        )

        let vStack = UIStackView()
        vStack.spacing = margin
        vStack.axis = .vertical

        let flightAndIconStack = UIStackView()
        flightAndIconStack.spacing = margin/2
        flightAndIconStack.axis = .vertical
        flightAndIconStack.distribution =  .equalSpacing
        flightAndIconStack.alignment = .center
        flightAndIconStack.constrain(widthConstant: 70)

        // add flight number
        flightAndIconStack.addArrangedSubview(flightNumberLabel)

        // add mission icon
        flightAndIconStack.addArrangedSubview(icon)

        flightAndIconStack.addArrangedSubview(statusLabel)


        let dateStatusStack = UIStackView()
        dateStatusStack.spacing = margin
        dateStatusStack.distribution = .fill

        dateStatusStack.addArrangedSubview(dateLabel)

        vStack.addArrangedSubview(dateStatusStack)

        vStack.addArrangedSubview(descriptionLabel)

        hStack.addArrangedSubview(flightAndIconStack)
        hStack.addArrangedSubview(vStack)

    }

    public func config(with model: Docs?) {
        guard let model else { return }

        flightNumberLabel.text = "\(model.flightNumber ?? 0)"

        statusLabel.text = model.success == true ? "Success" : "Fail"
        statusLabel.textColor = model.success == true ? .systemGreen : .systemRed

        descriptionLabel.text = model.details

        dateLabel.text = model.dateUTC?.toStringDate

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flightNumberLabel.text = nil
        statusLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil
    }

}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
    MissionTableViewCell()
}
#endif
