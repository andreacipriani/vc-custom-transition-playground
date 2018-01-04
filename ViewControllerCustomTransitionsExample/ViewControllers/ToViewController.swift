import Foundation
import UIKit

final class ToViewController: UIViewController {

    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var toTitle: UILabel!
}
