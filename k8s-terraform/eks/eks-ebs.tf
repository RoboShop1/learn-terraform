data "http" "ebs-policy" {
  url = "https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json"
}

output "data-body" {
  value = data.http.ebs-policy.body
}