import { readMessage } from './reader.js';

(async () => {
	while (true) {
		const message = await readMessage();
		
		if (message) {
			console.log(message);
		}
	}
})().catch(e => {
	console.error(e);
})