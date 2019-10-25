#
#  iptables additions that allows HTTP/HTTPS whitelists, then blocks everything else...but only for HTTP/HTTPS connections on their standard ports
#

zsh /opt/school/tools/unblock_sites.sh
hostlist="olimpiada.programuj.edu.pl cppreference.com"

# Create some new chains for these rules
iptables -N BLOCK_OUTBOUND_HTTP
iptables -N BLOCK_OUTBOUND_HTTPS
iptables -N OUTBOUND_HTTP_WHITELIST
iptables -N OUTBOUND_HTTPS_WHITELIST
iptables -N RESTRICT_OUTBOUND_WEB

# Block all outgoing HTTP
iptables -A BLOCK_OUTBOUND_HTTP
iptables -A BLOCK_OUTBOUND_HTTP -p tcp --dport 80 -j REJECT
iptables -A BLOCK_OUTBOUND_HTTP -j RETURN

# Block all outgoing HTTPS
iptables -A BLOCK_OUTBOUND_HTTPS
iptables -A BLOCK_OUTBOUND_HTTPS -p tcp --dport 443 -j REJECT
iptables -A BLOCK_OUTBOUND_HTTPS -j RETURN

# Allow HTTP to specific destination hosts (replace <host> with a hostname, IP, network, etc.)
iptables -A OUTBOUND_HTTP_WHITELIST -p tcp ! --dport 80 -j RETURN
for host in $(echo $hostlist); do
	iptables -A OUTBOUND_HTTP_WHITELIST --destination $host -j ACCEPT
done
iptables -A OUTBOUND_HTTP_WHITELIST -j RETURN

# Allow HTTPS to specific destination hosts (replace <host> with a hostname, IP, network, etc.)
iptables -A OUTBOUND_HTTPS_WHITELIST -p tcp ! --dport 443 -j RETURN
for host in $(echo $hostlist); do
	iptables -A OUTBOUND_HTTPS_WHITELIST --destination $host -j ACCEPT
done
iptables -A OUTBOUND_HTTPS_WHITELIST -j RETURN

# Group the above into an easier to include chain
iptables -A RESTRICT_OUTBOUND_WEB -j OUTBOUND_HTTP_WHITELIST
iptables -A RESTRICT_OUTBOUND_WEB -j OUTBOUND_HTTPS_WHITELIST
iptables -A RESTRICT_OUTBOUND_WEB -j BLOCK_OUTBOUND_HTTP
iptables -A RESTRICT_OUTBOUND_WEB -j BLOCK_OUTBOUND_HTTPS
iptables -A RESTRICT_OUTBOUND_WEB -j RETURN

# Link the new chains into our OUTPUT chain
iptables -A OUTPUT -j RESTRICT_OUTBOUND_WEB
iptables -A OUTPUT -j ACCEPT
