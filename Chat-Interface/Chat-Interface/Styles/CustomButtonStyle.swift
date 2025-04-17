import SwiftUI

extension ButtonStyle where Self == CustomButtonStyle {
    static var mediumButton: Self {
        .init(iconSize: Sizing.medium, labelStyle: .mediumButton)
    }
    
    static var largeButton: Self {
        .init(iconSize: Sizing.extraLarge, labelStyle: .largeButton)
    }
}

struct CustomButtonStyle: ButtonStyle {
    let iconSize: CGFloat
    let labelStyle: CustomLabelStyle
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(labelStyle)
    }
}
