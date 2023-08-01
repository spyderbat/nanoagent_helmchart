# AWS Secret Manager
## These are some sample steps of how to leverage AWS Secrets Manager as a secret store for the Agent Registration Code.  There is an assumption that you are familiar with AWS, IAM, and EKS and how the 3 interact.

- Store the registration keys in secrets manager and get the ARN for it
    ```
    aws secretsmanager create-secret --name \<name\> --region \<region\>
    - aws secretsmanager put-secret-value --secret-id \<name\> --region \<region\> --secret-string "{\"spyderbat-registration-key\":\"\<key\>\"}"
    aws secretsmanager get-secret-value --secret-id \<name\> --region \<region\>

- Create an IAM Policy that allows GetSecretValue and DescribeSecret for it.

- Add the AWS secrets store csi driver to your cluster if it is not already available.
    ```
    helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

    helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system --set syncSecret.enabled=true

    kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml
    ```

- Create a role that will have access to the above mentioned policy and is federated to your eks cluster (see associate-iam-oidc-provider)
    ```
    eksctl create iamserviceaccount --name spyderbat-serviceaccount --region="<region>" --cluster "<cluster_name>" --attach-policy-arn "<policy_arn>" --approve --namespace spyderbat

    eksctl get iamserviceaccount --name spyderbat-serviceaccount --region="<region>" --cluster "<cluster_name>" --namespace spyderbat
    ```

- Now that you have all those values, you can helm install the nanoagent to reference that secret and mount it accordingly (you can do this either via your own values.yaml or overriding via --set via the Helm CLI).
    ```
    aws:
        secretsmanager:
            enabled: true
            rolearn: "<role_arn>"
            secretarn: "<secret_arn>"
    ```
    
    ```
    helm repo add nanoagent https://spyderbat.github.io/nanoagent_helm/
    helm repo update
    helm install nanoagent nanoagent/nanoagent \  --set nanoagent.orcurl="<orc_url>" \  --namespace spyderbat \  --create-namespace \  --set CLUSTER_NAME="<cluster_name>"
    ```

##
This is one example of how this can be accomplished.  If you have any questions feel free to reach out to us at support@spyderbat.com.
