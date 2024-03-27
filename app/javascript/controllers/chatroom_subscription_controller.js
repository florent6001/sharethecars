import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages", "messageInput"]

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    this.#scrollDown()
  }

  disconnect() {
    this.subscription.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.avatar_url, data.sender_name, data.profile_url)

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.#scrollDown()
    this.messageInputTarget.value = ""
  }

  #scrollDown() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }


  #buildMessageElement(currentUserIsSender, message, avatarUrl, userName, profileUrl) {
    const avatarElement = avatarUrl ?
      `<div class="px-2">
         <a href="${profileUrl}">
           <img src="${avatarUrl}" alt="${userName}" class="avatar">
         </a>
       </div>` : '';

    const messageClass = currentUserIsSender ? "sender-style" : "receiver-style";
    const justifyClass = this.#justifyClass(currentUserIsSender);

    return `
      <div class="message-row d-flex align-items-end ${justifyClass}">
        ${!currentUserIsSender ? avatarElement : ''}
        <div class="${messageClass}">
          ${message}
        </div>
        ${currentUserIsSender ? avatarElement : ''}
      </div>
    `;
  }
  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
}
