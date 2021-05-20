import { ReceiveMessageCommand, DeleteMessageCommand, SQSClient } from '@aws-sdk/client-sqs';

import { REGION, SQS_QUEUE_URL, INTERVAL } from './constants.js';

const sqs = new SQSClient({
    apiVersion: '2012-11-05',
    region: REGION,
});

export async function readMessage() {
    const params = {
        AttributeNames: ["SentTimestamp"],
        MaxNumberOfMessages: 1,
        MessageAttributeNames: ["All"],
        QueueUrl: SQS_QUEUE_URL,
        VisibilityTimeout: 20,
        WaitTimeSeconds: INTERVAL,
    };

    const data = await sqs.send(new ReceiveMessageCommand(params));

    if (data.Messages) {
        const deleteParams = {
            QueueUrl: SQS_QUEUE_URL,
            ReceiptHandle: data.Messages[0].ReceiptHandle,
        };

        try {
            await sqs.send(new DeleteMessageCommand(deleteParams));
        } catch (err) {
            console.log("Unable to delete message", err);
        }
    } else {
        return null;
    }
    
    return data.Messages[0].Body;
}