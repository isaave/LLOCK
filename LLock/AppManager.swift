import SwiftUI
import Combine

enum AppView {
    case lock
    case home
}

class AppManager: ObservableObject {
    @Published var currentView: AppView = .lock
}
