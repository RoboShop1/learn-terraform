resource "kubernetes_manifest" "app2-pod" {
  manifest = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
      "name": "app2",
      "namespace": "default"
      "labels": {
        "nginx": "app2"
      }
    },
    "spec": {
      "containers": [
        {
          "name": "app2",
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

resource "kubernetes_manifest" "app2-service" {
  manifest ={
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "app2-service",
      "namespace": "default"
    },
    "spec": {
      "selector": {
        "nginx": "app2"
      },
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


resource "kubernetes_annotations" "app2-service-annotation" {
  api_version = "v1"
  kind        = "Service"
  metadata {
    name = "app2-service"
  }
  annotations = {
    "alb.ingress.kubernetes.io/healthcheck-path": "/app2/index.html"
  }
}