////
////  ChatViewController.swift
////  FindMyTool
////
////  Created by Nicolas Demange on 27/07/2022.
////
///
import UIKit
import Foundation

class ChatViewController: UIViewController {
    
    private var tableView: UITableView {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellChat")
        return table
    }
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Aucune conversation"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        setupTableView()
        fetchConversation()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchConversation() {
        
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellChat", for: indexPath)
        cell.textLabel?.text = "Hello World !"
    return cell
    }
}

//
//import UIKit
//import InputBarAccessoryView
//import FirebaseFirestore
//import FirebaseAuth
//import MessageKit
//
//
//class ChatViewController: MessagesViewController {
//    
//    // MARK: - Properties
//    
//    var currentUser: User = Auth.auth().currentUser!
//    private var docReference: DocumentReference?
//    var messages: [Message] = []
//    
//    var user2Name: String?
//    var user2ImgUrl: String?
//    var user2UID: String?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = user2Name ?? "Chat"
//        navigationItem.largeTitleDisplayMode = .never
//        maintainPositionOnInputBarHeightChanged = true
//        scrollsToLastItemOnKeyboardBeginsEditing = true
//        messageInputBar.inputTextView.tintColor = .systemBlue
//        messageInputBar.sendButton.setTitleColor(.systemTeal, for: .normal)
//        messageInputBar.delegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        //loadChat()
//    }
//    
//    // MARK: - Methodes
//    
//    func loadChat() {
//        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User1")
//        
//        db.getDocuments { (chatQuerySnap, error) in
//            if let error = error {
//                print("Error \(error) ")
//                } else {
//                    guard let queryCount = chatQuerySnap?.documents.count else { return }
//                    
//                    if queryCount == 0 {
//                        self.createNewChat()
//                    }
//                    else if queryCount >= 1 {
//                        for doc in chatQuerySnap!.documents {
//                            let chat = Chat(dictionary: doc.data())
//                            if (chat?.users.contains(self.user2UID ?? "ID not found")) == true {
//                                self.docReference = doc.reference
//                                doc.reference.collection("thread")
//                                    .order(by: "created", descending: false)
//                                    .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
//                                        if let error = error {
//                                            print("Error: \(error)")
//                                            return
//                                        } else {
//                                            self.messages.removeAll()
//                                            for message in threadQuery!.documents {
//                                                let msg = Message(dictionary: message.data())
//                                                self.messages.append(msg!)
//                                                print("Data: \(msg?.content ?? "No message found")")
//                                            }
//                                            //We'll edit viewDidload below which will solve the error
//                                            self.messagesCollectionView.reloadData()
//                                            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
//                                        }
//                                    })
//                                return
//                            } //end of if
//                        } //end of for
//                        self.createNewChat()
//                    } else {
//                        print("Let's hope this error never prints!")
//                        
//                    }
//                }
//        }
//    }
//    
//    func createNewChat() {
//        let users = [self.currentUser.uid, self.user2UID]
//        let data: [String: Any] = ["users": users]
//        
//        let db = Firestore.firestore().collection("Chats")
//        db.addDocument(data: data) { error in
//            if let error = error {
//                print("Unable to create chat! \(error)")
//            } else {
//                self.loadChat()
//            }
//        }
//    }
//    
//    private func insertNewMessage(_ message: Message) {
//        //add the message to the messages array and reload it
//        messages.append(message)
//        messagesCollectionView.reloadData()
//        DispatchQueue.main.async {
//            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
//        }
//    }
//    
//    private func save(_ message: Message) {
//         
//        //Preparing the data as per our firestore collection
//        let data: [String: Any] = [
//            "content": message.content,
//            "created": message.created,
//            "id": message.id,
//            "senderID": message.senderID,
//            "senderName": message.senderName
//        ]
//        
//        //Writing it to the thread using the saved document reference we saved in load chat function
//        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
//            if let error = error {
//                print("Error Sending message: \(error)")
//                return
//            }
//            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
//        })
//    }
//}
//
//
//extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
//    
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        
//        //When use press send button this method is called.
//        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName ?? "rien")
//        
//        //calling function to insert and save message
//        insertNewMessage(message)
//        save(message)
//        
//        //clearing input field
//        inputBar.inputTextView.text = ""
//        messagesCollectionView.reloadData()
//        messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
//        //messagesCollectionView.scrollToBottom(animated: true)
//    }
//    
//    // MessagesDataSource :
//    var currentSender: MessageKit.SenderType {
//        return ChatUser(senderId: Auth.auth().currentUser!.uid, displayName: (Auth.auth().currentUser?.displayName) ?? "oups")
//    }
//    
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
//        return messages[indexPath.section]
//    }
//    
//    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
//        if messages.count == 0 {
//            print("There are no messages")
//            return 0
//        } else {
//            return messages.count
//        }
//    }
//    
//    // MessagesDisplayDelegate
//    
//    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ? .blue: .lightGray
//    }
//    
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
//        return .bubbleTail(corner, .curved)
//    }
//    
//    
//
//}
