
# Influx db and fastnetmon

See
[INFLUXDB_INTEGRATION.md](https://github.com/FastVPSEestiOu/fastnetmon/blob/master/docs/INFLUXDB_INTEGRATION.md)
on github.

Our _physical fastnetmon_ has the IP address ``172.22.89.2`` and is accessible from ``fodhost``.

Accessing the data is done with
[http](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol), that is
_unencrypted_, without
[authorisation](https://en.wikipedia.org/wiki/Basic_access_authentication) and
without any access control enabled on the database. This is done deliberately,
as access to the fastnetmon (i.e. 172.22.89.2) will be restricted solely to the
database server using e.g. [iptables](https://en.wikipedia.org/wiki/Iptables)
and only through a [VPN tunnel](https://en.wikipedia.org/wiki/OpenVPN), thereby
making any other access control and data integrity mechanism needless.

You may also access 172.22.89.2 as ``root`` from ``rnd@fodhost``.        
_In the future there will be no other network based access_, and console access
will not be required upon deployment.

I've installed version 1.0.2 of Influxdb.

Here is a short list of influx resources - the last is the most important:

  - [InfluxDB integration with fastnetmon](https://github.com/FastVPSEestiOu/fastnetmon/blob/master/docs/INFLUXDB_INTEGRATION.md)
  - [How InfluxDB Stores Data](http://grisha.org/blog/2015/03/20/influxdb-data/)
  - [query language and schema exploration](https://docs.influxdata.com/influxdb/v1.0/query_language/schema_exploration/)

Info:        

  - database name: ``graphite``
  - measurements: ``hosts``, ``networks``, ``total``
  - Tag keys: .... 

The database can be accessed from the command line (easy once on 172.22.89.2),
using [the web interface (http://172.22.89.2:8083)](http://172.22.89.2:8083) or
extract the information as [json](https://en.wikipedia.org/wiki/JSON).

```bash
cat << EOF | influx
use graphite
SHOW TAG KEYS
EOF
```

  - ``curl "http://172.22.89.2:8086/query?q=show+measurements&db=graphite&pretty=true"``

Extracting information is done this way - e.g. ``select * from networks``:

  - ``curl "http://172.22.89.2:8086/query?q=select+*+from+networks&db=graphite&pretty=true"``

The result is some thing like this:

```
    "results": [
        {
            "series": [
                {
                    "name": "networks",
                    "columns": [
                        "time",
                        "app",
                        "cidr",
                        "direction",
                        "resource",
                        "value"
                    ],
                    "values": [
                        [
                            "2016-11-04T13:15:15Z",
                            "fastnetmon",
                            "130_226_136_240_28",
                            "incoming",
                            "bps",
                            0
                        ],
                        [
                            "2016-11-04T13:15:15Z",
                            "fastnetmon",
                            "192_168_199_2_32",
                            "outgoing",
                            "pps",
                            0
                        ],

....

```

Please notice [cidr](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) is written
as e.g. ``130_226_136_240_28`` but should be interpreted as ``130_226_136_240/28``.

Resource is one of

  - _pps_:  _packets pr second_
  - _bps_: _bits pr second_

Other useful resources:

  - [IP addresses and subnets](https://www.digitalocean.com/community/tutorials/understanding-ip-addresses-subnets-and-cidr-notation-for-networking)
  - [A visual subnet calculator](http://www.davidc.net/sites/default/subnets/subnets.html)
  - [Internet protocols](https://en.wikipedia.org/wiki/Internet_Protocol)
  - [Wikipedia on TCP and UDP port numbers](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers) 


