const functions = require("firebase-functions");

const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();




exports.sendRequest = functions.firestore.document('Matches/{id}').onCreate(async (change, context) => {
    console.log('Macthed');
    const match = change.data();

    const likedOneUser = await database.collection('app_user').doc(match.likedUserId).get();
    const likedByUser = await database.collection('app_user').doc(match.likedByUserId).get();

    sendNotification(likedOneUser.data().fcmToken,likedByUser.data());




    function sendNotification(notificationToken, user) {
        const title = "Match";
        const body = user.name + " give you heart";
        const payload = {
            notification: { title: title, body: body },
            token: notificationToken,
            // screen: "pendingRequest"

        };


        admin.messaging().send(payload).then(response => {
            return console.log("Match Successful Notification Sent");
        }).catch(error => {
            return console.log("Error Match Sending Notification");
        });
    }
    return console.log("End Of Function");

},
);



exports.acceptRequest = functions.firestore.document("Matches/{id}").onUpdate(async (change, context) => {
        console.log("Matched");
        const match = change.after.data();

        if(match.likedUserId != null) {

            if(match.isAccepted == true && match.isProgressed == true){
                const user = await database.collection("app_user").doc(match.likedByUserId).get();
                const likeoneUser = await database.collection("app_user").doc(match.likedUserId).get();
                sendNotification(user.data().fcmToken, likeoneUser.data());
            }    
        }


        function sendNotification(notificationToken, user) {

            const title = "Congratulation!";
            const body ="You and " + user.name +" matched";

            const payload = {
                notification: { title: title, body: body},
                token: notificationToken,
                // screen: "notification",
            };

            admin.messaging().send(payload).then(response => {
                return console.log("Both Matched Successful Notification Sent");
            }).catch(error => {
                return console.log("Error Both Matched Sending Notification");
            });
        }
        return console.log("End Of Function");

    },
);



