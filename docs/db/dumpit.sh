:
# system main data for icmp codes and types services protocols
# su - postgres

# export
for TABLE in flow.icmp_codes flow.icmp_types flow.services flow.protocols
do
	echo ${TABLE}:
	pg_dump netflow --table="${TABLE}"  -f /tmp/netflow_${TABLE}.sql
	ls -l /tmp/netflow_${TABLE}.sql
done

# Import with
#	psql netflow -f filename 
