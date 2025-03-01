import json
import boto3
import os


def lambda_handler(event,context):
    print("==========")
    print(event)
    print("==========")

    client = boto3.client('ec2')
    ids = ['i-0817ad560e194335d','i-078667ba3a54220bd']
    response = client.describe_instances( InstanceIds=ids )

    for reservation in reponse["Reservations"]:
        for instance in reservation["Instances"]:
            print('====================')
            print(f" {instance["InstanceId"]} == {instance["State"]["Name"]}")
            print('======================')

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda')
    }


