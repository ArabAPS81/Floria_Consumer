
import Foundation

protocol WebServiceDelegate: class {
    func didRecieveData(data:Codable)
    func didFailToReceiveDataWithError(error: Error)
}
