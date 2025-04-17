import SwiftUI

struct TextEditorSheetView: View {
    private typealias Strings = L10n.ChatBottomSheet
    
    @Environment(\.dismiss)
    private var dismiss: DismissAction
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                TextField(
                    Strings.textField,
                    text: $text,
                    prompt: Text(Strings.textFieldPlaceholder),
                    axis: .vertical
                )
                .font(.system(size: FontSize.large))
                .focused($isFocused)
                
                Spacer()
            }
            
            Button(
                action: { dismiss() },
                label: {
                    Label(
                        Strings.compressTextEditorLabel,
                        systemImage: "arrow.down.right.and.arrow.up.left"
                    )
                }
            )
            .buttonStyle(.mediumButton)
            .padding(.top, Spacing.extraExtraSmall)
        }
        .padding(Spacing.extraSmall)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFocused = true
            }
        }
    }
}
    