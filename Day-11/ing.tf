resource "kubernetes_manifest" "ing1" {
  manifest = {
    "apiVersion": "networking.k8s.io/v1",
    "kind": "Ingress",
    "metadata": {
      "name": "project-ingress",
      "namespace": "default"
      "annotations": {
        "alb.ingress.kubernetes.io/load-balancer-name": "project",
        "alb.ingress.kubernetes.io/scheme": "internet-facing",
        "alb.ingress.kubernetes.io/subnets": "subnet-01b34120f49bf5a7d, subnet-02b95e02658fcde81",
        "alb.ingress.kubernetes.io/target-type": "instance",
        "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}]"
        "alb.ingress.kubernetes.io/healthcheck-port": "traffic-port"
      }
    },
    "spec": {
      "rules": [
        {
          "http": {
            "paths": [
              {
                "path": "/app1",
                "pathType": "Prefix",
                "backend": {
                  "service": {
                    "name": "app1-service",
                    "port": {
                      "number": 80
                    }
                  }
                }
              }
            ]
          }
        },
        {
          "http": {
            "paths": [
              {
                "path": "/app2",
                "pathType": "Prefix",
                "backend": {
                  "service": {
                    "name": "app2-service",
                    "port": {
                      "number": 80
                    }
                  }
                }
              }
            ]
          }
        },
        {
          "http": {
            "paths": [
              {
                "path": "/app3",
                "pathType": "Prefix",
                "backend": {
                  "service": {
                    "name": "app3-service",
                    "port": {
                      "number": 80
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }
  }
}