//
//  NotiCell.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit
import StackViewHelper
import Kingfisher

class NotiCell: UITableViewCell {
    static let cellID = "NotiCell"
    
    var titleLb: UILabel?
    var timeLb: UILabel?
    var thumbImgV: UIImageView?
    var iconImgV = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constructView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constructView() {
        self.contentView.addFillSubview(
            HStackView(
                UIImageView()
                    .width(56)
                    .cornerRadius(56 / 2)
                    .ratio(1.0)
                    .ref(to: &thumbImgV),
                VStackView(
                    UILabel(text: "Title", font: .systemFont(ofSize: 14), textColor: .equalRGB(26), textAlignment: .left, numberOfLines: 0)
                        .ref(to: &titleLb), //or maybe 6
                    UILabel(text: "Date", font: .systemFont(ofSize: 12), textColor: .equalRGB(128), textAlignment: .left, numberOfLines: 1)
                        .ref(to: &timeLb),
                    configs: [.spacing(4)]
                ),
                configs: [.spacing(12), .alignment(.center)]
            ).pad(horizonal: 12).pad(vertical: 12)
        )
        self.contentView.addSubview(
            iconImgV
                .width(24).ratio(1.0)
                .cornerRadius(12)
                .border(color: .white, width: 2)
        )
        iconImgV.anchor(
            .bottom(thumbImgV!.bottomAnchor),
            .trailing(thumbImgV!.trailingAnchor)
        )
    }
    
    func setData(_ noti: NotiSimple) {
        titleLb?.attributedText = noti.notiText
        timeLb?.text = noti.dateText
        if let imgUrl = noti.imgUrl, let _url = URL(string: imgUrl) {
            thumbImgV?.kf.setImage(with: _url, placeholder: nil)
        }
        contentView.backgroundColor = !noti.haveRead ? .rgb(236, 247, 231) : .white
        if let imgUrl = noti.iconUrl, let _url = URL(string: imgUrl) {
            iconImgV.kf.setImage(with: _url, placeholder: nil)
        }
    }
}
