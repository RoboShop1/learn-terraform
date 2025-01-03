
export AWS_DEFAULT_PROFILE=dev1

ROLE_ARN="arn:aws:iam::339712959230:role/eks_role_admin"
SESSION_NAME="sample"



CREDENTIALS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "$SESSION_NAME"   --output json)



AWS_ACCESS_KEY_ID=$(echo "$CREDENTIALS" | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo "$CREDENTIALS" | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo "$CREDENTIALS" | jq -r '.Credentials.SessionToken')

# Export the credentials as environment variables
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN