import UIKit
import CoreData
import Foundation

class WebHandler: URLProtocol, URLSessionDelegate, URLSessionDataDelegate, URLSessionTaskDelegate {

    private var dataTask: URLSessionDataTask?
    private var receivedData: Data?

    override open class func canInit(with request: URLRequest) -> Bool {
        if let path = request.url?.path {
            if (path.starts(with: "/kcs2/index.php")) {
                NotificationCenter.default.post(Notification.init(name: Constants.START_EVENT))
            }
        }
        let key = URLProtocol.property(forKey: Constants.TAG, in: request)
        var intercept = false
        if let url: URL = request.url {
            let method = request.httpMethod ?? ""
            intercept =
                    (key == nil) &&
                            ("GET".caseInsensitiveCompare(method) == ComparisonResult.orderedSame) &&
                            shouldIntercept(url: url)
        }
        return intercept
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open class func requestIsCacheEquivalent(_ aRequest: URLRequest, to bRequest: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, to: bRequest)
    }

    override open func startLoading() {
        let url = self.request.url
        if (CacheManager.shouldCache(url: url) && CacheManager.isFileCached(url: url)) {
            loadResponseFromCache()
        } else {
            loadResponseFromWeb()
        }
    }

    override open func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask = nil
        self.receivedData = nil
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.receivedData = Data()
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        self.receivedData?.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let e = error {
            self.client?.urlProtocol(self, didFailWithError: e)
        } else {
            if (CacheManager.shouldCache(url: self.request.url) &&
                    ("GET".caseInsensitiveCompare(request.httpMethod ?? "") == ComparisonResult.orderedSame)) {
                CacheManager.saveFile(url: self.request.url, data: self.receivedData)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }

    private class func shouldIntercept(url: URL) -> Bool {
        let path = url.path
        return (path.starts(with: "/kcs/") || path.starts(with: "/kcs2/"))
    }

    private func loadResponseFromCache() {
        if let data = CacheManager.readFile(url: self.request.url) {
            let mimeType = Utils.getMimeType(url: self.request.url)
            let size = data.count
            let headers = [
                "Server": "nginx",
                "Content-Type": mimeType,
                "Content-Length": String(format: "%d", arguments: [size]),
                "Connection": "keep-alive",
                "Pragma": "public",
                "Cache-Control": "no-cache",
                "Accept-Ranges": "bytes"
            ]
            let response = HTTPURLResponse(url: self.request.url!, statusCode: 200, httpVersion: "1.1", headerFields: headers)
            self.client!.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            self.client!.urlProtocol(self, didLoad: data)
            self.client!.urlProtocolDidFinishLoading(self)
        } else {
            loadResponseFromWeb()
        }
    }

    private func loadResponseFromWeb() {
        let newRequest = (self.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: Constants.TAG, in: newRequest)
        let defaultConfigObj = URLSessionConfiguration.default
        defaultConfigObj.urlCache = nil
        let defaultSession = Foundation.URLSession(configuration: defaultConfigObj, delegate: self, delegateQueue: nil)
        self.dataTask = defaultSession.dataTask(with: self.request)
        self.dataTask!.resume()
    }

}
