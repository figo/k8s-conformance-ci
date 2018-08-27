FROM provisioning
LABEL maintainer="Hui Luo <luoh@vmware.com>"

COPY *.sh /cncf/

CMD ["shell"]
ENTRYPOINT ["/cncf/orchestrator.sh"]
