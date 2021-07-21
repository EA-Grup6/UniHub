import app from './app';
import {startConnection} from './database';
import {createServer} from "http";

const http = createServer(app);
var server = app.listen(4001);
const io = require('socket.io')(server);

async function main(){
    startConnection();

    io.on('connection', (socket: any) => {
        //Get the chatID of the user and join in a room of the same chatID
        console.log('Hola');
        let chatID  = socket.handshake.query.username
        console.log(chatID)
        if (chatID!=null){
            socket.join(chatID)
        }
        
    
        //Leave the room if the user closes the socket
        socket.on('disconnect', () => {
            socket.leave(""+chatID)

        })
    
        //Send message to only a particular user
        socket.on('send_message', (message: { receiverChatID: any; senderChatID: any; content: any; }) => {
            let receiverChatID = message.receiverChatID
            let senderChatID = message.senderChatID
            let content = message.content
            console.log('he recibido un mensaje');
            //Send message to only that particular room
            socket.in(receiverChatID).emit('receive_message', {
                'content': content,
                'senderChatID': senderChatID,
                'receiverChatID':receiverChatID,
            })
        })
    });
    await app.listen(app.get('port'));

    console.log('Server on port',app.get('port'))
    console.log('Cors-enabled for all origins')
}

main();