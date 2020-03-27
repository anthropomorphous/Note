import Foundation
import WebKit

protocol AuthViewControllerDelegate: class {
    func handleTokenChanged(token: String)
}

final class AuthenticationViewController: UIViewController {

    weak var delegate: AuthViewControllerDelegate?

    private let webView = WKWebView()
    private let clientId = "" //paste this

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        guard let request = tokenGetRequest else { return }
        webView.load(request)
        webView.navigationDelegate = self
    }

    private func setupViews() {
        view.backgroundColor = .white

        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private var tokenGetRequest: URLRequest? {
     //   let urlForToken = "https://github.com/login/oauth/access_token"
     //   let url = "https://github.com/login/oauth"
     //   let smth = "https://github.com/login/oauth/authorize"
        guard var urlComponents = URLComponents(string: "https://oauth.github.com/authorize") else { return nil }

        urlComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "client_id", value: "\(clientId)")
        ]

        guard let url = urlComponents.url else { return nil }

        return URLRequest(url: url)
    }
}

extension AuthenticationViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme == scheme {
            let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            guard let components = URLComponents(string: targetString) else { return }

            if let token = components.queryItems?.first(where: { $0.name == "access_token" })?.value {
                delegate?.handleTokenChanged(token: token)
            }
            dismiss(animated: true, completion: nil)
        }
        do {
            decisionHandler(.allow)
        }
    }
}

private let scheme = "myphotos" // схема для callback
