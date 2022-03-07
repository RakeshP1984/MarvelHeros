//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import UIKit

public final class StackViewController: UIViewController {
    private var arrangedViewControllers: [UIViewController]

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        return $0
    }(UIStackView())

    public init( axis: NSLayoutConstraint.Axis = .vertical,
                 distribution: UIStackView.Distribution = .fill,
                 _ viewControllers: [UIViewController]) {
        arrangedViewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
        stackView.distribution = distribution
        stackView.axis = axis
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        for controller in arrangedViewControllers {
            addArrangedViewController(controller)
        }
    }

    private func addArrangedViewController(_ viewController: UIViewController) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        stackView.addArrangedSubview( viewController.view )
        viewController.didMove(toParent: self)
    }
}
