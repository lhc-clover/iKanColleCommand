import UIKit
import SnapKit
import WebKit
import RxSwift

class ViewController: UIViewController {

    static let DEFAULT_BACKGROUND = UIColor(white: 0.188, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.black

        let webView = KCWebView()
        webView.setup(parent: self.view)
        webView.load()
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never;
        }

        let drawer = Drawer()
        drawer.attachTo(controller: self)
    }

}
