The goal of the MessageList component is to query all Message contracts where the receiver is the current user, and display their contents and senders in a list. The entire component is shown below. You should copy this into a new MessageList.tsx file in `ui/src/components`{{open}} and save it.

<pre class="file" data-target="clipboard">
import React from 'react'
import { List, ListItem } from 'semantic-ui-react';
import { User } from '@daml.js/create-daml-app';
import { useStreamQuery } from '@daml/react';

/**
 * React component displaying the list of messages for the current user.
 */
const MessageList: React.FC = () => {
  const messagesResult = useStreamQuery(User.Message);

  return (
    <List relaxed>
      {messagesResult.contracts.map(message => {
        const {sender, receiver, content} = message.payload;
        return (
          <ListItem
            className='test-select-message-item'
            key={message.contractId}>
            <strong>{sender} &rarr; {receiver}:</strong> {content}
          </ListItem>
        );
      })}
    </List>
  );
};

export default MessageList;
</pre>

First we get the username of the current user with the useParty hook. Then messagesResult gets the stream of all Message contracts where the receiver is our username. The streaming aspect means that we don’t need to reload the page when new messages come in. We extract the payload of every Message contract (the data as opposed to metadata like the contract ID) in messages. The rest of the component simply constructs a React List element with an item for each message.

There is one important point about privacy here. No matter how we write our Message query in the UI code, it is impossible to break the privacy rules given by the DAML model. That is, it is impossible to see a Message contract of which you are not the sender or the receiver (the only parties that can observe the contract). This is a major benefit of writing apps on DAML: the burden of ensuring privacy and authorization is confined to the DAML model.