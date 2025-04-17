import SwiftUI

@main
struct ChatInterfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ChatBottomSheetView(viewModel: ChatBottomSheetViewModel())
        }
    }
}
