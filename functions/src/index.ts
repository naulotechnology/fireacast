import * as functions from "firebase-functions";

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("hello from the other world");
});
