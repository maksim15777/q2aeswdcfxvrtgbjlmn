// +MessageForwardInfo.swift

import Foundation
import TDLibKit

extension MessageForwardInfo {
    static let moc = MessageForwardInfo(
        date: 0,
        origin: .messageOriginUser(MessageOriginUser(senderUserId: 0)),
        publicServiceAnnouncementType: "",
        source: nil
    )
}
