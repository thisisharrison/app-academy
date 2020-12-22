const MessageStore = require('./message_store');

const Compose = {
    render: () => {
        const div = document.createElement('div');
        div.className = 'new-message';
        div.innerHTML = Compose.renderForm();
        div.addEventListener('change', (event) => Compose.updateDraft(event));
        div.addEventListener('submit', (event) => {
            event.preventDefault();
            MessageStore.sendDraft();
            window.location.hash = '#inbox';
        });
        return div;
    },

    renderForm: () => {
        const draft = MessageStore.getMessageDraft();
        return `
            <p class = "new-message-header">New Message</p>
            <form class="compose-form" action="">
            <input type="text" placeholder="Recipient" name="to" value="${draft.to || ''}">
            <input type="text" placeholder="Subject" name="subject" value="${draft.subject || ''}">
            <textarea name="body" rows="20">${draft.body || ''}</textarea>
            <br>
            <button type="submit" class="btn btn-primary submit-message">Send</button>
            </form>
        `
    },

    updateDraft: (event) => {
        const prop = event.target;
        const name = prop.name;
        const value = prop.value;
        MessageStore.updateDraftField(name, value);
    }
}

module.exports = Compose;