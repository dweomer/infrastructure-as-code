# CodeCommit

Setup an example CodeCommit repository that sends all events to a dedicated SNS topic.

## Terraform

To Create:

```
terraform init && terraform apply
```

## CloudFormation

To Create:

```
aws cloudformation create-stack --template-body file://./codecommit.cf.yaml --stack-name ExampleRepository
```
