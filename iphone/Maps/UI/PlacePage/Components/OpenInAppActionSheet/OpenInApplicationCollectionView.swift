final class OpenInApplicationCollectionView: UICollectionView {

  private enum Constants {
    static let collectionViewInteritemSpacing = CGFloat(5)
  }

  private var apps: [OpenInApplication] = []
  private var lastUsedApp: OpenInApplication?
  private var didSelectAppHandler: OpenInApplicationCompletionHandler

  init(apps: [OpenInApplication],
       lastUsedApp: OpenInApplication?,
       didSelectApp: @escaping OpenInApplicationCompletionHandler) {
    self.apps = apps
    self.lastUsedApp = lastUsedApp
    self.didSelectAppHandler = didSelectApp

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = Constants.collectionViewInteritemSpacing

    super.init(frame: .zero, collectionViewLayout: layout)
    setupCollectionView()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupCollectionView() {
    delegate = self
    dataSource = self
    register(cell: OpenInApplicationCollectionViewCell.self)
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
  }
}

// MARK: - UICollectionViewDataSource
extension OpenInApplicationCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    apps.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(cell: OpenInApplicationCollectionViewCell.self, indexPath: indexPath)
    cell.set(image: apps[indexPath.item].image, title: apps[indexPath.item].name)
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension OpenInApplicationCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    didSelectAppHandler(apps[indexPath.item])
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OpenInApplicationCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sideSize = collectionView.bounds.height
    return CGSize(width: sideSize, height: sideSize)
  }
}


