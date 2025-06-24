# EKS Terraform Instructions

This Terraform folder assumes your EKS cluster is already created and configured.

Steps:

1. Use eksctl or Terraform modules to create your EKS cluster.
2. Use the Kubernetes YAML or Helm chart from this project to deploy the app.
3. Run `kubectl apply -f k8s/` or use `helm install`.

You can also use Terraform Kubernetes provider to automate deployment if desired.
