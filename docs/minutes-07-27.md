
### Meeting 07-27

#### Questions by Tangui:

1. how to give temporary access to Anders (and maybe others) to the database in
   order to add or expire flowspec rules. Niels Thomas has an idea. As soon as
   Ash is back, we will of course focus on giving access to the GUI (which
   should be hosted at the right place);

2. How to monitor the different components, starting with seeing if they are
   alive (2.1) as we didn't know one of the ExaBGP instance was down and (2.2)
   if announced rules are actually activated in the routers (Niels Thomas
   suggested having a script creating dummy rules for this purpose);

3. Issues with the ISO images Niels Thomas is working on to deploy new
   FastNetMon instances (with the right IP address + OpenVPN config).

#### Answers:

1. SSH host access has been granted permanently to both Anders, Ashokaditya,
   Kasper Nice, Tangui and Thomas as your preferred initials. Please add your
   public keys e.g.  by using the shared login or by sending the public RSA or
   ed25519 key to me.  Your account is locked, you cannot use a password with
   it.  Also your account has full rights for everything with `sudo`. (Still
   you break it, you own it).

   Direct postgres database editing is error prone. Still we all have direct
   access with a variety of tools including command line.      
   I came up with this command for adding ad-hoc rules, removing rules (set
   expire time to now) and print rules, and think this is better than direct
   database editing:

      	/opt/db2dps/bin/ddpsrules [-V | -h] [add | del | print]

   Check rules has been enforced with

      	sudo sed '/rule:.*match/!d' /var/log/syslog

   When deleting rules the _flowspecruleid_ has to be provided. Use the _print_
   argument to find it.

2. Anders and Thomas has decided that monitoring should be done by the RND team,
   and they have free hands to find the best solution.

3. A work around for setting the keyboard permanently has been found. Pavel
   Odintsov is working on adding _FastNetMon_ to the Debian package tree, which
   will hopefully make the installation of FastNetMon and the Intel 10Gb drivers
   a breeze compared to now. Still we need a solution for now and I'm working 
   creating ISO images for unattended installation. Please see `/opt/mkiso` on
   the DDPS host.       
   A few solved problems:

   - How to ensure an OpenVPN client always gets the same IP address
   - How to setup OpenVPN in such a way that hosts behind the VPN gateway
     can access services on the client
	
  I will create one ISO with different versions of FastNetMon and the drivers
  and let the installation procedure decide which version (package) to install
  depending on the hardware.

  Once that has been done, it will be time to migrate the ddps host to a new
  environment with direct access for developers as now, but protected by a
  firewall / VPN cluster, have the database redundant and a new set of exabgp
  hosts installed as well. I have informed Frank of the plan, but there is
  no blue print yet.



