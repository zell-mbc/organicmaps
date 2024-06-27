final class InfoItemViewController: UIViewController {
  enum Style {
    case regular
    case link
  }

  typealias TapHandler = () -> Void

  @IBOutlet var imageView: UIImageView!
  @IBOutlet var infoLabel: UILabel!
  @IBOutlet var accessoryImage: UIImageView!

  private var tapGestureRecognizer: UITapGestureRecognizer!
  private var longPressGestureRecognizer: UILongPressGestureRecognizer!
  private var accessoryImageTapGestureRecognizer: UITapGestureRecognizer!

  var tapHandler: TapHandler?
  var longPressHandler: TapHandler?
  var accessoryImageTapHandler: TapHandler?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupGestureRecognizers()
  }

  // MARK: - Private

  private func setupGestureRecognizers() {
    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
    view.addGestureRecognizer(tapGestureRecognizer)
    view.addGestureRecognizer(longPressGestureRecognizer)

    accessoryImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onAccessoryImageTap))
    accessoryImage.addGestureRecognizer(accessoryImageTapGestureRecognizer)
  }

  @objc
  private func onTap() {
    tapHandler?()
  }

  @objc
  private func onLongPress(_ sender: UILongPressGestureRecognizer) {
    guard sender.state == .began else { return }
    longPressHandler?()
  }

  @objc
  private func onAccessoryImageTap() {
    accessoryImageTapHandler?()
  }

  // MARK: - Public

  func setStyle(_ style: Style) {
    switch style {
    case .regular:
      imageView.styleName = "MWMBlack"
      infoLabel.styleName = "regular16:blackPrimaryText"
    case .link:
      imageView.styleName = "MWMBlue"
      infoLabel.styleName = "regular16:linkBlueText"
    }
    accessoryImage.styleName = "MWMBlack"
  }

  func setAccessory(image: UIImage?, tapHandler: TapHandler? = nil) {
    accessoryImage.image = image
    accessoryImage.isHidden = image == nil
    accessoryImageTapHandler = tapHandler
  }
}
