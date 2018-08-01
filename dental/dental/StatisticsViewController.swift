//
//  StatisticsViewController.swift
//  dental
//
//  Created by Lâm Phạm on 7/31/18.
//  Copyright © 2018 SPJ. All rights reserved.
//

import UIKit
import harpyframework

enum QuickSelectItemType {
    case today
    case yesterday
    case thisMonth
    case lastMonth
    
}

class QuickSelectItem: NSObject {
    var type: QuickSelectItemType = .today
    
    init(type: QuickSelectItemType) {
        self.type = type
    }
    
    
    func getName() -> String {
        switch self.type {
        case .today:
            return "Hôm nay"
        case .yesterday:
            return "Hôm qua"
        case .thisMonth:
            return "Tháng này"
        case .lastMonth:
            return "Tháng trước"
        }
    }
}

class StatisticsViewController: BaseParentViewController {

    @IBOutlet weak var boxAgency: BorderSelectBox!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var heightQuickSelect: NSLayoutConstraint!
    @IBOutlet weak var cltvQuickSelect: UICollectionView!
    @IBOutlet weak var boxToDate: BorderSelectBox!
    @IBOutlet weak var boxFromDate: BorderSelectBox!
    
    let cellID = "QuickSelectCollectionViewCell"
    var listSelect: [QuickSelectItem] = []
    var selectedAgents: [Agent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBar(title: "Thống kê")
        btnSearch.drawRadius(6, color: .clear, thickness: 0)
        boxFromDate.set(placeholder: "Từ ngày", img: #imageLiteral(resourceName: "ic_calendar"), type: .datePicker)
        boxToDate.set(placeholder: "Đến ngày", img: #imageLiteral(resourceName: "ic_calendar"), type: .datePicker)
        boxAgency.set(placeholder: "Chọn chi nhánh", img: #imageLiteral(resourceName: "ic_next"), type: .normal)
        boxAgency.delegate = self
        boxToDate.delegate = self
        boxFromDate.delegate = self
        cltvQuickSelect.delegate = self
        cltvQuickSelect.dataSource = self
        cltvQuickSelect.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
        cltvQuickSelect.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        initItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }

    func initItem() {
        listSelect = [QuickSelectItem(type: .today), QuickSelectItem(type: .yesterday), QuickSelectItem(type: .thisMonth), QuickSelectItem(type: .lastMonth)]
        heightQuickSelect.constant = CGFloat(listSelect.count) * (30.0 + 4.0) + 30.0
    }
    
    func getWidthItem(withText text: String) -> CGFloat {
        var output:CGFloat = 0
        let font = UIFont.systemFont(ofSize: 14)
        let size = (text as NSString).size(attributes: [NSFontAttributeName: font])
        if text.count < 5 {
            if UIDevice.current.model == DeviceModel.iPhone5.rawValue {
                output = size.width + 32
            }
            else {
                output = size.width + 42
            }
        }
        else {
            if UIDevice.current.model == DeviceModel.iPhone5.rawValue {
                output = size.width + 52
            }
            else {
                output = size.width + 62
            }
        }
        return output
    }
    @IBAction func btnSearchAction(_ sender: Any) {
        let vc = StatisticsDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension StatisticsViewController: BorderSelectBoxDelegate {
    func borderSelectBoxDidTouch(box: BorderSelectBox) {
        if box == boxAgency {
            let vc = ListAgencyViewController(selectedAgents: self.selectedAgents)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func borderSelectBoxDidTouchDidFinishPickDate(box: BorderSelectBox) {
        if box == boxFromDate {
            
        }
        if box == boxToDate {
            
        }
    }
}

extension StatisticsViewController: ListAgencyViewControllerDelegate {
    func ListAgencyViewControllerDidPick(listAgency: [Agent]) {
        selectedAgents = listAgency
    }
}

extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSelect.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! QuickSelectCollectionViewCell
        cell.loadText(listSelect[indexPath.row].getName())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 100)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthItem: CGFloat = 0
        let word = listSelect[indexPath.row].getName()
        widthItem = getWidthItem(withText: word)
        return CGSize(width: widthItem, height: 30)
    }
}














