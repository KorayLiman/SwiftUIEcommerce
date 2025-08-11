//
//  DIContainer.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Swinject

final class DIContainer {
    static let shared = DIContainer()
    
    private let container: Container
    let synchronizedResolver: Resolver
    
    private init() {
        container = Container()
        synchronizedResolver = container.synchronize()
        
        container.register(ToastManager.self) { _ in
            ToastManager()
        }.inObjectScope(.container)
        container.register(ECLoader.self) { _ in
            ECLoader()
        }.inObjectScope(.container)
        container.register(Navigator.self, name: Navigators.rootNavigator.rawValue) { _ in
            Navigator()
        }.inObjectScope(.container)
     
        container.register(IUserDefaultsManager.self) { _ in
            UserDefaultsManager()
        }.inObjectScope(.container)
        
        container.register(NetworkManager.self) { _ in
            let baseURL = AppConstants.baseUrl
            return NetworkManager(baseURL: baseURL)
        }
        .inObjectScope(.container)
        container.register(IAuthRepository.self) { _ in
            AuthRepository()
        }
        .inObjectScope(.container)
        
        container.register(ILoginRepository.self) { _ in
            LoginRepository(loginRemoteDS: LoginRemoteDS())
        }.inObjectScope(.container)
        container.register(IForgotPasswordRepository.self) { _ in
            ForgotPasswordRepository(forgotPasswordRemoteDS: ForgotPasswordRemoteDS())
        }.inObjectScope(.container)
        container.register(IResetPasswordRepository.self) { _ in
            ResetPasswordRepository(resetPasswordRemoteDS: ResetPasswordRemoteDS())
        }.inObjectScope(.container)
        container.register(IProductListRepository.self) { _ in
            ProductListRepository(productListRemoteDS: ProductListRemoteDS())
        }.inObjectScope(.container)
        container.register(ICartRepository.self) { _ in
            CartRepository(cartRemoteDS: CartRemoteDS())
        }.inObjectScope(.container)
        container.register(IOrderRepository.self) { _ in
            OrderRepository(orderRemoteDS: OrderRemoteDS())
        }.inObjectScope(.container)
        container.register(IChangePasswordRepository.self) { _ in
            ChangePasswordRepository(changePasswordRemoteDS: ChangePasswordRemoteDS())
        }
    }
}
