//
//  AndesList.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 16/10/20.
//

import Foundation

/**
 This class is a custom UITableView to AndesUI
*/
@objc public class AndesList: UIView {

    /// Set the delegate to use own methods
    @objc public weak var delegate: AndesListDelegate?

    /// Set the dataSource to use own methods
    @objc public weak var dataSource: AndesListDataSource?

    /// Set the separator style, default value .none
    @objc public var separatorStyle: AndesSeparatorStyle = .none

    /// Set the selection style, default value .default
    @objc public var selectionStyle: AndesSelectionStyle = .defaultStyle

    /// Set the list type, default value simple
    @objc public var listType: AndesCellType = .simple

    /// Set the list size, default value medium
    @objc public var size: AndesListSize = .medium

    /// This method reload the data
    @objc public func reloadData() {
        self.tableView.reloadData()
    }

    public init(type: AndesCellType = .simple) {
        super.init(frame: .zero)
        self.listType = type
        setup()
    }

    private var tableView: UITableView = UITableView()
    private var internalDataSource: AndesListTableViewDataSource?
    // swiftlint:disable weak_delegate
    private var internalDelegate: AndesListTableViewDelegate?
    // swiftlint:enable weak_delegate

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Setup delegates and register UITableViewCell on the UITableView
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = .none
        self.tableView.separatorInset.left = UIScreen.main.bounds.width
        setupDelegates()
        registerNib()
        drawContentView()
    }

    private func setupDelegates() {
        internalDataSource = AndesListTableViewDataSource(listProtocol: self)
        internalDelegate = AndesListTableViewDelegate(listProtocol: self)
        self.tableView.delegate = internalDelegate
        self.tableView.dataSource = internalDataSource
    }

    private func registerNib() {
        tableView.register(UINib(nibName: "AndesListSimpleViewCell",
                                 bundle: AndesBundle.bundle()),
                           forCellReuseIdentifier: "AndesListSimpleViewCell")
        tableView.register(UINib(nibName: "AndesListChevronViewCell",
                                 bundle: AndesBundle.bundle()),
                           forCellReuseIdentifier: "AndesListChevronViewCell")
    }

    private func drawContentView() {
        addSubview(self.tableView)
        self.tableView.pinToSuperview()
    }
}

/// Use (UITableViewDelegate and UITableViewDatasource) in a independent protocol
extension AndesList: AndesListProtocol {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections(self) ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.andesList(self, numberOfRowsInSection: section) ?? 0
    }

    func cellForRowAt(indexPath: IndexPath) -> AndesListCell {
        guard let customCell = dataSource?.andesList(self, cellForRowAt: indexPath),
              customCell.type == listType else {
            fatalError("Cell type not allowed, should be \(listType.toString()) type")
        }
        customCell.updateSize(size: self.size)
        return customCell
    }

    func getSeparatorStyle() -> AndesSeparatorStyle {
        return self.separatorStyle
    }

    func didSelectRowAt(indexPath: IndexPath) {
        self.delegate?.andesList?(self, didSelectRowAt: indexPath)
    }

    func getSelectionStyle() -> UITableViewCell.SelectionStyle {
        switch selectionStyle {
        case .none:
            return .none
        case .blue:
            return .blue
        case .gray:
            return .gray
        case .defaultStyle:
            return .default
        }
    }
}

extension AndesList {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'listType' instead.")
    @IBInspectable public var ibType: String {
        get {
            return self.listType.toString()
        }
        set(val) {
            self.listType = AndesCellType.checkValidEnum(property: "IB type", key: val)
        }
    }
}
