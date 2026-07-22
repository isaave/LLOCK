import SwiftUI

@main
struct faceIDTestApp: App {
    @StateObject private var appManager = AppManager()
    @StateObject private var gerenciador = GerenciadorDeSenhas() 
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appManager.currentView == .lock {
                    LockView()
                } else {
                    TabBarsView()
                }
            }
            .environmentObject(appManager)
            .environmentObject(gerenciador)
        }
    }
}
