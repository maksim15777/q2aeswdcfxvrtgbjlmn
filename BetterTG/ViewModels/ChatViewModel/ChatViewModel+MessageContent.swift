// ChatViewModel+MessageContent.swift

import SwiftUI
import TDLibKit

extension ChatViewModel {
    func makeInputMessageContent(for url: URL) -> InputMessageContent {
        let path = url.path()
        
        let image = UIImage(contentsOfFile: path) ?? UIImage()
        
        let input: InputFile = .inputFileLocal(.init(path: path))
        
        return .inputMessagePhoto(
            InputMessagePhoto(
                caption: FormattedText(entities: [], text: text.string),
                hasSpoiler: false,
                photo: InputPhoto(photo: input),
                selfDestructType: nil,
                showCaptionAboveMedia: false
            )
        )
    }
}
