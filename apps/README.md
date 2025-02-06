## What's here?
This folder contains dummy apps to deploy to the EKS cluster and validate if the nginx ingress controller is working as expected with the ALB.

## How to deploy
1. Apply each file in the folder using `kubectl apply -f <filename>.yaml`
2. Validate the deployment by running `kubectl get all --namespace <namespace>`
3. Try to access the app using the ALB ingress endpoint. For example: `http://<alb-ingress-endpoint>/green/`

### Reference
- [A deeper look at ingress sharing and target group binding in AWS Load Balancer Controller](https://aws.amazon.com/blogs/containers/a-deeper-look-at-ingress-sharing-and-target-group-binding-in-aws-load-balancer-controller/)