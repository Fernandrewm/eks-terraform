# Connecting to the EKS cluster
After creating the EKS cluster with Terraform, you'll need to configure your environment to interact with it. This guide explains how to set up access using AWS CloudShell.


## Using AWS CloudShell
AWS CloudShell provides a browser-based shell with AWS CLI and kubectl pre-installed, making it the easiest way to connect to your EKS cluster.

1. Generate the kubeconfig file
```
aws eks update-kubeconfig --region us-west-2 --name eks-terraform-cluster
```

2. Set the KUBECONFIG environment variable:
```
export KUBECONFIG=/home/cloudshell-user/.kube/config
```

3. Verify the connection:
```
kubectl version --client
```

Done! You should now have access to your EKS cluster using kubectl.

## Using Local Machine or Other Environment
If you prefer to use your local machine or another environment, you'll need to:
1. Ensure you have AWS CLI installed and configured with proper credentials.

2. Install kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/):
    - Download kubectl
    ```
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    ```
    - Validate binary kubectl
    ```
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    ```
    - Install kubectl
    ```
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    ```
    - Test the installation
    ```
    kubectl version --client
    ```

3. Generate kubeconfig as shown in the CloudShell section

### Verify Cluster Access
After setting up the connection, verify access by running:
```
kubectl get nodes
```

This should return a list of nodes in your cluster.


## Important Security Considerations

When connecting from outside AWS CloudShell:
- Ensure your IP address/network has access to the EKS cluster endpoint.
- Verify your AWS credentials have the necessary permissions to interact with EKS.
- Check that security groups allow traffic from your location to the cluster.
- If using private endpoints, ensure you have proper VPN.