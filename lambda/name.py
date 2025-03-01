import json
import boto3
import os


def lambda_handler(event,context):
    ec2 = boto3.ec2

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda')
    }


