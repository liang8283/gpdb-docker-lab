#
#  Dockerfile for a GPDB SNE Sandbox GPCC Image
#

FROM gpdb_4382

#Load Files
COPY * /tmp/

#GPCC Core Install and Related Items
RUN     yum -y install crontabs \
        && echo $(grep $(hostname) /etc/hosts | cut -f1) mdw >> /etc/hosts \
        && service sshd start \
#        && su gpadmin -l -c "gpstart -a" \
 	&& mv /tmp/gpcc.sh /usr/local/bin/gpcc.sh \
 	&& chmod +x /usr/local/bin/gpcc.sh  \
        && mv /tmp/run.sh /usr/local/bin/run.sh \
        && chmod +x /usr/local/bin/run.sh \
        && unzip /tmp/greenplum-cc-web*.zip -d /tmp/ \
        && rm /tmp/greenplum-cc-web*.zip \
        && echo -e "yes\n\nyes\nyes\n" | /tmp/greenplum-cc-web*.bin \
	&& rm /tmp/greenplum-cc-web*.bin \
        && mv /tmp/bash_profile /home/gpadmin/.bash_profile \
        && su gpadmin -l -c "/usr/local/bin/gpcc.sh"

#Set up environmentals
EXPOSE 28080
#VOLUME /data

CMD echo $(grep $(hostname) /etc/hosts | cut -f1) mdw  >> /etc/hosts \     
        && echo "127.0.0.1 $(cat ~/orig_hostname)" >> /etc/hosts \
        && service sshd start \
        && su gpadmin -l -c "/usr/local/bin/run.sh" \
#        && su gpadmin -l -c "/usr/local/bin/gpcc.sh" \
        && /bin/bash
