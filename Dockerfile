# Inspired by: 
#    http://uname.pingveno.net/blog/index.php/post/2014/02/01/Configure-Postfix-as-STMP-standalone-single-domain-server-using-Unix-users-and-PAM-on-Debian
#
# Test with:  
#   testsaslauthd -u postmaster -p password -f /var/spool/postfix/var/run/saslauthd/mux
#   perl -MMIME::Base64 -e 'print encode_base64("\000postmaster\000password")'  
#   openssl s_client -starttls smtp -crlf -connect localhost:587
#   AUTH PLAIN AHBvc3RtYXN0ZXIAcGFzc3dvcmQ=

FROM ubuntu:14.04
MAINTAINER Cloud Posse, LLC <hello@cloudposse.com>
ENV DEBIAN_FRONTEND noninteractive
ENV POSTMASTER_USER postmaster
ENV POSTMASTER_PASS password

ENTRYPOINT ["/start"]
EXPOSE 25

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    apt-get update && \
    apt-get --no-install-recommends -y install postfix sipcalc sasl2-bin libsasl2-modules && \
    postconf -e 'smtpd_sasl_auth_enable = yes' && \
    postconf -e 'smtpd_sasl_path = smtpd' && \
    postconf -e 'smtpd_sasl_local_domain =' && \
    postconf -e 'smtpd_sasl_authenticated_header = yes' && \
    rm /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/private/ssl-cert-snakeoil.key && \
    find /etc/ssl/certs -type l -xtype l -delete && \
    apt-get clean && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    find /var/lib/apt/lists -mindepth 1 -delete -print && \
    find /tmp /var/tmp -mindepth 2 -delete -print && \
    rm -f /etc/rsyslog.d/50-default.conf  && \
    adduser postfix sasl && \
    adduser --quiet --disabled-password -shell /bin/bash --home /home/$POSTMASTER_USER --gecos "Postmaster" $POSTMASTER_USER && \
    echo "$POSTMASTER_USER:$POSTMASTER_PASS" | chpasswd

ADD rootfs /
