import SwiftUI

@main
struct faceIDTestApp: App {
    // Cria uma instância do gerenciador de telas
    @StateObject private var appManager = AppManager()
    
    var body: some Scene {
        WindowGroup {
            // Controla qual tela exibir com base no estado atual
            Group {
                if appManager.currentView == .lock {
                    LockView()
                } else {
                    HomeView()
                }
            }
            .environmentObject(appManager) // Injeta o gerenciador em todas as views
        }
    }
}
