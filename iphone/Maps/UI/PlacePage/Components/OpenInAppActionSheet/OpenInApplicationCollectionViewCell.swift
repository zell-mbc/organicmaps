final class OpenInApplicationCollectionViewCell: UICollectionViewCell {

  private enum Constants {
    static let spacing = CGFloat(5)
    static let cornerRadius = CGFloat(10)
  }

  private let imageView = UIImageView()
  private let titleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {
    setStyleAndApply("ClearBackground")

    imageView.contentMode = .scaleAspectFit
    imageView.layer.setCorner(radius: Constants.cornerRadius)
    imageView.layer.masksToBounds = true

    titleLabel.font = StyleManager.shared.theme?.fonts.medium10
    titleLabel.textColor = StyleManager.shared.theme?.colors.blackSecondaryText
    titleLabel.textAlignment = .center
    titleLabel.minimumScaleFactor = 0.7
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.allowsDefaultTighteningForTruncation = true
    titleLabel.lineBreakMode = .byWordWrapping

    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.spacing),

      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.font.lineHeight)
    ])
  }

  // MARK: - Public
  func set(image: UIImage?, title: String) {
    imageView.image = image
    titleLabel.text = title
  }
}
