
# Work flow test on DeIC DPS, 2016, October 14

This is a description on how to simulate a DDoS attack
and monitor all elements in the chain from detection
to mitigation.

## Prerequisite

Access with [ssh keys](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys) to
the systems:

  - **root@fnm**: the _fastnetmon_ host, address 172.22.89.2
  - **rnd@fodhost**: the database server, address 172.22.89.4
  - **rnd@exabgp**: one of two exabgp hosts, address 172.22.89.21

You may add the following snippet to your ``~/.ssh/config``, and add the hosts to
your ``/etc/hosts`` as well.

    Host    172.22.89.2 fnm
	User    root
	TCPKeepAlive        yes
	ServerAliveInterval 15
	ServerAliveCountMax  3
	UseRoaming no

	Host    172.22.89.4  fodhost
	User    rnd
	TCPKeepAlive        yes
	ServerAliveInterval 15
	ServerAliveCountMax  3
	UseRoaming no

	Host    172.22.89.21  exabgp
	User    rnd
	TCPKeepAlive        yes
	ServerAliveInterval 15
	ServerAliveCountMax  3
	UseRoaming no

All systems are available from the _office network_ in 305 and 304.

You may gain access by sending your _public key_ to either Nicolai, Thomas or Anders.

## Work flow

  1. Generate traffic from ``fodhost`` which will update the database
  1. See the enforcement daemon read rules from the database, update exabgp and change rule status
  1. See exabgp enforce the rules to mitigate the attack

Open tree terminal windows.

Monitor what is going on on exabgp by executing the command

   echo sudo tail -f /var/log/syslog | ssh exabgp

Leave the terminal open and monitor the database queries on ``fodhost``:

   echo tail -f /var/log/syslog | ssh fodhost

Now simulate an attack in the last window with the command:

    echo /opt/i2dps/bin/mkdata.pl -loop 2 | ssh fnm

The daemon sleeps for 10 seconds between each database query (change in ``db.ini``).

You should see something like this:

	echo /opt/i2dps/bin/mkdata.pl -loop 2 | ssh fnm
	[....]
	0 - 0: port
	130.226.136.242 incoming 1639 attack_details
	2016-10-13 23:14:46
	INSERT 0 1
	OK
	[...]

And (lines wrapped for readability)
	
	echo tail -f /var/log/syslog | ssh fodhost
	[....]
	Oct 13 23:16:22 fodhost db2dps[20372]: read 0 expired rules for exabgp1
	Oct 13 23:16:22 fodhost db2dps[20372]: sending 2 rules exabgp1
	Oct 13 23:16:22 fodhost db2dps[20372]: processing data for exabgp host exabgp2
	Oct 13 23:16:22 fodhost db2dps[20372]: querying for new rules
	Oct 13 23:16:22 fodhost db2dps[20372]: read 2 new rules from database
	Oct 13 23:16:22 fodhost db2dps[20372]: new rule = announce flow route 1993 { match { source 0.0.0.0/0; \
			130.226.136.242/32; destination-port 32390; protocol udp; } then { discard; } } }
	Oct 13 23:16:22 fodhost db2dps[20372]: add rule = announce flow route 1992 { match { source 0.0.0.0/0; \
			destination 130.226.136.242/32; destination-port 7635; protocol udp; } then { discard; } } }
	Oct 13 23:16:22 fodhost db2dps[20372]: read 0 expired rules for exabgp2
	Oct 13 23:16:22 fodhost db2dps[20372]: sending 2 rules exabgp2
	Oct 13 23:16:22 fodhost db2dps[20372]: processing data for exabgp host localhost
	[.....]


And (lines truncated for readability)

	echo sudo tail -f /var/log/syslog | ssh q exabgp
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow          | 'route' '1992' '{'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-route    | 'match' '{'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-match    | 'source' '0.0.0.0/0' ';'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-match    | 'destination' '130.226.136.242/32' ';'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-match    | 'destination-port' '7635' ';'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-match    | 'protocol' 'udp' ';'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-match    | '}'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-route    | 'then' '{'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-then     | 'discard' ';'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-then     | '}'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | parsing | flow-route    | '}'
	Oct 13 23:16:22 exabgp2 | ......... | configuration | warning: no check on flows are implemented
	[....]

Once you have confirmed that you see the full workflow, you may conduct a _real life attack_ this way, from ``sysadm@172.16.70.102``:

    su -
	cd bin

This will give a list of pre-made attacks, where the names should be self explaining:

	attack.ddos-flood_14Mpps.sh
	attack.ddos-tcp_syn.sh
	attack.ddos-udp_dns_reverse.sh
	attack.dos-flood_14Mpps.sh
	attack.dos-http_connect.sh
	attack.dos-tcp_connect-flood.sh
	attack.dos-tcp_syn.sh
	check-10gbps-local.sh

## Mitigation through the Web-UI

It may be harder to catch what is going on when creating manual rules, as the database queries by default is each 10 sec. but the
technique is the same.



