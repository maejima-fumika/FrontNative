import SwiftUI


struct testFunc: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        // 戻り値をWKWebViewとし、返却する
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}

struct testFuncView: View {
    
    var body: some View {
    
        testFunc()
    }
}

struct testFunc_Previews: PreviewProvider {
    static var previews: some View {
        testFuncView()
    }
}

