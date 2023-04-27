"use strict";

const geolib = require('geolib');
const bikes = require('../data/data.js');

const getBikeForRequest = function(req) {
	return bikes.find(bike => bike.id == req.params.id);
}

const validateBike = function(bike) {
	return	bike.name && typeof bike.name === "string" &&
					bike.color && typeof bike.color === "string" &&
					bike.pin && typeof bike.pin === "string" && bike.pin.length == 4 &&
					bike.location && 
					bike.location.latitude && typeof bike.location.latitude === "number" &&
					bike.location.longitude && typeof bike.location.longitude === "number";
}

module.exports = function (app) {
	app.get("/", function(req, res) {
		res.status(200).send("Use the /bike endpoint to 🚲");
	});

	app.get("/bikes", function (req, res) {
		const latitude = Number.parseFloat(req.query.latitude);
		const longitude = Number.parseFloat(req.query.longitude);
		const radius = Number.parseFloat(req.query.radius) || 1000;

		if (!latitude || !longitude) {
			return res.status(200).send(bikes);
		}

		const location = {latitude: latitude, longitude: longitude};
		const nearbyBikes = bikes.filter(bike => geolib.getDistance(bike.location, location) <= radius);
		res.status(200).send(nearbyBikes);
	});

	app.post("/bikes", function (req, res) {
		const bike = req.body;
		if (!validateBike(bike)) {
			return res.status(400).send("Invalid 🚲 — take a deep breath and try again");
		}

		bike.id = bikes.length.toString();
		bike.rented = false;
		bikes.push(bike);
		res.status(200).send();
	});

	app.put("/bikes/:id", function (req, res) {
		const oldBike = getBikeForRequest(req);
		if (!oldBike) {
			return res.status(404).send("This 🚲 doesn't exist");
		}

		const bike = req.body;
		if (!validateBike(bike)) {
			return res.status(400).send("Invalid 🚲 — take a deep breath and try again");
		}

		oldBike.name = bike.name;
		oldBike.color = bike.color;
		oldBike.pin = bike.pin;
		oldBike.location = bike.location;
		res.status(200).send();
	});

	app.put("/bikes/:id/rented", function (req, res) {
		const bike = getBikeForRequest(req);
		if (!bike) {
			return res.status(404).send("This 🚲 doesn't exist");
		}
		if (bike.rented) {
			return res.status(400).send("This 🚲 is already rented");
		}

		bike.rented = true;
		res.status(200).send();
	});

	app.delete("/bikes/:id/rented", function (req, res) {
		const bike = getBikeForRequest(req);
		if (!bike) {
			return res.status(404).send("This 🚲 doesn't exist");
		}
		if (!bike.rented) {
			return res.status(400).send("This 🚲 is not rented right now");
		}

		bike.rented = false;
		res.status(200).send();
	});
}
