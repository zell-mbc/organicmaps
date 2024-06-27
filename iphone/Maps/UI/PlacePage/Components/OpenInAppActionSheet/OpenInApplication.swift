enum OpenInApplication: Int, CaseIterable {
  case googleMaps
  case appleMaps
  case osmAnd
}

extension OpenInApplication {

  private static let kUDLastUsedOpenInApplicationKey = "kUDLastUsedOpenInApplicationKey"

  static var lastUsedApp: OpenInApplication? {
    guard !availableApps.isEmpty else {
      return nil
    }
    if availableApps.count == 1 {
      return availableApps.first
    }
    return OpenInApplication(rawValue: UserDefaults.standard.integer(forKey: kUDLastUsedOpenInApplicationKey))
  }

  static func setLastUsedOpenInApp(_ application: OpenInApplication) {
    UserDefaults.standard.set(application.rawValue, forKey: kUDLastUsedOpenInApplicationKey)
  }

  static var availableApps: [OpenInApplication] {
    allCases.filter { UIApplication.shared.canOpenURL(URL(string: $0.scheme)!) }
  }

  var name: String {
    switch self {
    case .googleMaps:
      return "Google Maps"
    case .appleMaps:
      return "Apple Maps"
    case .osmAnd:
      return "OsmAnd Maps"
    }
  }

  var image: UIImage? {
    switch self {
    case .googleMaps:
      return UIImage(named: "open_in_google_maps")
    case .appleMaps:
      return UIImage(named: "open_in_apple_maps")
    case .osmAnd:
      return UIImage(named: "open_in_osmand_maps")
    }
  }

  // Schemes should be registered in LSApplicationQueriesSchemes - see Info.plist.
  var scheme: String {
    switch self {
    case .googleMaps:
      return "comgooglemaps://"
    case .appleMaps:
      return "http://maps.apple.com/"
    case .osmAnd:
      return "osmandmaps://"
    }
  }

  func linkForCoordinates(_ coordinates: CLLocationCoordinate2D) -> String {
    switch self {
    case .googleMaps:
      return "\(scheme)?&q=\(coordinates.latitude),\(coordinates.longitude)"
    case .appleMaps:
      return "\(scheme)?q=\(coordinates.latitude),\(coordinates.longitude)"
    case .osmAnd:
      return "\(scheme)?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&z=15"
    }
  }
}
