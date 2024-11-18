# 2bc
This repository contains code for 2bc.

## What I would do differently
1. VM would not be exposed to the internet on public IP.
2. SSH key would be kept in other safe place (i.e. existing KV). Not defined in TF itself.
3. AKS key would be different from VM key.
4. Workloads in AKS would be deployed outside of terraform (Application and Infra deployment should have separate states).
5. ingress_nginx public IP would be managed in MC_* group (but I do not have permission on provided subscription) to avoid configuration complexity

