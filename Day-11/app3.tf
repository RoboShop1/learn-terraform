resource "kubernetes_manifest" "app3-pod" {
  manifest = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
      "name": "app3",
      "namespace": "uat"
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
      "namespace": "uat",
      "annotations": {
        "alb.ingress.kubernetes.io/healthcheck-path": "/app3/index.html"
      }
    },
    "spec": {
      "selector": {
        "nginx": "app3"
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

