// +Message.swift

import SwiftUI
import TDLibKit

extension Message {
    static func moc(_ isOutgoing: Bool, _ count: Int) -> Message {
        Message(
            authorSignature: "",
            autoDeleteIn: 0,
            canBeSaved: false,
            chatId: 0,
            containsUnreadMention: false,
            containsUnreadPollVotes: false,
            content: .moc(count),
            date: 0,
            editDate: 0,
            effectId: 0,
            ephemeralMessageId: 0,
            factCheck: nil,
            forwardInfo: nil,
            guestBotCallerId: 0,
            hasTimestampedMedia: false,
            id: 0,
            importInfo: nil,
            interactionInfo: nil,
            isChannelPost: false,
            isFromOffline: false,
            isOutgoing: isOutgoing,
            isPaidGramSuggestedPost: false,
            isPaidStarSuggestedPost: false,
            isPinned: isOutgoing,
            mediaAlbumId: 0,
            paidMessageStarCount: 0,
            receiverId: nil,
            replyMarkup: nil,
            replyTo: nil,
            restrictionInfo: nil,
            schedulingState: nil,
            selfDestructIn: 0,
            selfDestructType: nil,
            senderBoostCount: 0,
            senderBusinessBotUserId: 0,
            senderId: .messageSenderChat(.init(chatId: 0)),
            senderTag: "",
            sendingState: nil,
            suggestedPostInfo: nil,
            summaryLanguageCode: "",
            topicId: 0,
            unreadReactions: [],
            viaBotUserId: 0
        )
    }
}
