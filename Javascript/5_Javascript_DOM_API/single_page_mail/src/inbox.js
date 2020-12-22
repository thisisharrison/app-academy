const MessageStore = require('./message_store');

const Inbox = {
    render: () => {
        const container = document.createElement('ul');
        container.className = 'messages';
        // Get messages from MessageStore
        const messages = MessageStore.getInboxMessages();
        messages.forEach((message) => {
            container.appendChild(Inbox.renderMessage(message));
        });
        return container;
    },

    renderMessage: (message) => {
        const li = document.createElement('li');
        li.className = 'message'
        li.innerHTML = `
            <span class="from">${message.from}</span>
            <span class="subject">${message.subject}</span>
            <span class="body">${message.body}</span>
        `
        return li;
    }

}

module.exports = Inbox;