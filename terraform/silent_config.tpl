# With SMTP
IP1=${IP1}
IP2=${IP2}
IP3=${IP3}
IP4=${IP4}
IP5=${IP5}
HOSTIP=$(hostname -i)
ENABLE_SYSTEM_CHECK=n
ADMIN_EMAIL=opdk@google.com
APIGEE_ADMINPW=Manager123
LICENSE_FILE=/opt/apigee/lic.txt
MSIP=$IP1
USE_LDAP_REMOTE_HOST=n
LDAP_TYPE=1
APIGEE_LDAPPW=Manager123
MP_POD=gateway
REGION=dc-1
ZK_HOSTS="$IP1 $IP2 $IP3"
ZK_CLIENT_HOSTS="$IP1 $IP2 $IP3"
# Must use IP addresses for CASS_HOSTS, not DNS names.
CASS_HOSTS="$IP1 $IP2 $IP3"
# Default is postgres
PG_PWD=postgres
PG_MASTER=$IP4
PG_STANDBY=$IP5
SKIP_SMTP=n
SMTPHOST=smtp.example.com
SMTPUSER=smtp@example.com
# omit for no username
SMTPPASSWORD=SMTP_PASSWORD
# omit for no password
SMTPSSL=n
SMTPPORT=25
SMTPMAILFROM="noreply@google.com"