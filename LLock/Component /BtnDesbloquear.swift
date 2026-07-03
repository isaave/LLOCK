import SwiftUI

struct BtnDesbloquear: View {
    let title: String
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 210, height: 52)
                .background(Color(backgroundColorName))
                .clipShape(Capsule())
                .shadow(color: Color(backgroundColorName).opacity(0.15), radius: 8, x: 0, y: 4)
        }
    }
}

// CORREÇÃO AQUI: Passando os parâmetros necessários para o Preview funcionar
#Preview {
    ZStack {
        // Fundo creme para destacar o botão igual ao seu Figma
        Color("BackGroud").ignoresSafeArea()
        
        BtnDesbloquear(
            title: "Desbloquear",
            backgroundColorName: "BtnColor" // Usa a cor do seu Assets
        ) {
            print("Botão testado no preview!")
        }
    }
}
