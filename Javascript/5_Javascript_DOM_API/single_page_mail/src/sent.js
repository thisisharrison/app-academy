const MessageStore = require('./message_store');

const Sent = {
    render: () => {
        const container = document.createElement('ul');
        container.className = 'messages';
        // Get messages from MessageStore
        const messages = MessageStore.getSentMessages();
        messages.forEach((message) => {
            container.appendChild(Sent.renderMessage(message));
        });
        return container;
    },

    renderMessage: (message) => {
        const li = document.createElement('li');
        li.className = 'message'
        li.innerHTML = `
            <span class="to">${message.to}</span>
            <span class="subject">${message.subject}</span>
            <span class="body">${message.body}</span>
        `
        return li;
    }

}

module.exports = Sent;