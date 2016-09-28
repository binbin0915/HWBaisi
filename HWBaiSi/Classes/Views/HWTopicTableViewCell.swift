//
//  HWTopicTableViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/25.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWTopicTableViewCell: UITableViewCell {
    
    var model: HWTopic? {
        didSet {
            updateUI()
        }
    }
    
    /// 用户信息和正文
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    /// 按钮
    @IBOutlet weak var dingButton: UIButton!
    @IBOutlet weak var caiButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    /// 最热评论
    @IBOutlet weak var hotCommentView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
        profileImageView.layer.cornerRadius = 44.0 / 2.0
        profileImageView.layer.masksToBounds = true
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = self.frame
            newFrame.size.height -= 10
            newFrame.origin.y += 10
            super.frame = newFrame
        }
    }

    private func updateUI() {
        profileImageView.image = nil
        screenNameLabel.text = nil
        createTimeLabel.text = nil
        contentLabel.text = nil
        commentLabel.text = nil
        
        guard let data = model else {
            return
        }
        /// 头像
        if let profileImage = data.profile_image {
            profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: "defaultUserIcon"))
        }
        /// 昵称
        if let screen_name = data.screen_name {
            screenNameLabel.text = screen_name
        }
        /// 时间
        if let created_at = data.created_at {
            
            createTimeLabel.text = created_at
        }
        /// 内容
        if let text = data.text {
            contentLabel.text = text
            contentLabel.frame.size.height = contentLabel.textRect(forBounds: contentLabel.bounds, limitedToNumberOfLines: 0).size.height
        }
        /// 顶
        setupButton(button: dingButton, number: data.ding ?? 0, placeholder: "顶")
        /// 踩
        setupButton(button: caiButton, number: data.cai ?? 0, placeholder: "踩")
        /// 分享
        setupButton(button: shareButton, number: data.repost ?? 0, placeholder: "分享")
        /// 评论
        setupButton(button: commentButton, number: data.comment ?? 0, placeholder: "评论")
        
        /// 热门评论
        if data.top_cmt.count == 0 {
            hotCommentView.isHidden = true
        } else {
            hotCommentView.isHidden = false
            let comment = data.top_cmt[0]
            commentLabel.text = "\(comment.user.username ?? "") : \(comment.content ?? "")"
        }
        
        // 不同类型的内容显示
        if data.type != 29 {
            let nib = UINib(nibName: "HWTopicImageView", bundle: nil)
            let imageView = nib.instantiate(withOwner: HWTopicImageView.self, options: nil).first as! HWTopicImageView
            imageView.topicModel = data
            self.addSubview(imageView)
        }
    }
    
    private func setupButton(button: UIButton, number: NSNumber, placeholder: String) {
        let count = number.intValue
        if count > 10000 {
            button.setTitle(String(format: "%.1f万", number.floatValue / 10000.0), for: .normal)
        } else if count > 0 {
            button.setTitle(String(format: "%zd", count), for: .normal)
        } else {
            button.setTitle(placeholder, for: .normal)
        }
    }

    @IBAction func clickedMoreBtn() {
        let sheetVC = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        sheetVC.addAction(UIAlertAction(title: "收藏", style: .default, handler: { (_) in
            
        }))
        sheetVC.addAction(UIAlertAction(title: "举报", style: .default, handler: { (_)    in
            
        }))
        sheetVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(sheetVC, animated: true, completion: nil)
    }
    
    @IBAction func clickedDingBtn() {
        HWLog("")
    }
    
    @IBAction func clickedCaiBtn() {
        HWLog("")
    }
    
    @IBAction func clickedShareBtn() {
        HWLog("")
    }
    
    @IBAction func clickedCommentBtn() {
        HWLog("")
    }
}
