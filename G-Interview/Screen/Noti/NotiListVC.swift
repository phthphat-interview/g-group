//
//  ViewController.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit
import StackViewHelper
import DeclarativeStyle

class NotiListVC: UIViewController {
    
    private let viewModel = NotiListViewModel()
    
    public var notiList = [NotiSimple]()
    private var searchedList = [NotiSimple]()
    
    private var tbV = UITableView(frame: .zero, style: .plain)
    private var searchBtn: UIButton?
    private var noticeLb: UILabel?
    private var searchWrapV: UIView?
    private var searchTF: UITextField?
    
    //MARK: State
    private var enterSearch: Bool = false {
        didSet {
            searchBtn?.setImage(UIImage(named: enterSearch ? "x_stroked" : "search"), for: .normal)
            UIView.animate(withDuration: 0.1) { [self] in
                noticeLb?.isHiddenInStackView = enterSearch
                searchWrapV?.isHiddenInStackView = !enterSearch
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructView()
        subscription()
        setUpView()
        initState()
        
        viewModel.fetchNotiList()
    }
    
    private func constructView() {
        self.view.backgroundColor = .white
        self.view.addFillSubview(
            VStackView(
                //Header
                HStackView(
                    UILabel(text: "Thông báo", font: .boldSystemFont(ofSize: 28), textColor: .black, textAlignment: .left, numberOfLines: 1)
                        .ref(to: &noticeLb),
                    UIButton(image: UIImage(named: "search")!, tintColor: .black)
                        .ref(to: &searchBtn)
                        .width(44)
                        .ratio(1.0)
                        .onEvent { [weak self] _ in
                            guard let self = self else { return }
                            self.enterSearch.toggle()
                            self.enterSearch ? self.searchTF?.becomeFirstResponder() : self.view.endEditing(true)
                            self.searchTF?.text = ""
                            self.tbV.reloadData()
                        },
                    //Search text field
                    WrapView(
                        HStackView(
                            UIImageView(image: UIImage(named: "search")?.withRenderingMode(.alwaysTemplate))
                                .tintColor(.equalRGB(128))
                                .width(20).ratio(1.0),
                            UITextField(placeholder: "Tìm kiếm", font: .systemFont(ofSize: 16))
                                .ref(to: &searchTF),
                            UIButton(image: UIImage(named: "x_filled")!, tintColor: .equalRGB(128))
                                .ratio(1.0)
                                .width(26)
                                .onEvent{ [weak self] _ in
                                    self?.searchTF?.text = ""
                                    self?.onSearch(text: "")
                                },
                            configs: [.alignment(.center), .spacing(10)]
                        ).pad(horizonal: 12)
                    )
                        .background(color: .equalRGB(245))
                        .height(40)
                        .cornerRadius(20)
                        .ref(to: &searchWrapV),
                    configs: [.spacing(10), .alignment(.center)]
                ).height(44).pad(horizonal: 12),
                tbV
            ),
            inSafeArea: .exceptBottom
        )
    }
    
    private func setUpView() {
        self.tbV.separatorStyle = .none
        tbV.dataSource = self; tbV.delegate = self
        tbV.keyboardDismissMode = .onDrag
        tbV.register(NotiCell.self, forCellReuseIdentifier: NotiCell.cellID)
        self.searchTF?.onEvent(.editingChanged, { [weak self] _ in
            guard let self = self else { return }
            //Maybe I'll use debounce or throttle here, but I'm too lazy
            self.onSearch(text: self.searchTF?.text ?? "")
        })
    }
    private func initState() {
        enterSearch = false
    }
    func subscription() {
        viewModel.notiListBinding = { [unowned self] notiList in
            self.notiList += notiList
            self.tbV.reloadData()
        }
    }
    func onSearch(text: String) {
        let newSearchedList = self.viewModel.searchNoti(text: text)
        let needReloadData = newSearchedList != self.searchedList
        self.searchedList = newSearchedList
        if needReloadData {
            self.tbV.reloadData()
        }
    }
}

extension NotiListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        enterSearch ? searchedList.count : notiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotiCell.cellID) as! NotiCell
        let item = enterSearch ? searchedList[indexPath.row] : notiList[indexPath.row]
        cell.setData(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = enterSearch ? searchedList[indexPath.row] : notiList[indexPath.row]
        item.haveRead = true
        if enterSearch {
            searchedList[indexPath.row] = item
            //also update in for main list
            if let firstIdx = notiList.firstIndex(where: {$0.id == item.id}) {
                var _item = notiList[firstIdx]
                _item.haveRead = true
                notiList[firstIdx] = _item
            }
        } else { notiList[indexPath.row] = item }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


extension UIImageView {
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}
