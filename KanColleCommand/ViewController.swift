import UIKit
import SnapKit
import WebKit
import RxSwift

class ViewController: UIViewController {

    static let DEFAULT_BACKGROUND = UIColor(white: 0.188, alpha: 1)
    private var webView: KCWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.black

        webView = KCWebView()
        webView.setup(parent: self.view)
        webView.load()
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never;
        }

        let refreshBtn = UIButton(type: .custom)
        refreshBtn.setImage(UIImage(named: "reload.png"), for: .normal)
        self.view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { maker in
            maker.width.equalTo(48)
            maker.height.equalTo(48)
            maker.right.equalTo(webView.snp.left).offset(-8)
            maker.centerY.equalTo(webView.snp.centerY)
        }
        refreshBtn.addTarget(self, action: #selector(confirmRefresh), for: .touchUpInside)

        let drawer = Drawer()
        drawer.attachTo(controller: self)
    }

    @objc func confirmRefresh() {
        let dialog = UIAlertController(title: nil, message: "刷新", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        dialog.addAction(UIAlertAction(title: "确定", style: .default) { action in
            self.webView.loadBlankPage()
            self.webView.load()
        })
        self.present(dialog, animated: true)
    }

}
