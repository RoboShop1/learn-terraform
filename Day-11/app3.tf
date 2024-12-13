resource "kubernetes_manifest" "app3-pod" {
  manifest = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
      "name": "app3",
      "namespace": "default"
      "labels": {
        "nginx": "app3"
      }
    },
    "spec": {
      "containers": [
        {
          "name": "app3",
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

resource "kubernetes_manifest" "app3-service" {
  manifest ={
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "app3-service",
      "namespace": "default"
    },
    "spec": {
      "selector": {
        "nginx": "app3"
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

resource "kubernetes_annotations" "app3-service-annotation" {
  api_version = "v1"
  kind        = "Service"
  metadata {
    name = "app3-service"
  }
  annotations = {
    alb.ingress.kubernetes.io/healthcheck-path: "/app3/index.html"
  }
}