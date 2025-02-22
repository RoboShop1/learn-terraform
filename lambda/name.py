import json
import boto3

def lambda_handler(event,context):
    print("This is chaithanya")
    print("This is sample example")
    return {
        'statusCode': 200
        'body': json.dumps('Hello from Lambda')
    }


