import UIKit

final class MainView: UIView {
    
    let openButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .mainBackground
        
        let buttonTitle = NSLocalizedString("openMantraListButtonTitle", 
                                            comment: "Button title to open the mantra list")
        openButton.setTitle(buttonTitle, for: .normal)
        openButton.setTitleColor(.mainForeground, for: .normal)
        openButton.titleLabel?.font = CustomFont.nunitoBoldFont(ofSize: 16.0)
        openButton.backgroundColor = .accent
        openButton.layer.cornerRadius = 22.0
        addSubview(openButton)
    }
    
    private func setupConstraints() {
        openButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            openButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            openButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            openButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            openButton.heightAnchor.constraint(equalToConstant: 62.0)
        ])
    }
}
