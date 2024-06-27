typealias OpenInApplicationCompletionHandler = (OpenInApplication) -> Void

enum OpenInAppError: Error {
  case noAppsAvailable
}

extension UIAlertController {

  private enum Constants {
    // There is no Cancel button on iPad (not iPad on Mac) for action sheets.
    static let actionSheetBottomMargin = CGFloat(alternative(iPhone: 65, iPad: 0, iPadOnMac: 65))
    static let collectionViewHeight = CGFloat(80)
    static let collectionViewInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
  }
  
  static func openInAppActionSheet(sourceView: UIView,
                                   apps: [OpenInApplication] = OpenInApplication.availableApps,
                                   lastUsedApp: OpenInApplication? = OpenInApplication.lastUsedApp,
                                   didSelectApp: @escaping OpenInApplicationCompletionHandler) -> UIAlertController {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let collectionView = OpenInApplicationCollectionView(apps: apps, lastUsedApp: lastUsedApp, didSelectApp: { application in
      didSelectApp(application)
      alertController.dismiss(animated: true)
    })
    alertController.view.addSubview(collectionView)

    alertController.view.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      alertController.view.heightAnchor.constraint(equalToConstant: Constants.actionSheetBottomMargin + Constants.collectionViewHeight + Constants.collectionViewInsets.top + Constants.collectionViewInsets.bottom),
      collectionView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: Constants.collectionViewInsets.top),
      collectionView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: Constants.collectionViewInsets.left),
      collectionView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -Constants.collectionViewInsets.right),
      collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
    ])

    let cancelAction = UIAlertAction(title: L("cancel"), style: .cancel)
    alertController.addAction(cancelAction)
    iPadSpecific {
      alertController.popoverPresentationController?.sourceView = sourceView
      alertController.popoverPresentationController?.sourceRect = sourceView.bounds
    }
    return alertController
  }
}
