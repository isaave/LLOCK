import SwiftUI
import LocalAuthentication

struct LockView: View {
    @EnvironmentObject var appManager: AppManager
    
    @State private var isUnlockedSuccess: Bool = false
    @State private var mostrarErro: Bool = false
    @State private var mensagemErro: String = ""
    
    private let backgroundColor = Color("BackGroud")
    private let textColor = Color.primary
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Spacer()
                
                // --- Mascote e Confetes ---
                ZStack {
                    if isUnlockedSuccess {
                        // Image("LLock.confetes")
                        //     .resizable()
                        //     .scaledToFit()
                    }
                    
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
                    .animation(.easeInOut(duration: 0.3), value: isUnlockedSuccess)
                }
                .frame(width: 272, height: 276)
                
                // --- Texto e Botão ---
                VStack(spacing: 20) {
                    
                    Text(isUnlockedSuccess ? "" : "O LLock está\nbloqueado")
                        .font(Font.custom("Fredoka", size: 36).weight(.medium))
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .id(isUnlockedSuccess)
                        .transition(.opacity)
                    
                    if !isUnlockedSuccess {
                        BtnDesbloquear(
                            title: "Desbloquear",
                            backgroundColorName: "BtnColor"
                        ) {
                            authenticateUser()
                        }
                        .padding(.horizontal, 40)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    } else {
                        Spacer()
                            .frame(height: 60)
                    }
                }
                .frame(height: 200)
                .animation(.easeInOut, value: isUnlockedSuccess)
                .padding(.top, 24)
                
                Spacer()
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
