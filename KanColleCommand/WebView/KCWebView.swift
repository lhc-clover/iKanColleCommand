import Foundation
import WebKit
import SnapKit

class KCWebView: UIWebView {

    func setup(parent: UIView) {
        parent.addSubview(self)
        self.snp.makeConstraints { maker in
            maker.height.equalTo(parent.snp.height)
            maker.width.equalTo(self.snp.height).multipliedBy(Float(15) / Float(9))
            maker.top.equalTo(parent)
            maker.centerX.equalTo(parent)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(gameStart), name: Constants.START_EVENT, object: nil)
        self.mediaPlaybackRequiresUserAction = false
        self.delegate = self
    }

    func load() {
        let url = URL(string: Constants.HOME_PAGE)
        loadRequest(URLRequest(url: url!))
    }

    func loadBlankPage() {
        let url = URL(string: "about:blank")
        loadRequest(URLRequest(url: url!))
    }

    @objc private func gameStart(n: Notification) {
        OperationQueue.main.addOperation {
            self.stringByEvaluatingJavaScript(from: Constants.FULL_SCREEN_SCRIPT)
        }
    }
}

extension KCWebView: UIWebViewDelegate {

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: NavigationType) -> Bool {
        if (request.url?.scheme == "kcwebview") {
            if let params = request.url?.query {
                do {
                    let decoded = params.removingPercentEncoding!
                            .replacingOccurrences(of: "\\n", with: "")
                            .replacingOccurrences(of: " ", with: "")
                    let jsonData = decoded.data(using: .utf8)!
                    let dic = try JSONSerialization.jsonObject(with: jsonData) as? [String: String]
                    let url: String = dic?["url"] ?? ""
                    let header: String = dic?["request"] ?? ""
                    let body: String = dic?["response"] ?? ""
                    if (url.contains("kcsapi")) {
                        Oyodo.attention().api(url: url, request: header, response: body.replacingOccurrences(of: "svdata=", with: ""))
                    }
                } catch {
                    print("Error parse response")
                }
            }
            return false
        }

        return true
    }

    public func webViewDidStartLoad(_ webView: UIWebView) {
    }

    public func webViewDidFinishLoad(_ webView: UIWebView) {
    }

    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }

}
