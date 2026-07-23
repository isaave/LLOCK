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

#Preview {
    ZStack {
        Color("BackGroud").ignoresSafeArea()
        
        BtnDesbloquear(
            title: "Desbloquear",
            backgroundColorName: "BtnColor" 
        ) {
            print("Botão testado no preview!")
        }
    }
}
