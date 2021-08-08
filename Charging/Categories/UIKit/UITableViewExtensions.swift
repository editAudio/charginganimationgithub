////
////  UITableViewExtensions.swift
////  SwifterSwift
////
////  Created by Omar Albeik on 8/22/16.
////  Copyright © 2016 SwifterSwift
////
//
//#if canImport(UIKit) && !os(watchOS)
//import UIKit
////import SwiftPullToRefresh
//import CRRefresh
//// MARK: - Properties
//public extension UITableView {
//
//    /// SwifterSwift: Index path of last row in tableView.
//    var indexPathForLastRow: IndexPath? {
//        guard let lastSection = lastSection else { return nil }
//        return indexPathForLastRow(inSection: lastSection)
//    }
//
//    /// SwifterSwift: Index of last section in tableView.
//    var lastSection: Int? {
//        return numberOfSections > 0 ? numberOfSections - 1 : nil
//    }
//
//}
//
//// MARK: - Methods
//public extension UITableView {
//
//    /// SwifterSwift: Number of all rows in all sections of tableView.
//    ///
//    /// - Returns: The count of all rows in the tableView.
//    func numberOfRows() -> Int {
//        var section = 0
//        var rowCount = 0
//        while section < numberOfSections {
//            rowCount += numberOfRows(inSection: section)
//            section += 1
//        }
//        return rowCount
//    }
//
//    /// SwifterSwift: IndexPath for last row in section.
//    ///
//    /// - Parameter section: section to get last row in.
//    /// - Returns: optional last indexPath for last row in section (if applicable).
//    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
//        guard numberOfSections > 0, section >= 0 else { return nil }
//        guard numberOfRows(inSection: section) > 0  else {
//            return IndexPath(row: 0, section: section)
//        }
//        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
//    }
//
//    /// Reload data with a completion handler.
//    ///
//    /// - Parameter completion: completion handler to run after reloadData finishes.
//    func reloadData(_ completion: @escaping () -> Void) {
//        UIView.animate(withDuration: 0, animations: {
//            self.reloadData()
//        }, completion: { _ in
//            completion()
//        })
//    }
//
//    /// SwifterSwift: Remove TableFooterView.
//    func removeTableFooterView() {
//        tableFooterView = nil
//    }
//
//    /// SwifterSwift: Remove TableHeaderView.
//    func removeTableHeaderView() {
//        tableHeaderView = nil
//    }
//
//    /// SwifterSwift: Scroll to bottom of TableView.
//    ///
//    /// - Parameter animated: set true to animate scroll (default is true).
//    func scrollToBottom(animated: Bool = true) {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
//        setContentOffset(bottomOffset, animated: animated)
//    }
//
//    func scrollToPositionY(positionY: CGFloat, animated: Bool = true) {
//        let bottomOffset = CGPoint(x: 0, y: positionY)
//        setContentOffset(bottomOffset, animated: animated)
//    }
//
//
//    /// SwifterSwift: Scroll to top of TableView.
//    ///
//    /// - Parameter animated: set true to animate scroll (default is true).
//    func scrollToTop(animated: Bool = true) {
//        setContentOffset(CGPoint.zero, animated: animated)
//    }
//
//    /// SwifterSwift: Dequeue reusable UITableViewCell using class name
//    ///
//    /// - Parameter name: UITableViewCell type
//    /// - Returns: UITableViewCell object with associated class name.
//    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
//            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
//        }
//        return cell
//    }
//
//    /// SwifterSwift: Dequeue reusable UITableViewCell using class name for indexPath
//    ///
//    /// - Parameters:
//    ///   - name: UITableViewCell type.
//    ///   - indexPath: location of cell in tableView.
//    /// - Returns: UITableViewCell object with associated class name.
//    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
//            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
//        }
//        return cell
//    }
//
//    /// SwifterSwift: Dequeue reusable UITableViewHeaderFooterView using class name
//    ///
//    /// - Parameter name: UITableViewHeaderFooterView type
//    /// - Returns: UITableViewHeaderFooterView object with associated class name.
//    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
//        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
//            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
//        }
//        return headerFooterView
//    }
//
//    /// SwifterSwift: Register UITableViewHeaderFooterView using class name
//    ///
//    /// - Parameters:
//    ///   - nib: Nib file used to create the header or footer view.
//    ///   - name: UITableViewHeaderFooterView type.
//    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
//        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
//    }
//
//    /// SwifterSwift: Register UITableViewHeaderFooterView using class name
//    ///
//    /// - Parameter name: UITableViewHeaderFooterView type
//    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
//        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
//    }
//
//    /// SwifterSwift: Register UITableViewCell using class name
//    ///
//    /// - Parameter name: UITableViewCell type
//    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
//        register(T.self, forCellReuseIdentifier: String(describing: name))
//    }
//
//    /// SwifterSwift: Register UITableViewCell using class name
//    ///
//    /// - Parameters:
//    ///   - nib: Nib file used to create the tableView cell.
//    ///   - name: UITableViewCell type.
//    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
//        register(nib, forCellReuseIdentifier: String(describing: name))
//    }
//
//    /// SwifterSwift: Register UITableViewCell with .xib file using only its corresponding class.
//    ///               Assumes that the .xib filename and cell class has the same name.
//    ///
//    /// - Parameters:
//    ///   - name: UITableViewCell type.
//    ///   - bundleClass: Class in which the Bundle instance will be based on.
//    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
//        let identifier = String(describing: name)
//        var bundle: Bundle?
//
//        if let bundleName = bundleClass {
//            bundle = Bundle(for: bundleName)
//        }
//
//        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
//    }
//
//    /// SwifterSwift: Check whether IndexPath is valid within the tableView
//    ///
//    /// - Parameter indexPath: An IndexPath to check
//    /// - Returns: Boolean value for valid or invalid IndexPath
//    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
//        return indexPath.section >= 0 &&
//            indexPath.row >= 0 &&
//            indexPath.section < numberOfSections &&
//            indexPath.row < numberOfRows(inSection: indexPath.section)
//    }
//
//    /// SwifterSwift: Safely scroll to possibly invalid IndexPath
//    ///
//    /// - Parameters:
//    ///   - indexPath: Target IndexPath to scroll to
//    ///   - scrollPosition: Scroll position
//    ///   - animated: Whether to animate or not
//    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
//        guard indexPath.section < numberOfSections else { return }
//        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
//        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
//    }
//}
//
//
//#endif
//
//
//extension UICollectionView {
//
//    func setupEmptyView() -> EmptyView {
//        let view = EmptyView.loadFromNib(named: "EmptyView") as! EmptyView
//        self.backgroundView = view
//        view.snp.makeConstraints { (make) in
//            make.width.height.equalToSuperview()
//        }
//        return view
//    }
//
////    func setupEmptyView(_ title : String?, desc : String?) {
////        guard let emptyView = self.backgroundView as? EmptyView else {
////            let view = EmptyView.loadFromNib(named: "EmptyView") as! EmptyView
////            self.backgroundView = view
////            view.snp.makeConstraints { (make) in
////                make.width.height.equalToSuperview()
////            }
////            view.isHidden = true
////            view.setuiWithTitle(title, desc: desc)
////            return
////        }
////        emptyView.isHidden = true
////        emptyView.setuiWithTitle(title, desc: desc)
////    }
////
////    func showEmptyView(_ show : Bool, message : String? = nil) {
////        guard let emptyView = self.backgroundView  as? EmptyView else {return}
////        emptyView.isHidden = !show
////        if let _message = message {
////            emptyView.lbTitle.text = _message
////        }
////    }
//}
//extension UITableView {
//
//    func scroll(to: scrollsTo, animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
//            let numberOfSections = self.numberOfSections
//            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
//            switch to{
//            case .top:
//                if numberOfRows > 0 {
//                    let indexPath = IndexPath(row: 0, section: 0)
//                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
//                }
//                break
//            case .bottom:
//                if numberOfRows > 0 {
//                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
//                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
//                }
//                break
//            }
//        }
//    }
//
//    enum scrollsTo {
//        case top,bottom
//    }
//
//    func setupEmptyView() -> EmptyView {
//        let view = EmptyView.loadFromNib(named: "EmptyView") as! EmptyView
//        self.backgroundView = view
//        view.snp.makeConstraints { (make) in
//            make.width.height.equalToSuperview()
//        }
//        return view
//    }
//
////    func setupEmptyView(_ title : String?, desc : String?) {
////        guard let emptyView = self.backgroundView as? EmptyView else {
////            let view = EmptyView.loadFromNib(named: "EmptyView") as! EmptyView
////            self.backgroundView = view
////            view.snp.makeConstraints { (make) in
////                make.width.height.equalToSuperview()
////            }
////            view.isHidden = true
////            view.setuiWithTitle(title, desc: desc)
////            return
////        }
////        emptyView.isHidden = true
////        emptyView.setuiWithTitle(title, desc: desc)
////    }
////
////    func showEmptyView(_ show : Bool, message : String? = nil) {
////        guard let emptyView = self.backgroundView  as? EmptyView else {return}
////        emptyView.isHidden = !show
////        if let _message = message {
////            emptyView.lbTitle.text = _message
////        }
////    }
//
//    func crHeadRefresh(completion: @escaping(()->Void)) {
//        self.cr.addHeadRefresh(animator: FastAnimator()) {
//            //            isShowLoadding = false
//            completion()
//        }
//    }
//
//    func crFootRefresh(completion: @escaping(()->Void)) {
//        self.cr.addFootRefresh(animator: FastAnimator()) {
//            //            isShowLoadding = false
//            completion()
//        }
//    }
//
//    func crEndRefresh() {
//        self.cr.endHeaderRefresh()
//        self.cr.endLoadingMore()
//    }
//}