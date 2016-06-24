import Marshroute

final class MediaPickerRouterImpl: BaseRouter, MediaPickerRouter {
    
    typealias AssemblyFactory = protocol<ImageCroppingAssemblyFactory, PhotoLibraryAssemblyFactory>

    private let assemblyFactory: AssemblyFactory

    init(assemblyFactory: AssemblyFactory, routerSeed: RouterSeed) {
        self.assemblyFactory = assemblyFactory
        super.init(routerSeed: routerSeed)
    }

    // MARK: - PhotoPickerRouter

    func showPhotoLibrary(
        maxSelectedItemsCount maxSelectedItemsCount: Int?,
        configuration: PhotoLibraryModule -> ()
    ) {
        pushViewControllerDerivedFrom { routerSeed in
            
            let assembly = assemblyFactory.photoLibraryAssembly()
            
            return assembly.module(
                maxSelectedItemsCount: maxSelectedItemsCount,
                routerSeed: routerSeed,
                configuration: configuration
            )
        }
    }
    
    func showCroppingModule(photo photo: MediaPickerItem, moduleOutput: ImageCroppingModuleOutput) {
        pushViewControllerDerivedFrom { routerSeed in
            let assembly = assemblyFactory.imageCroppingAssembly()
            return assembly.viewController(photo: photo, moduleOutput: moduleOutput, routerSeed: routerSeed)
        }
    }
}