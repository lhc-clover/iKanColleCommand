import UIKit
import SnapKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.black
        let webView = KCWebView.init()
        webView.setup(parent: self.view)
        webView.load()
    }

}
