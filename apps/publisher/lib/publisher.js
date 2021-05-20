import { SendMessageCommand, SQSClient } from  '@aws-sdk/client-sqs';

import { REGION, SQS_QUEUE_URL } from './constants.js';

const sqs = new SQSClient({ 
    apiVersion: '2012-11-05',
    region: REGION,
});

export function publish(message) {
    const params = {
        MessageAttributes: {
            Source: {
                DataType: 'String',
                StringValue: 'Tech task app',
            }
        },
        MessageBody: message,
        QueueUrl: SQS_QUEUE_URL
    };

    return sqs.send(new SendMessageCommand(params));
}