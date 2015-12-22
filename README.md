
postfix mail server with configurable hostname and trusted hosts and proper
shutdown handling

Notes
===

By default, connected rfc1918 networks are detected and allowed. Local networks 
(127.0.0.1, ::1) are also allowed.

Syslog
===

Rsyslog is started automatically and sends logs to stdout

Suggested Volumes
===

  * `/var/spool/postfix` is the spool directory. Its also where postfix chroots to by default.
  * `/etc/postfix` is the configuation directory
  
Options
===

You can customize the image behavior using environmental variables or entrypoint
arguments.

<table>
    <thead>
        <th>Enviromental Variable(s)</th>
        <th>Entrypoint Option</th>
        <th>Description</th>
    </thead>
    <tbody>
        <tr>
        	<td>(use <code>--hostname</code>)</td>
	        <td><code>--mail-name</code></td>
	        <td>Mail name to use (appears in mail headers). Defaults to hostname</td>
	    </tr>
        <tr>
        	<td>RELAYHOST="[relay hostname]</td>
	        <td><code>--relayhost []</code></td>
	        <td>The host to relay mail to.</td>
	    </tr>
        <tr>
        	<td><code>TRUST="local"</code> or <code>TRUST_LOCAL="0"</code></td>
	        <td><code>--trust-local</code></td>
	        <td>Trust addresses on the lo interface. Enabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST="connected-rfc1918"</code> or <code>TRUST_CONNECTED_RFC="1"</code></td>
	        <td><code>--trust-connected-rfc1918</code></td>
	        <td>Trust all locally connected rfc1918 subnets. Enabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST="connected"</code> or <code>TRUST_CONNECTED="1"</td>
	        <td><code>--trust-connected</code></td>
	        <td>Trust all addresses connected (excluding IPv6 local-link addresses). Disabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST="rfc1918"</code> or <code>TRUST_RFC1918="1"</td>
	        <td><code>--trust-rfc1918</code></td>
	        <td>Trust all rfc1918 address. Disabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST_LLA="1"</code></td>
	        <td><code>--trust-lla</code></td>
	        <td>Trust the fe80::/64 IPv6 subnet. Disabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST_SUBNETS="[space separated list of subnets]"</code></td>
	        <td><code>--trust-subnet []</code></td>
	        <td>Trust the specified subnet (IPv4 and IPv6 supported). Disabled by default</td>
	    </tr>
        <tr>
        	<td><code>TRUST_INTERFACES="[space separated list of interfaces]"</code></td>
	        <td><code>--trust-interface []</code></td>
	        <td>Trust all network address on the interface (excluding IPv6 LLA). Disabled by default</td>
	    </tr>
        <tr>
        	<td></td>
	        <td><code>--skip-trust-</code>*</td>
	        <td>Use with local, connected-rfc1918, connected, rfc1918, or lla to skip trusting it. Disabled by default</td>
	    </tr>
        <tr>
        	<td></td>
	        <td><code>--skip-all</code></td>
	        <td>Disable/reset all trusts. Disabled by default</td>
	    </tr>
	</tbody>
</table>
