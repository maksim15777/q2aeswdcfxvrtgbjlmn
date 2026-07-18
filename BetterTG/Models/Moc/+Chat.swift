// +Chat.swift

import SwiftUI
import TDLibKit

extension Chat {
    static let moc = Chat(
        accentColorId: 0,
        actionBar: nil,
        availableReactions: nil,
        background: nil,
        backgroundCustomEmojiId: 0,
        blockList: nil,
        businessBotManageBar: nil,
        canBeDeletedForAllUsers: false,
        canBeDeletedOnlyForSelf: false,
        canBeReported: false,
        chatLists: [],
        clientData: "",
        defaultDisableNotification: false,
        draftMessage: nil,
        emojiStatus: nil,
        hasProtectedContent: false,
        hasScheduledMessages: false,
        id: 0,
        isMarkedAsUnread: false,
        isTranslatable: false,
        lastMessage: nil,
        lastReadInboxMessageId: 0,
        lastReadOutboxMessageId: 0,
        messageAutoDeleteTime: 0,
        messageSenderId: nil,
        notificationSettings: .moc,
        pendingJoinRequests: nil,
        permissions: .moc,
        photo: nil,
        positions: [],
        profileAccentColorId: 0,
        profileBackgroundCustomEmojiId: 0,
        replyMarkupMessageId: 0,
        theme: nil,
        title: "titletitletitle",
        type: .chatTypePrivate(.init(userId: 0)),
        unreadCount: 0,
        unreadMentionCount: 0,
        unreadPollVoteCount: 0,
        unreadReactionCount: 0,
        upgradedGiftColors: nil,
        videoChat: .init(defaultParticipantId: nil, groupCallId: 0, hasParticipants: false),
        viewAsTopics: false
    )
}
