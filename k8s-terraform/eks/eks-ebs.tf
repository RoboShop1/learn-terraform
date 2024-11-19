

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "ebs-role" {
  name               = "role-aws-elb"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



resource "aws_iam_role_policy" "ebs_policy" {
  name = "test_policy"
  role = aws_iam_role.ebs-role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateSnapshot",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:ModifyVolume",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumesModifications",
          "ec2:EnableFastSnapshotRestores"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateTags"
        ],
        "Resource": [
          "arn:*:ec2:*:*:volume/*",
          "arn:*:ec2:*:*:snapshot/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteTags"
        ],
        "Resource": [
          "arn:*:ec2:*:*:volume/*",
          "arn:*:ec2:*:*:snapshot/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateVolume"
        ],
        "Resource": "arn:*:ec2:*:*:volume/*",
        "Condition": {
          "StringLike": {
            "aws:RequestTag/ebs.csi.aws.com/cluster": "true"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateVolume"
        ],
        "Resource": "arn:*:ec2:*:*:volume/*",
        "Condition": {
          "StringLike": {
            "aws:RequestTag/CSIVolumeName": "*"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateVolume"
        ],
        "Resource": "arn:*:ec2:*:*:snapshot/*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteVolume"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster": "true"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteVolume"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "ec2:ResourceTag/CSIVolumeName": "*"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteVolume"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "ec2:ResourceTag/kubernetes.io/created-for/pvc/name": "*"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteSnapshot"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "ec2:ResourceTag/CSIVolumeSnapshotName": "*"
          }
        }
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DeleteSnapshot"
        ],
        "Resource": "*",
        "Condition": {
          "StringLike": {
            "ec2:ResourceTag/ebs.csi.aws.com/cluster": "true"
          }
        }
      }
    ]
  })
}



resource "helm_release" "ebs-csi" {
  name       = "ebs-csi"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
}

resource "aws_eks_pod_identity_association" "eks-ebs-pod-association" {
  cluster_name    = aws_eks_cluster.dev-eks.name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs-role.arn
}



























