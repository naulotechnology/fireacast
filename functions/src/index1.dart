import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
//import { Change } from "firebase-functions";
admin.initializeApp();
// https://firebase.google.com/docs/functions/typescript

export const onKathmanduWeatherUpdate = functions.firestore
  .document("cities -weather/kathmandu")
  .onUpdate(change => {
    const after = change.after.data();
    const payload = {
      data: {
        temp: String(after.temp),
        conditions: after.conditions
      }
    };
    return admin
      .messaging()
      .sendToTopic("weather_kathmandu", payload)
      .catch(error => {
        console.error("FCM error ", error);
      });
  });

export const getKathmanduWeather = functions.https.onRequest(
  (request, response) => {
    admin
      .firestore()
      .doc("cities -weather/kathmandu")
      .get()
      .then(snapshot => {
        const data = snapshot.data();
        response.send(data);
      })
      .catch(error => {
        //handle the error
        console.log(error);
        response.status(500).send(error);
      });
  }
);
