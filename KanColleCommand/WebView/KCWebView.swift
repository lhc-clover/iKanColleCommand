import Foundation
import WebKit
import SnapKit

class KCWebView: UIWebView {

    func setup(parent: UIView) {
        parent.addSubview(self)
//        let height = parent.safeAreaLayoutGuide.snp.height
//        let width = height / 9 * 15
        self.snp.makeConstraints { maker in
            maker.height.equalTo(parent.safeAreaLayoutGuide.snp.height)
            maker.width.equalTo(self.snp_height).multipliedBy(Float(15) / Float(9))
            maker.top.equalTo(parent)
            maker.centerX.equalTo(parent)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(gameStart), name: Constants.START_EVENT, object: nil)
    }

    func load() {
        let url = URL(string: Constants.HOME_PAGE)
        loadRequest(URLRequest(url: url!))
    }

    @objc private func gameStart(n: Notification) {
        OperationQueue.main.addOperation {
            self.stringByEvaluatingJavaScript(from: Constants.FULL_SCREEN_SCRIPT)
        }
    }

}