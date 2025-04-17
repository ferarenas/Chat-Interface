import SwiftUI

extension LabelStyle where Self == CustomLabelStyle {
    static var mediumButton: Self {
        .init(iconSize: Sizing.medium)
    }
    
    static var largeButton: Self {
        .init(iconSize: Sizing.extraLarge)
    }
}

struct CustomLabelStyle: LabelStyle {
    let iconSize: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.icon
            .foregroundStyle(Color(.black))
            .imageScale(.medium)
            .font(.system(size: iconSize))
    }
}
