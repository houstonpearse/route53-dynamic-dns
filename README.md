# Dynamic Dns with Route 53

A script for automating the update of Route53

## Getting Started

### Prerequisites

- aws route53 Hosted Zone setup with an A record.
    - the script will attempt to update the first A record that it finds.
    - the script will not validate if the hosted zone matches the domain name.
    - if there is no A record then it will output an error on the first execution.
- aws cli installed, aws cli credentials, and an aws cli profile.


### test the script 
- update variables at the top of the script.
- run the `update-ip.sh` script to test if its working before adding the script to the crontab.


### install cronjob
- run `chmod +x update-ip.sh`
- run `crontab -e` to edit the crontab.
- add `*/10 * * * * cd /path/to/route-53-dynamic-dns & ./update-ip.sh` to the crontab

