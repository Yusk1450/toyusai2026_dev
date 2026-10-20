//
//  ViewController.swift
//  Toyusai2026
//
//  Created by ISHIGO Yusuke on 2026/10/09.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Alamofire
import SwiftyJSON

class chatViewController: MessagesViewController
{
    
    @IBOutlet weak var headerView: UIView?
    
    //メッセージまわり
    var messageList: [MockMessage] = []
    lazy var formatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    //タイマー周り
    var remainGameTime = 600
    var gameTimer:Timer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messagesCollectionView.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 30/255, alpha: 1.0)

        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        // メッセージ入力時に一番下までスクロール
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.messageList = self.getMessages()
        self.messagesCollectionView.reloadData()
        DispatchQueue.main.async
        {
            self.messagesCollectionView.scrollToBottom()
        }
    }
    //メッセージ受け取り
    func getMessages() -> [MockMessage]
    {
        //送る画像を入れる
        let myImageAsset = UIImage(named: "list") ?? UIImage()
        return [
            createMessage(text: "今年度の伊志郷ゼミの在籍者リストです メッセージを押すと、画面が開きます"),
            
            MockMessage(
                        image: myImageAsset,
                        sender: otherSender(),
                        messageId: UUID().uuidString,
                        date: Date()
                        )
        ]
    }
    func createMessage(text: String) -> MockMessage
    {
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont(name: "ShipporiMincho-SemiBold", size: 16),
                                                                           .foregroundColor: UIColor.white])
        return MockMessage(attributedText: attributedText, sender: otherSender(), messageId: UUID().uuidString, date: Date())
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toPopup"
    {
        if let popUpVC = segue.destination as? popUpViewController {
        }
    }
}

// MARK: - MessagesDataSource
extension chatViewController: MessagesDataSource
{
    
    // MessageKit が要求する型（SenderType）を返すように修正
    func currentSender() -> SenderType
    {
        return Sender(id: "1", displayName: "自分")
    }
    
    func otherSender() -> Sender
    {
        return Sender(id: "2", displayName: "伊志郷先生")
    }
    
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int
    {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType
    {
        return messageList[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    {
        return nil
    }
    
    // メッセージの上に文字を表示（名前）
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    {
        // 一つ前と同じ人かチェック
        if indexPath.section > 0 {
            let prevSender = messageList[indexPath.section - 1].sender.senderId
            if prevSender == message.sender.senderId {
                return nil
            }
        }
        
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [.font: UIFont(name: "ShipporiMincho-SemiBold", size: 16),
                                                             .foregroundColor: UIColor(red: 181/255, green: 98/255, blue: 3/255, alpha: 1.0)])
        
    }
    
}

// MARK: - MessagesDisplayDelegate
extension chatViewController: MessagesDisplayDelegate
{
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return isFromCurrentSender(message: message) ?
            UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 0) :
            UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 0)
    }
    
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle
//    {
//
//        if case .photo = message.kind {
//            // 完全な四角にする
//            return .custom { view in
//                view.layer.cornerRadius = 0 // 角丸を 0 にする（
//                view.layer.masksToBounds = true
//            }
//        }
//
//        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
//        return .bubbleTail(corner, .curved)
//
//    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView)
    {
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.setMessageOutgoingAvatarSize(CGSize(width: 36, height: 36))
        layout?.setMessageIncomingAvatarSize(CGSize(width: 36, height: 36))
        layout?.setMessageOutgoingAvatarPosition(AvatarPosition(vertical: .messageLabelTop))
        layout?.setMessageIncomingAvatarPosition(AvatarPosition(vertical: .messageLabelTop))
        
        // 一つ前と同じ人かチェック
        if indexPath.section > 0 {
            let prevSender = messageList[indexPath.section - 1].sender.senderId
            if prevSender == message.sender.senderId {
                avatarView.isHidden = true
                return
            }
        }
        
        let avatar = Avatar(initials: "伊")
        avatarView.set(avatar: avatar)
    }
}

// MARK: - MessagesLayoutDelegate
extension chatViewController: MessagesLayoutDelegate
{
    
 
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    {
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    {
        return 16
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    {
        return 16
    }
    
}

// MARK: - MessageCellDelegate
extension chatViewController: MessageCellDelegate
{
    func didTapMessage(in cell: MessageCollectionViewCell)
    {
        print("Message tapped")
    }
}

// MARK: - InputBarAccessoryViewDelegate (名前を最新版に変更)
extension chatViewController: InputBarAccessoryViewDelegate
{
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String)
    {
        for component in inputBar.inputTextView.components
        {
            if let image = component as? UIImage
            {
                let imageMessage = MockMessage(image: image, sender: currentSender() as! Sender, messageId: UUID().uuidString, date: Date())
                messageList.append(imageMessage)
                messagesCollectionView.insertSections([messageList.count - 1])
                
            } else if let text = component as? String
            {
                let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                  .foregroundColor: UIColor.white])
                let message = MockMessage(attributedText: attributedText, sender: currentSender() as! Sender, messageId: UUID().uuidString, date: Date())
                messageList.append(message)
                messagesCollectionView.insertSections([messageList.count - 1])
            }
        }
        inputBar.inputTextView.text = ""
        messagesCollectionView.scrollToBottom()
    }
}




