resource "helm_release" "external-secrets" {
  depends_on      = [null_resource.get-config]
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace         = "external-secrets"
  create_namespace = true
}

resource "kubernetes_manifest" "secret-vault-token" {
  depends_on = [helm_release.external-secrets]
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "metadata"   = {
      "name"      = "secret-vault-token"
      "namespace" = "external-secrets"
    }
    "data" = {
      "token" = "aHZzLnhmbENMcThjcnIzNm9uWTdBaHY1eVJGcA=="
    }
  }
}

variable "vault_ip" {
  default = "54.234.229.240"
}
resource "kubernetes_manifest" "cluster-secret-store" {
  depends_on = [helm_release.external-secrets]

  manifest = {
    "apiVersion": "external-secrets.io/v1beta1",
    "kind": "ClusterSecretStore",
    "metadata": {
      "name": "vault-backend"
    },
    "spec": {
      "provider": {
        "vault": {
          "server": "http://${var.vault_ip}:8200",
          "path": "secret",
          "version": "v2",
          "auth": {
            "tokenSecretRef": {
              "name": "vault-token",
              "key": "token",
              "namespace": "external-secrets"
            }
          }
        }
      }
    }
  }
}
