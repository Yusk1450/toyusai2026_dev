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

class ChatViewController: MessagesViewController
{
    @IBOutlet weak var headerView: UIView!

	var messageList: [MockMessage] = []
    lazy var formatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
        
    var studentName = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
		
		self.messageList = []
        
		self.messagesCollectionView.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 30/255, alpha: 1.0)
		self.messagesCollectionView.contentInset.top = 16
        
		self.messagesCollectionView.messagesDataSource = self
		self.messagesCollectionView.messagesLayoutDelegate = self
		self.messagesCollectionView.messagesDisplayDelegate = self
		self.messagesCollectionView.messageCellDelegate = self
		self.alignSenderNameWithMessageText()
        
        // メッセージ入力時に一番下までスクロール
		self.scrollsToBottomOnKeyboardBeginsEditing = true
		self.maintainPositionOnKeyboardFrameChanged = true
		
		self.messagesCollectionView.contentInset.top = 50
		self.messageInputBar.isHidden = true
		
		self.view.bringSubviewToFront(self.headerView)
		
		let director = GameDirector.shared
		director.startGame()
		director.changeScene(scene: StudentCardScene())
    }
    
    override func viewDidAppear(_ animated: Bool)
	{
        super.viewDidAppear(animated)
		
		let director = GameDirector.shared
		director.currentViewController = self
    }
    
    func StudentsCard(name:String)
    {
        self.studentName = name
        self.performSegue(withIdentifier: "toStudentsCard", sender: nil)
    }
	
	private func alignSenderNameWithMessageText()
	{
		guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else { return }

		let avatarSide: CGFloat = 36
		let avatarSize = CGSize(width: avatarSide, height: avatarSide)
		layout.setMessageIncomingAvatarSize(avatarSize)
		layout.setMessageOutgoingAvatarSize(avatarSize)

		let textInsets = UIEdgeInsets.zero
		layout.textMessageSizeCalculator.incomingMessageLabelInsets = textInsets
		layout.textMessageSizeCalculator.outgoingMessageLabelInsets = textInsets
		layout.attributedTextMessageSizeCalculator.incomingMessageLabelInsets = textInsets
		layout.attributedTextMessageSizeCalculator.outgoingMessageLabelInsets = textInsets

		let incomingInset = avatarSide + layout.textMessageSizeCalculator.incomingMessagePadding.left
		let outgoingInset = avatarSide + layout.textMessageSizeCalculator.outgoingMessagePadding.right
		layout.setMessageIncomingMessageTopLabelAlignment(
			LabelAlignment(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: incomingInset, bottom: 0, right: 0))
		)
		layout.setMessageOutgoingMessageTopLabelAlignment(
			LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: outgoingInset))
		)
	}

	// メッセージを追加する
	func addMessage(message:MockMessage)
	{
		self.messageList.append(message)
		
		Task { @MainActor in
			self.messagesCollectionView.reloadData()
			self.messagesCollectionView.scrollToBottom()
		}
	}
	
	func createMessage(text: String, sender:SenderType) -> MockMessage
    {
        let attributedText = NSAttributedString(string: text, attributes: [
			.font: UIFont(name: "ShipporiMincho-SemiBold", size: 16),
			.foregroundColor: UIColor.white
		])
        return MockMessage(attributedText: attributedText,
						   sender: sender,
						   messageId: UUID().uuidString, date: Date())
    }
    
	func createSender(name: String) -> SenderType?
	{
		switch name
		{
		case "伊志郷":
			return Sender(senderId: "2", displayName: name)
		case "山井":
			return Sender(senderId: "3", displayName: name)
		case "掛川":
			return Sender(senderId: "4", displayName: name)
		case "橋口":
			return Sender(senderId: "5", displayName: name)
		case "野々村":
			return Sender(senderId: "6", displayName: name)
		case "平崎", "平﨑":
			return Sender(senderId: "7", displayName: name)
		case "杉原":
			return Sender(senderId: "8", displayName: name)
		case "二島", "二島 彩子":
			return Sender(senderId: "9", displayName: name)
		case "鈴村":
			return Sender(senderId: "10", displayName: name)
		default:
			return nil
		}
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoPop"
        {
            if let popUpVC = segue.destination as? PhotoPopViewController {
            }
        }
        
        if segue.identifier == "toPaperPop"
        {
            if let popUpVC = segue.destination as? PaperPopViewController {
            }
        }
        
        if segue.identifier == "toStudentsCard"
        {
            let StudentCardVC = segue.destination as! StudentsCardViewController
            StudentCardVC.studentName = self.studentName
        }
        
        if segue.identifier == "toBadEnd"
        {
            let StudentCardVC = segue.destination as! BadEndViewController
        }

    }
	
}


// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource
{
    // MessageKit が要求する型（SenderType）を返すように修正
    func currentSender() -> SenderType
    {
        return Sender(id: "1", displayName: "自分")
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
        // ひとつ前と同じ人か確認する
        if (indexPath.section > 0)
		{
            let prevSender = messageList[indexPath.section - 1].sender.senderId
            if (prevSender == message.sender.senderId)
			{
                return nil
            }
        }
        
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes:
                                    [.font: UIFont(
                                        name: "ShipporiMincho-SemiBold", size: 16),
                                     .foregroundColor: UIColor.white])
    }
    
}

// MARK: - MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate
{
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return UIColor.white        
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return UIColor(named: "csblack")!
    }
    
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
        
        let avatar = Avatar(image: UIImage(named: "avatar"))
        avatarView.set(avatar: avatar)
    }
}

// MARK: - MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate
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
extension ChatViewController: MessageCellDelegate
{
    func didTapMessage(in cell: MessageCollectionViewCell)
    {
        print("Message tapped")
    }
}

// MARK: - InputBarAccessoryViewDelegate (名前を最新版に変更)
extension ChatViewController: InputBarAccessoryViewDelegate
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




