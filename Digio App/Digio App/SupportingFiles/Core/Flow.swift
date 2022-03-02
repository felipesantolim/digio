//
//  Flow.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

public enum Presentation {
    case modal(viewController: UIViewController)
    case push(navigation: UINavigationController)
    case none
}

public protocol Flow: AnyObject {
    var disposeBag: DisposeBag? { get set }
    var navigation: UINavigationController { get set }
    func start()
    func start(screen: UIViewController, presentation: Presentation, animated: Bool)
    func next(screen: UIViewController, animated: Bool)
}

public protocol Step {}
public protocol Stepper: AnyObject {
    associatedtype ViewModelSteps: Step
    var selectedStep: BehaviorRelay<ViewModelSteps?> { get set }
}

public class MainFlow: Flow {
    
    public var disposeBag: DisposeBag? = DisposeBag()
    public var navigation: UINavigationController
    
    var window: UIWindow?
    var homeFlow: HomeFlow?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start() {
        homeFlow = HomeFlow(navigation: navigation)
        homeFlow?.start()
    }
}

public extension Flow {
    func start(screen: UIViewController, presentation: Presentation,
               animated: Bool = true) {
        
        switch presentation {
        case .modal: break
        case .push(let navigation):
            self.navigation = navigation
            guard navigation.viewControllers.firstIndex(of: screen) == nil else { return }
            navigation.pushViewController(screen, animated: true)
        case .none:
            break
        }
    }
}

public extension Flow {
    func next(screen: UIViewController, animated: Bool = true) {
        guard navigation.viewControllers.firstIndex(of: screen) == nil else { return }
        navigation.pushViewController(screen, animated: animated)
    }
}
