#!/bin/sh


if [ -z "$PORT" ]; then
    PORT=1337
fi

cat > /tmp/config.hcl <<EOF

listener "tcp" {
  address     = "0.0.0.0:${PORT}"

  # TODO: Give this a local SSL cert
  # For now, Heroku's load balancer will talk in plaintext
  # 😱
  tls_disable = 1
}

storage "s3" {
  bucket     = "lmhd-test-vault"
  region     = "us-east-2"

  # Creds are stored as env vars in Heroku as config vars:
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}

seal "awskms" {
  region     = "us-east-2"
  
  # KMS Key ID is stored as an env var in Heroku as config var:
  # VAULT_AWSKMS_SEAL_KEY_ID

  # Creds are stored as env vars in Heroku as config vars:
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}

ui = true

# Bad idea in Prod. But good enough for this PoC
# Heroku doesn't support mlock
disable_mlock = true

EOF

/bin/vault server -config /tmp/config.hcl