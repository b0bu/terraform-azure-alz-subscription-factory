### Subscription factory
Deploy baseline subscirptions in accordance with CAF guidance. The billing construct is for microsoft customer account (mca) for testing purposes. You can only have a maximum of 5 subscription for MCA account. 
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
Leaving out the optional placement of the subscription will create it outside of any management hierarchy. This can be added later.
```
 subscription_management_group_association_enabled = true
 subscription_management_group_id                  = "Connectivity"
```
### Running 
Supply the backend config
```
terraform init -backend-config=backend.conf
```
Subs take 30 minutes to create and you're likely to hit the `failed: context exceeded` timeout error. To create each subscription sequentially:
```
terraform apply -parallelism 1
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
### Gotchas
If not logged in via az cli or have tokens in env. This can also happen if you specify "DevTest" for the workload type and don't have it set up to create DevTest subscritpions.
```
│ Error: creating new Subscription (Alias "corp-002"): subscription.AliasClient#Create: Failure sending request: StatusCode=403 -- Original Error: Code="Forbidden" Message="You do not have sufficient permissions on the specified invoice section to create an Azure subscription. Refer(http://aka.ms/mca-section-invoice) to set the right permissions and try again"
```
If you try to exceed the limit of subscriptions for your account
```
│ Error: creating new Subscription (Alias "corp-001"): subscription.AliasClient#Create: Failure sending request: StatusCode=0 -- Original Error: context deadline exceeded
```

#### Note
Given example of "enrollmentAccounts" are for EA accounts only and looks like
```
subscription_billing_scope = "/providers/Microsoft.Billing/billingAccounts/1234567/enrollmentAccounts/123456"
```