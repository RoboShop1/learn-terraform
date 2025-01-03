provider "kubernetes" {
  config_path    = "~/.kube/config"

}


resource "kubernetes_annotations" "example" {
  api_version = "v1"
  kind        = "Pod"
  metadata {
    name = "pod1"
    namespace = "dafalt"
  }
  annotations = {
    "owner" = "myteam"
  }
}

resource "kubernetes_manifest" "app1-pod" {
  manifest = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
      "name": "app1",
      "namespace": "dev"
      "labels": {
        "nginx": "app1"
      }
    },
    "spec": {
      "containers": [
        {
          "name": "app1",
          "image": "chaitu1812/aws-alb",
          "ports": [
            {
              "containerPort": 80
            }
          ]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "app1-service" {
  manifest ={
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "app1-service",
      "namespace": "dev",
      "annotations": {
        "alb.ingress.kubernetes.io/healthcheck-path": "/app1/index.html"
      }
    },
    "spec": {
      "selector": {
        "nginx": "app1"
      },
      "type": "NodePort",
      "ports": [
        {
          "protocol": "TCP",
          "port": 80,
          "targetPort": 80
        }
      ]
    }
  }
}

