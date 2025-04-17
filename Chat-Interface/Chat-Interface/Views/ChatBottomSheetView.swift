import SwiftUI
import PhotosUI

struct ChatBottomSheetView: View {
    private typealias Strings = L10n.ChatBottomSheet
    
    @State private var isTextFieldExpanded: Bool = false
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var image: Image? = nil
    
    @ObservedObject var viewModel: ChatBottomSheetViewModel
    
    private var shouldShowSuggestions: Bool { viewModel.text.isEmpty }

    var body: some View {
        VStack(spacing: Spacing.extraExtraSmall) {
            Spacer()

            if viewModel.text.isEmpty {
                inputSuggestionsSection
                    .padding(.leading, Spacing.extraExtraSmall)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }

            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: Spacing.extraSmall) {
                    textField
                    expandTextFieldButton
                }
                // Height set to 145 to prevent the container from resizing as the
                // Textfield height changes
                .frame(height: 145)

                HStack {
                    photosPicker
                    Spacer()
                    sendMessageButton
                }
            }
            .padding(Spacing.extraSmall)
            .background(unevenRoundedBackground)
        }
        .background(Color(.gray).opacity(0.2))
        .animation(.easeInOut(duration: 0.25), value: shouldShowSuggestions)
        .sheet(
            isPresented: $isTextFieldExpanded
        ) {
            TextEditorSheetView(text: $viewModel.text)
        }
    }

    // MARK: InputSuggestions
    private var inputSuggestionsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.inputSuggestions, id: \ .self) {
                   inputSuggestion($0)
                }
            }
        }
    }

    @ViewBuilder
    private func inputSuggestion(_ suggestion: InputSuggestion) -> some View {
        VStack(alignment: .leading, spacing: Spacing.extraExtraExtraSmall) {
            Text(suggestion.primaryText)
                .foregroundStyle(.primary)
                .font(.system(size: FontSize.small, weight: .bold))
            Text(suggestion.secondaryText)
                .foregroundStyle(.secondary)
                .font(.system(size: FontSize.small, weight: .regular))
        }
        .padding(Spacing.extraSmall)
        .background(.white)
        .cornerRadius(CornerRadius.medium)
        .onTapGesture {
            viewModel.text = suggestion.originalText
        }
    }

    // MARK: TextField
    private var textField: some View {
        VStack {
            TextField(
                Strings.textField,
                text: $viewModel.text,
                prompt: Text(Strings.textFieldPlaceholder),
                axis: .vertical
            )
            .font(.system(size: viewModel.fontSize))
            .lineLimit(6)
            // Dynamically resizes the text field and adjusts font size
            // based on number of lines
            .onGeometryChange(
                for: Double.self,
                of: { $0.size.height },
                action: { viewModel.checkLineChange(for: $0) }
            )

            Spacer()
        }
    }

    // MARK: PhotosPicker
    private var photosPicker: some View {
        PhotosPicker(selection: $selectedPickerItem) {
            ZStack {
                if let image {
                    imageView(image: image)
                } else {
                    Label(Strings.photosPickerLabel, systemImage: "photo.badge.plus")
                        .labelStyle(.largeButton)
                        .frame(height: Sizing.photo)
                }
            }
            .animation(.easeOut, value: image)
        }
        .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
        .onChange(of: selectedPickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    image = Image(uiImage: uiImage)
                }
            }
        }
        .accessibilityLabel(Strings.photosAccessibilityLabel)
    }

    // MARK: Image
    @ViewBuilder
    private func imageView(image: Image) -> some View {
        ZStack(alignment: .topTrailing) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: Sizing.photo, height: Sizing.photo)
                .cornerRadius(CornerRadius.small)

            Button(
                action: {
                    withAnimation {
                        self.image = nil
                        self.selectedPickerItem = nil
                    }
                }
            ) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.black)
                    .background(.white)
                    .clipShape(Circle())
            }
            .padding(-6)
            .accessibilityLabel(Strings.removePictureButton)
        }
        .transition(.opacity)
    }

    // MARK: Buttons
    private var expandTextFieldButton: some View {
        Button(
            action: { isTextFieldExpanded.toggle() },
            label: {
                Label(
                    Strings.expandTextEditorLabel,
                    systemImage: "arrow.up.left.and.arrow.down.right"
                )
            }
        )
        .buttonStyle(.mediumButton)
        .accessibilityLabel(Strings.expandTextEditorAccessibility)
    }

    private var sendMessageButton: some View {
        Button(
            action: {},
            label: { Label(Strings.sendMessageLabel, systemImage: "paperplane.fill") }
        )
        .buttonStyle(.largeButton)
        .frame(height: Sizing.photo)
        .accessibilityLabel(Strings.sendMessageAccessibility)
    }

    // MARK: Background
    private var unevenRoundedBackground: some View {
        UnevenRoundedRectangle(
            topLeadingRadius: CornerRadius.medium,
            topTrailingRadius: CornerRadius.medium
        )
        .fill(.white)
        .ignoresSafeArea()
    }
}

#Preview {
    ChatBottomSheetView(viewModel: ChatBottomSheetViewModel())
}


