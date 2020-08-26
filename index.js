

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');
// The Firebase Admin SDK to access the Firebase Realtime Database.



var admin = require('firebase-admin');
//var app = admin.initializeApp();
admin.initializeApp();
const Game = require('./game.js');
// //Game object that will store the game code and an array of the players in the game


// function creatingArrayOfPlayers(id, name, role, numberOfPlayers){
//   for (i = 0; i < numberOfPlayers; i++) {
//     players.push({status: true, id: id, name: name, role: role});
//   }

// }

// [START initializing the game]

//God willing, this func will fire when the moderator press next after selcting the number of players in the app!
exports.addGame = functions.https.onCall((data, context) => {
    // [START_EXCLUDE]
    console.log('Add Random has been called');
    
    // [START returnMessageAsync]
    // Saving the new Data to the Realtime Database.

let x = new Game(data.numberOfPlayers);
 
x.creatDataToBewrote();
  
let gameCode = x.gameCode;
let players = x.players;


    return admin.database().ref("Games").child(gameCode).set({
      "playersJoined": 0,
        "gameCode": gameCode,
        "gameStarted":false,
        "players": players,
      }).then(() => {
        console.log('New Message written');
  
        //rest the players array to zero
        //players = [];
        // Returning the sanitized message to the client.
        return {
          text: "MashaAllah",
          gameCode: gameCode
      };
      })
      // [END returnMessageAsync]
      .catch((error) => {
        // Re-throwing the error as an HttpsError so that the client gets the error details.
        console.log('error');
        throw new functions.https.HttpsError('unknown', error.message, error);
      });

    // [END_EXCLUDE]
  });
  // [END initializing the game]



//   exports.joinGame = functions.https.onCall((data, context) => { 
//     const gameCode = data.gameCode;
//    // const db = admin.database().ref();

//  // [START authIntegration]
//     // Authentication / user information is automatically added to the request.
//     const uid = context.auth.uid;
//     const name = context.auth.token.name || null;
//     // [END authIntegration]


//     // if (db.childExists(gameCode)) {
//       //run some code

//       //Will get name from user and set it to the data base then it will send back the role and the status

//       return admin.database().ref(gameCode + '/players/0').update({
//         "ID": uid,
//       }).then(() => {
//         console.log('New Message written');
        
//         // Returning the sanitized message to the client.
//         return {
//           text: "MashaAllah",
//       };
//       })
//       // [END returnMessageAsync]
//       .catch((error) => {
//         // Re-throwing the error as an HttpsError so that the client gets the error details.
//         console.log('error');
//         throw new functions.https.HttpsError('unknown', error.message, error);
//       });
//     // } 
  
//    });