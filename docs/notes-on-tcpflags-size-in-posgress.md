
# TCP flags field

The following flags exists [list from Wikipedia](http://en.wikipedia.org/wiki/Transmission_Control_Protocol)

| TCP flag | Description |
|:------ |:------------- |
|CWR | Congestion Window Reduced (CWR) flag is set by the sending host to indicate that it received a TCP segment with the ECE flag set (added to header by RFC 3168).|
|ECE (ECN-Echo) | indicate that the TCP peer is ECN capable during 3-way handshake (added to header by RFC 3168).|
|URG | indicates that the URGent pointer field is significant|
|ACK | indicates that the ACKnowledgment field is significant (Sometimes abbreviated by tcpdump as ".")|
|PSH | Push function|
|RST | Reset the connection (Seen on rejected connections)|
|SYN | Synchronize sequence numbers (Seen on new connections)|
|FIN | No more data from sender (Seen after a connection is closed)|

Fastnetmon prints the flags as strings e.g. _SYN_, multiple flags (aka
[xmastree](https://en.wikipedia.org/wiki/Christmas_tree_packet)) is printed as a list, separated by ','.

Exabgp also expects the TCP flags to in text format so.

So, the field for storing TCP flags in the database has been set to 32 chars.
