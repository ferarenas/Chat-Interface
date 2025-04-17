import SwiftUI

final class ChatBottomSheetViewModel: ObservableObject {
    private typealias Strings = L10n.ChatBottomSheet
    
    let inputSuggestions: [InputSuggestion] = [
        .init(text: Strings.chipGatherResources),
        .init(text: Strings.chipTakePicturePlant),
        .init(text: Strings.chipBoatMaterial),
        .init(text: Strings.chipBeatMonster),
        .init(text: Strings.chipBeatBoss)
    ]
    
    @Published var text: String = ""
    @Published private(set) var fontSize: CGFloat = FontSize.large {
        didSet {
            guard !fontSize.isNaN else {
                // Temporarily removes the observer effect by assigning
                // it on next runloop tick
                DispatchQueue.main.async {
                    self.fontSize = oldValue
                }
                return
            }
        }
    }
    
    private var textFieldLines: Int = 1
    private var textFieldHeight: Double = 0
    
    func checkLineChange(for newHeight: Double) {
        guard self.textFieldHeight != 0 else {
            self.textFieldHeight = newHeight
            return
        }
        
        let delta = newHeight - self.textFieldHeight
        let lineChange = Int(delta / FontSize.medium)
        let lineChangeDirection: LineChangeDirection = if lineChange > 0 {
            .increasing
        } else if lineChange < 0 {
            .decreasing
        } else {
            .none
        }
        
        self.textFieldHeight = newHeight
        self.textFieldLines += lineChange
        adjustFontSize(direction: lineChangeDirection)
    }
    
    private func adjustFontSize(direction: LineChangeDirection) {
        switch direction {
        case .increasing:
            if textFieldLines >= 5, fontSize == FontSize.large {
                self.fontSize = FontSize.medium
            } else if textFieldLines >= 5, fontSize == FontSize.medium {
                self.fontSize = FontSize.small
            }
        case .decreasing:
            if textFieldLines <= 3, fontSize == FontSize.small {
                self.fontSize = FontSize.medium
            } else if textFieldLines <= 3, fontSize == FontSize.medium {
                self.fontSize = FontSize.large
            }
        case .none:
            return
        }
    }
}

private extension ChatBottomSheetViewModel {
    enum LineChangeDirection {
        case increasing
        case decreasing
        case none
    }
}
