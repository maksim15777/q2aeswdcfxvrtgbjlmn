// ChatViewModel+Draft.swift

import SwiftUI
import TDLibKit

extension ChatViewModel {
    func setDraft(_ draftMessage: DraftMessage) async {
        if !text.characters.isEmpty || replyMessage != nil { return }
        
        if case .inputMessageText(let inputMessageText) = draftMessage.inputMessageContent {
            await MainActor.run {
                text = inputMessageText.text.text.attributedString
            }
        }
        
        var replyToMessageId: Int64 = 0
        if let replyTo = draftMessage.replyTo,
           case .inputMessageReplyToMessage(let r) = replyTo {
            replyToMessageId = r.messageId
        }
        
        let customMessage = await getCustomMessage(fromId: replyToMessageId)
        
        await MainActor.run {
            withAnimation {
                replyMessage = customMessage
            }
        }
    }
    
    func updateDraft() async {
        let draftMessage = DraftMessage(
            date: Int(Date.now.timeIntervalSince1970),
            effectId: 0,
            inputMessageContent: .inputMessageText(
                .init(
                    clearDraft: true,
                    linkPreviewOptions: nil,
                    text: FormattedText(
                        entities: [],
                        text: text.string
                    )
                )
            ),
            replyTo: replyMessage.map { .inputMessageReplyToMessage(.init(messageId: $0.message.id, quote: nil)) }
        )
        
        await tdSetChatDraftMessage(draftMessage)
    }
}
