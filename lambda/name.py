import json
import boto3
import os


def lambda_handler(event,context):
    client = boto3.client('ec2')
    ids = ['i-0817ad560e194335d']
    reponse = client.describe_instances( InstanceIds=ids )
    print(reponse)
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda')
    }


