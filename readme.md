### subscription factory
Deploy connectivity subscription containing

- vwan
- azure firewall
- azure firewall manager
- express route gw
- vpn gw

Module focuses on MCA account for testing purposes

### Requirements
a `backend.conf` file containing
```
resource_group_name  = "some resource group"
storage_account_name = "some stroage account"
container_name       = "some container name"
key                  = "some container key"
```
a `terraform.tfvars` file containing
```
billing_account_name = "a billing account name (id)"
billing_profile_name = "a billing profile name (id)"
invoice_section_name = "an invoice section name (id)"
```
### Running 
Usual plan apply but init needs a backend
```
terraform init -backend-config=backend.conf
```
### Getting the billing ids for mca account
To get "billing scope name" which is an id
```
az billing account list
```
example should look like
```
subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/{billingScopeId}"
```
To get "billing profile name" which is an id
```
az billing profile list --account-name "{billingScopeId}"
```
example should look like
```
XXXX-YYYY-ZZZ-ZZZ
```
#### Note
Given example of "enrollmentAccounts" are for EA accounts only and looks like
```
subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/1234567/enrollmentAccounts/123456"
```