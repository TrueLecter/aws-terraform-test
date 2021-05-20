import { INTERVAL } from './constants.js';
import { publish } from './publisher.js';

function generateMessage() {
	return JSON.stringify({
		time: Date.now(),
	});
}

async function wait(time) {
	return new Promise(resolve => setTimeout(resolve, time));
}

(async () => {
	while (true) {
		const message = generateMessage();
		await publish(message);

		console.log('Sent: ', message);
		await wait(INTERVAL);
	}
})().catch(e => {
	console.error(e);
})