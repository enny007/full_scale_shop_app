/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Import the stripe library and create a Stripe instance using your secret key
const functions = require('firebase-functions');
const stripe = require('stripe')('sk_test_51OFvlPFuireUbcBPdifLViCGTzBP3AysrX6IAmnu6NSuTYBdz4Fnq1WHxYi4EDPcTTjrSfjmUoAUeaSqjUlJHZyb00ukIvbYoM');

exports.stripePaymentIntentRequest = functions.https.onRequest(async (req, res) => {
    try {
        let customerId;

        // Gets the customer whose email id matches the one sent by the client
        const customerList = await stripe.customers.list({
            email: req.body.email,
            limit: 1,
        });

        // Checks if the customer exists, if not, it creates a new customer
        if (customerList.data.length != 0) {
            customerId = customerList.data[0].id;
        } else {
            const customer = await stripe.customers.create({
                email: req.body.email,
            });
            customerId = customer.id; // Use customer.id to get the customer ID
        }

        // Creates an ephemeral secret key linked to the customer
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }
        );

        // Creates a new payment intent with the amount passed in from the client
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parseInt(req.body.amount),
            currency: 'usd',
            customer: customerId,
        });

        res.status(200).send({
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
            success: true,
        });
    } catch (error) {
        res.status(404).send({ success: false, error: error.message });
    }
});

