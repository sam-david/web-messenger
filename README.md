# Zozi coding challenge

## Scope:

### 1.  A JSON API for creating messages that are stored in a database.
The message can be a maximum of 141 characters long.
The message should be associated (tagged) with any hashtags that are found in the body.

Example request:
POST /api/messages
{ "body": "This is a message from #zozi" }

#### Solution-
Created POST `api/messages` route using Api:MessagesController. Create method starts by creating message from post params 'body'. Then parses the body to count the occurence of each hashtag. Hashtags are created and joined to message through HashtagOccurence table. HashtagOccurence is used to keep track of the quantity of a certain hashtag in a message.

### 2. An HTML endpoint (/messages) for displaying the messages, from newest to oldest.
It should also display a list of hashtags found in messages, with the most frequently used first.

#### Solution-
Navigating to the `/messages` page, messages are displayed in a very simple format. I did not spend too much time on the frontend here. Normally I would use a framework like Zurb Foundation or Bootstrap but it didn't seem necessary in this case to make the site responsive.
Messages are displayed newest to oldest with hashtags shown below them in order of most frequently used. The order for most frequently used is found from the `hashtag_occurence` table quantity that joins `messages` and `hashtags`.

### Tests-
Rspec tests exist for the Messages model and the Api:MessagesController. Message model test look at validations for message body length. Api:MessagesController tests look at POST `api/messages` route and test that message body is parsed for hashtags. Also testing the occurences are being tracked correctly. Finally, a POST route to `api/messages` with invalid message body length is send to make sure error is returned.

