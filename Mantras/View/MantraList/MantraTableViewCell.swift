import UIKit

final class MantraTableViewCell: UITableViewCell {

    static let identifier = "MantraCell"
    
    let roundedBackgroundView = UIView()
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let durationLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with mantra: Mantra) {
        nameLabel.text = mantra.name
        durationLabel.text = mantra.formattedDuration
    }

    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .mantraListBackground
        
        roundedBackgroundView.layer.cornerRadius = 22.0
        roundedBackgroundView.backgroundColor = .mantraCellBackground
        roundedBackgroundView.clipsToBounds = true
        contentView.addSubview(roundedBackgroundView)
        
        iconImageView.image = UIImage(named: "playIcon")
        iconImageView.contentMode = .center
        roundedBackgroundView.addSubview(iconImageView)

        nameLabel.font = CustomFont.nunitoBoldFont(ofSize: 15.0)
        nameLabel.textColor = .mainForeground
        nameLabel.numberOfLines = 3
        roundedBackgroundView.addSubview(nameLabel)

        durationLabel.font = CustomFont.nunitoBoldFont(ofSize: 12.0)
        durationLabel.textColor = .mainForeground.withAlphaComponent(0.4)
        durationLabel.textAlignment = .center
        roundedBackgroundView.addSubview(durationLabel)
    }
    
    private func setupConstraints() {
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 62.0)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -74.0)
        ])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            durationLabel.widthAnchor.constraint(equalToConstant: 58.0),
            durationLabel.heightAnchor.constraint(equalToConstant: 32.0),
            durationLabel.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -16)
        ])
    }
}
