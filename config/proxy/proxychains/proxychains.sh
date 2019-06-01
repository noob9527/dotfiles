#!/bin/sh
echo "ProxyChains-3.1 (http://proxychains.sf.net)"
if [ $# = 0 ] ; then
	echo "	usage:"
	echo "		proxychains <prog> [args]"
	exit
fi
export LD_PRELOAD=$(find /usr/lib/ -name libproxychains.so.3 -print)
exec "$@"
