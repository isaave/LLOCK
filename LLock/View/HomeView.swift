import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Bem-vindo à Tela Inicial!")
                .font(.largeTitle)
                .bold()
            
            Button(action: {
                // Voltar para a tela de bloqueio
                appManager.currentView = .lock
            }) {
                Text("Bloquear App")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppManager())
}
