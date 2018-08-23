FROM provision
LABEL maintainer="Hui Luo <luoh@vmware.com>"

COPY *.sh /cmd/

CMD ["shell"]
ENTRYPOINT ["/cmd/provision.sh"]