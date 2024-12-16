import UIKit
import SafariServices
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        if let controller = window?.rootViewController as? FlutterViewController {
            let safariViewControllerChannel = FlutterMethodChannel(name: "com.riddle.paws/open",
                                                                   binaryMessenger: controller.binaryMessenger)

            safariViewControllerChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
                if call.method == "open" {
                    if let args = call.arguments as? [String: Any],
                       let urlString = args["url"] as? String,
                       let url = URL(string: urlString) {

                        let safariVC = SFSafariViewController(url: url)
                        safariVC.preferredBarTintColor = UIColor.clear
                        safariVC.preferredControlTintColor = UIColor.white
                        safariVC.configuration.entersReaderIfAvailable = false

                        let containerVC = ContainerViewController()
                        containerVC.modalPresentationStyle = .fullScreen
                        containerVC.safariViewController = safariVC

                        controller.present(containerVC, animated: false) {
                            containerVC.updateSafariViewControllerFrame()
                        }

                        result(true)
                    } else {
                        result(FlutterError(code: "INVALID_URL", message: "URL is invalid", details: nil))
                    }
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class ContainerViewController: UIViewController, UIScrollViewDelegate {
    var safariViewController: SFSafariViewController?
    private let topCoverView = UIView()
    private let bottomCoverView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let safariVC = safariViewController {
            addChild(safariVC)
            safariVC.view.frame = view.bounds
            view.addSubview(safariVC.view)
            safariVC.didMove(toParent: self)

            if let scrollView = safariVC.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
                scrollView.delegate = self
            }
        }

        setupCoverViews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateSafariViewControllerFrame()
        updateCoverFrames()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }

            if UIDevice.current.orientation.isLandscape {
                self.topCoverView.isHidden = true
                self.bottomCoverView.isHidden = true
            } else {
                self.topCoverView.isHidden = false
                self.bottomCoverView.isHidden = false
            }

            self.updateCoverFrames()
        })
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let alpha = min(max(1 - (offsetY / 100), 0), 1)
        bottomCoverView.alpha = alpha
    }

    func updateSafariViewControllerFrame() {
        guard let safariVC = safariViewController else { return }

        let topInset: CGFloat = -46
        let bottomInset: CGFloat = -75
        let leftInset: CGFloat = 0
        let rightInset: CGFloat = 0

        safariVC.view.frame = CGRect(
            x: leftInset,
            y: topInset,
            width: view.bounds.width - leftInset - rightInset,
            height: view.bounds.height - topInset - bottomInset
        )
    }

    private func setupCoverViews() {
        let coverColor = UIColor(red: 24/255, green: 18/255, blue: 16/255, alpha: 1)

        topCoverView.backgroundColor = UIColor.black
        view.addSubview(topCoverView)

        bottomCoverView.backgroundColor = coverColor
        view.addSubview(bottomCoverView)

        updateCoverFrames()
    }

    private func updateCoverFrames() {
        let topCoverHeight: CGFloat = 55
        let bottomCoverHeight: CGFloat = 30
        let viewWidth = view.bounds.width
        let viewHeight = view.bounds.height

        topCoverView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: topCoverHeight)

        if !bottomCoverView.isHidden {
            bottomCoverView.frame = CGRect(x: 0, y: viewHeight - bottomCoverHeight, width: viewWidth, height: bottomCoverHeight)
        } else {
            bottomCoverView.frame = .zero
        }
    }
}

