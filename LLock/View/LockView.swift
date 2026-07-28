import SwiftUI
import LocalAuthentication

struct LockView: View {
    @EnvironmentObject var appManager: AppManager
    
    @State private var isUnlockedSuccess: Bool = false
    @State private var mostrarErro: Bool = false
    @State private var mensagemErro: String = ""
    
    var body: some View {
        ZStack {
            Color("BackGroud")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    Image("LLock.mascotetrancado")
                        .resizable()
                        .scaledToFit()
                        .opacity(isUnlockedSuccess ? 0 : 1)
                    
                    Image("LLock.mascotedestracado")
                        .resizable()
                        .scaledToFit()
                        .opacity(isUnlockedSuccess ? 1 : 0)
                }
                .frame(width: 272, height: 276)

                VStack(spacing: 6) {
                    Text("O LLOCK ESTÁ")
                    Text(isUnlockedSuccess ? "DESBLOQUEADO" : "BLOQUEADO")
                }
                .font(
                    Font.custom("Fredoka", size: 40)
                    .weight(.medium)
                )
                .foregroundColor(Color("H2"))
                .frame(width: 359, height: 152, alignment: .top)
                .multilineTextAlignment(.center)
                
                if !isUnlockedSuccess {
                    BtnDesbloquear(
                        title: "Desbloquear",
                        backgroundColorName: "BtnColor"
                    ) {
                        authenticateUser()
                    }
                    .padding(.bottom, 100)
                    .transition(.opacity)
                } else {
                    Spacer()
                        .frame(height: 150)
                }
            }
        }
        .alert("Não foi possível desbloquear", isPresented: $mostrarErro) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(mensagemErro)
        }
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Por favor, autentique-se para acessar o aplicativo."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.isUnlockedSuccess = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            withAnimation(.easeInOut) {
                                appManager.currentView = .home
                            }
                        }
                        
                    } else {
                        self.exibirErroSeNecessario(authenticationError)
                    }
                }
            }
        } else {
            mensagemErro = "Configure o Face ID ou Touch ID nos Ajustes do seu iPhone para desbloquear o LLock."
            mostrarErro = true
        }
    }
    
    private func exibirErroSeNecessario(_ erro: Error?) {
        guard let laError = erro as? LAError else {
            mensagemErro = "Não foi possível autenticar. Tente novamente."
            mostrarErro = true
            return
        }
        
        switch laError.code {
        case .userCancel, .appCancel, .systemCancel:
            return
        case .userFallback:
            mensagemErro = "Use o código do dispositivo para desbloquear."
        case .biometryNotEnrolled:
            mensagemErro = "Nenhum Face ID ou Touch ID configurado neste dispositivo."
        case .biometryLockout:
            mensagemErro = "Muitas tentativas incorretas. Desbloqueie o dispositivo com o código para reativar a biometria."
        default:
            mensagemErro = "Não foi possível autenticar. Tente novamente."
        }
        
        mostrarErro = true
    }
}

#Preview {
    LockView()
        .environmentObject(AppManager())
}
