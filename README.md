# Heroku Vault

Run Vault in Heroku, with state stored in S3, and auto-unseal with AWS KMS

NOT PRODUCTION READY

## Dependencies

(TODO: Terraform config for these)

### S3 bucket

Make sure it's not publicly accessible!

### IAM User

Store user's credentials in Heroku as `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

### KMS Key

Needs to be accessible by the IAM user

Store the KMS Key ID in Heroku as `VAULT_AWSKMS_SEAL_KEY_ID`
