export const REGION = process.env.REGION;
export const SQS_QUEUE_URL = process.env.SQS_QUEUE_URL;

export const INTERVAL = process.env.INTERVAL ? parseInt(process.env.INTERVAL, 10) : 60_000;