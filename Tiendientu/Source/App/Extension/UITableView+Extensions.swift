//
//  UITableView+Extensions.swift
//  iStudy
//

import UIKit

protocol ReuseID {
    static var kReuseID: String { get }
}

extension ReuseID {
    static var kReuseID: String {
        String(describing: Self.self)
    }
}

protocol TableViewCellProtocol: AnyObject, ReuseID {
    associatedtype ViewModel

    func config(with viewModel: ViewModel, indexPath: IndexPath)
}

extension UITableView {
    func dequeue<Cell>(type: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: ReuseID, Cell: UITableViewCell {
        let id = Cell.kReuseID
        guard let cell = dequeueReusableCell(withIdentifier: id, for: indexPath) as? Cell else {
            fatalError("Dequeue failed for: \(id), at indexPath: \(indexPath.description)")
        }
        return cell
    }

    func dequeue<Cell>(type: Cell.Type) -> Cell where Cell: ReuseID, Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.kReuseID) as? Cell else {
            fatalError("Dequeue failed for: \(Cell.kReuseID)")
        }
        return cell
    }

    func dequeue<Cell>(type: Cell.Type) -> Cell where Cell: ReuseID, Cell: UITableViewHeaderFooterView {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: Cell.kReuseID) as? Cell else {
            fatalError("HeaderFooter dequeue failed for: \(Cell.kReuseID)")
        }
        return cell
    }
}

extension UITableView {
    func createCell<Cell, ViewModel>(_ type: Cell.Type, _ viewModel: ViewModel, _ indexPath: IndexPath) -> Cell
        where Cell: UITableViewCell, Cell: TableViewCellProtocol, Cell.ViewModel == ViewModel {
        let cell = dequeue(type: Cell.self, for: indexPath)
        cell.config(with: viewModel, indexPath: indexPath)
        return cell
    }

    func register<Cell>(type: Cell.Type, identifier: String? = nil, nibName: String? = nil, bundle: Bundle = .main) {
        let cellName = String(describing: type)
        let cellIdentifier = identifier ?? cellName
        let cellNibName = nibName ?? cellName
        register(UINib(nibName: cellNibName, bundle: bundle), forCellReuseIdentifier: cellIdentifier)
    }
}

protocol ReuseIndentifier {
    static var ID: String { get }
}

extension ReuseIndentifier {
    static var ID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIndentifier {}
extension UICollectionViewCell: ReuseIndentifier {}

extension UITableView {
    func dequeue<C: UITableViewCell>(at indexPath: IndexPath) -> C {
        return dequeueReusableCell(withIdentifier: C.ID, for: indexPath) as! C
    }
    
    func register<C: UITableViewCell>(_ cellType: C.Type) {
        if Bundle.main.path(forResource: C.ID, ofType: "nib") != nil {
            let nib = UINib(nibName: C.ID, bundle: .main)
            self.register(nib, forCellReuseIdentifier: C.ID)
        } else {
            self.register(cellType, forCellReuseIdentifier: C.ID)
        }
    }
}

extension UICollectionView {
    func dequeue<C: UICollectionViewCell>(at indexPath: IndexPath) -> C {
        return dequeueReusableCell(withReuseIdentifier: C.ID, for: indexPath) as! C
    }
    
    func register<C: UICollectionViewCell>(_ cellType: C.Type) {
        if Bundle.main.path(forResource: C.ID, ofType: "nib") != nil {
            let nib = UINib(nibName: C.ID, bundle: .main)
            self.register(nib, forCellWithReuseIdentifier: C.ID)
        } else {
            self.register(cellType, forCellWithReuseIdentifier: C.ID)
        }
    }
}
