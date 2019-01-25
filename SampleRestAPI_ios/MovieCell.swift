//
//  MovieCell.swift
//  SampleRestAPI_ios
//
//  Created by 박정훈 on 24/01/2019.
//  Copyright © 2019 swift. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell{
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var opendate: UILabel!
    @IBOutlet weak var rating: UILabel!
}
