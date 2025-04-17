# Chat Interface

A SwiftUI-based bottom sheet chat interface inspired by apps like ChatGPT and Google Gemini.  
This app allows users to type text, dynamically resizes the font based on text length, displays contextual suggestions, and supports image selection from the photo library.

## ✨ Features

- Horizontally scrollable chip suggestions
- Tapping a chip sets it as the input text
- Multi-line `TextEditor` with dynamic font resizing:
  - Starts at 18pt
  - Shrinks to 16pt and 14pt as text expands
  - Font size increases when content shrinks
- Drag-to-dismiss gesture support
- Expand/minimize sheet transition
- Image picker integration with thumbnail preview on selection
- Smooth animations and responsiveness across iPhone screen sizes

## 🚀 Getting Started

No special setup required.

- **Xcode**: 16.2  
- **iOS Simulator**: iPhone 16 Pro Max  
- **iOS Version**: 18.3.1

Open the project in Xcode and run it on the simulator or a compatible device.

## ⚠️ Known Issues & Notes

- 📸 **Semi-Expanded Photo Picker**: I experimented with presenting the `PhotosPicker` in `.inline` style transitioning into `.presentation`, but couldn’t get the transitions quite right. To maintain a smoother UX, I decided to leave it out. I explored a few approaches, but they either felt too hacky or time-consuming for the scope.
  
- 🖼️ **Thumbnail Preview Placement**: In Section 5.ii, I chose to display the image preview _below_ the input rather than above the buttons. I found this worked better for small screens. If desired, it can be moved above the buttons by conditionally rendering an `HStack` with the image and a spacer for alignment.

## 👤 Author

Made with ❤️ by **Fernando Arenas**
