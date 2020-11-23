//
//  AndesDropdownAbstractView.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

class AndesDropdownAbstractView: UIView, AndesDropdownView {

    @IBOutlet var view: UIView!

    var config: AndesDropdownViewConfig
    weak var delegate: AndesDropdownViewDelegate?

    init(withConfig config: AndesDropdownViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesDropdownViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(view)
        view.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }

    internal func updateView() {
        fatalError("This should be overriden by a subclass")
    }

    func setText(text: String) {
        fatalError("This should be overriden by a subclass")
    }
}
