FROM cetos
WORKDIR /root/TASK_4
COPY index.php /var/www/html
RUN yum install httpd -y
CMD /usr/sbin/httpd -DFOREGROUND && /bin/bash
EXPOSE 80
