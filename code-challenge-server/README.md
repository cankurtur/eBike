# COBI iOS Coding Challenge — Backend Server

This small node.js backend is required for completing the COBI.Bike iOS coding challenge. It can be taken as-is or it can be modified when the need arises. The backend must be submitted along with the iOS coding challenge.

To make it available to the app, it must either 
* be hosted somewhere publicly or 
* the iOS app must be able to connect to it on the local network

## Setup
* Install [node.js](https://nodejs.org/en/)
* Install [npm](https://www.npmjs.com)
* `npm install`
* `npm start`
* Now it is available at `http://localhost:3000`

## Documentation

See [Postman Documentation](https://documenter.getpostman.com/view/426588/RWgqWeuN).

## Sample Data
There is a small set of bikes defined in the `data/data.js`. They are all placed around the COBI.Bike office (50.119504, 8.638137). Either simulate this location on the iOS simulator or define your own bikes to rent.
