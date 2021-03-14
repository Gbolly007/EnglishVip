const functions = require('firebase-functions');
const admin = require("firebase-admin");
admin.initializeApp(functions.config().functions);

var newData;

exports.onAddNewVideo = functions.firestore.document('videos/{id}').onCreate(async (snapshot, context)=>{



     if (snapshot.empty) {
            console.log('No Devices');
            return;
     }

     newData = snapshot.data();

     const deviceIdTokens = await admin
             .firestore()
             .collection('users')
             .get();

    var tokens = [];

    for (var token of deviceIdTokens.docs) {
            tokens.push(token.data().androidNotificationToken);
    }

    var payload = {
            notification: {
                title: 'New Video',
                body: newData.name,
                sound: 'default',
            },

        };

    try {

       const response = await admin.messaging().sendToDevice(tokens, payload);
       console.log('Notification sent successfully');
    }
    catch (err) {
       console.log(err);
    }

});
