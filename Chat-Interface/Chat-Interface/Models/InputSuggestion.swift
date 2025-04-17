struct InputSuggestion: Hashable {
    let primaryText: String
    let secondaryText: String
    
    let originalText: String
    
    init(text: String) {
        let words = text.split(separator: " ", omittingEmptySubsequences: true)
        self.originalText = text
        self.primaryText = words.prefix(3).joined(separator: " ")
        self.secondaryText = words.dropFirst(3).joined(separator: " ")
    }
}
