import json
import boto3

def lambda_handler(event,context):
    print("====================")
    print("This is chaithanya")
    print("This is sample example1")
    print("=======================")
    return {
        'statusCode': 200
        'body': json.dumps('Hello from Lambda')
    }


