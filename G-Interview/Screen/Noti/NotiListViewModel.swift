//
//  NotiListViewModel.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import Foundation
import UIKit

class NotiListViewModel {
    private let notiAPI = NotiService()
    private var notiModelList = [NotiModel]()
    var notiListBinding: ([NotiSimple]) -> Void = { _ in }
    var errMsgBinding: (String) -> Void = { _ in }
    
    func fetchNotiList() {
        notiAPI.getNotiList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let list):
                self.notiModelList = list
                self.notiListBinding(
                    list.map(self.notiModelToSimple(_:))
                )
            case .failure(let err):
                self.errMsgBinding(err.message)
            }
        }
    }
    private func notiModelToSimple(_ model: NotiModel) -> NotiSimple {
        let attributeText = NSMutableAttributedString(string: model.message.text)
        for offset in model.message.highlights {
            let range = NSRange(location: offset.offset, length: offset.length)
            attributeText.setAttributes(
                [.font: UIFont.boldSystemFont(ofSize: 14)],
                range: range
            )
        }
        var dateText = "Undefined"
        if let date = model.createAt_Date {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy, hh:mm"
            dateText = dateFormat.string(from: date)
        }
        return NotiSimple(
            id: model.id,
            notiText: attributeText,
            dateText: dateText,
            haveRead: model.readAt != 0,
            imgUrl: model.image,
            iconUrl: model.icon
        )
    }
    public func searchNoti(text: String) -> [NotiSimple] {
        //In fact we'll do an api here
        //we are just simulate it
        return notiModelList
            .filter({ $0.message.text.lowercased().contains(text.lowercased()) })
            .map(self.notiModelToSimple(_:))
    }
}


struct NotiSimple: Equatable {
    var id: String
    var notiText: NSAttributedString
    var dateText: String
    var haveRead: Bool
    var imgUrl: String?
    var iconUrl: String?
    
    static func == (lhs: NotiSimple, rhs: NotiSimple) -> Bool {
        return lhs.id == rhs.id
    }
}
