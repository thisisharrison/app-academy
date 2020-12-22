const MessageStore = {
    getInboxMessages: () => {
        return messages.inbox.reverse();
    },

    getSentMessages: () => {
        return messages.sent.reverse();
    }, 

    getMessageDraft: () => {
        return messageDraft;
    }, 

    updateDraftField: (field, value) => {
        // Updates the Message field
        messageDraft[field] = value;
    }, 

    sendDraft: () => {
        messages.sent.push(messageDraft);
        messageDraft = new Message ();
    }
}

class Message {
    constructor (to, from, subject, body) {
        this.to = to;
        this.from = from;
        this.subject = subject;
        this.body = body;
    }
}

// Draft message
let messageDraft = new Message ();

// Seed Data
let messages = {
    sent: [
        {
            to: "friend@mail.com",
            subject: "Check this out",
            body: "It's so cool"
        },
        { to: "person@mail.com", subject: "zzz", body: "so booring" }
    ],
    inbox: [
        {
            from: "grandma@mail.com",
            subject: "Fwd: Fwd: Fwd: Check this out",
            body:
                "Stay at home mom discovers cure for leg cramps. Doctors hate her"
        },
        {
            from: "person@mail.com",
            subject: "Questionnaire",
            body: "Take this free quiz win $1000 dollars"
        }
    ]
};

module.exports = MessageStore;