provider "kubernetes" {
  config_path    = "~/.kube/config"

}

resource "kubernetes_manifest" "app1-pod" {
  manifest = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
      "name": "app1",
      "namespace": "default"
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
      "namespace": "default"
    },
    "spec": {
      "selector": {
        "nginx": "app1"
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