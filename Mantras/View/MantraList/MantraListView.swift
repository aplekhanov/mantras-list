import UIKit

final class MantraListView: UIView {
    
    let grabberView = UIView()
    let titleLabel = UILabel()
    let tableView = UITableView()
    let shuffleButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .mantraListBackground
        layer.cornerRadius = 26.0
        layer.masksToBounds = true
        
        grabberView.backgroundColor = .grabberBackground
        grabberView.layer.cornerRadius = 2.0
        addSubview(grabberView)
        
        titleLabel.text = NSLocalizedString("mantraListTitle", comment: "Title of the mantra list")
        titleLabel.font = CustomFont.peachiBlackFont(ofSize: 36.0)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        tableView.backgroundColor = backgroundColor
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.register(MantraTableViewCell.self, forCellReuseIdentifier: MantraTableViewCell.identifier)
        addSubview(tableView)
        
        let buttonTitle = NSLocalizedString("shuffleMantraListButtonTitle",
                                            comment: "Button title to shuffle the mantra list")
        shuffleButton.setTitle(buttonTitle, for: .normal)
        shuffleButton.setTitleColor(.mainForeground, for: .normal)
        shuffleButton.titleLabel?.font = CustomFont.nunitoBoldFont(ofSize: 15.0)
        shuffleButton.setImage(UIImage(named: "shuffleIcon"), for: .normal)
        shuffleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 8.0)
        shuffleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 0.0)
        shuffleButton.backgroundColor = backgroundColor
        shuffleButton.layer.borderWidth = 1.5
        shuffleButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.07).cgColor
        shuffleButton.layer.cornerRadius = 22.0
        addSubview(shuffleButton)
    }
    
    private func setupConstraints() {
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            grabberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 44.0),
            grabberView.heightAnchor.constraint(equalToConstant: 4.0)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: shuffleButton.topAnchor, constant: -22.0)
        ])
        
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shuffleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shuffleButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12.0),
            shuffleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            shuffleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            shuffleButton.heightAnchor.constraint(equalToConstant: 62.0)
        ])
    }
}
