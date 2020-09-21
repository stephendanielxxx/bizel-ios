

import UIKit

class IsiMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var namaMember: UILabel!
    @IBOutlet weak var namaInstitusi: UILabel!
    @IBOutlet weak var statusMember: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
