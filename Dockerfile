FROM provisioning
LABEL maintainer="Hui Luo <luoh@vmware.com>"

COPY *.sh /cncf/
COPY ccm /cncf/ccm

CMD ["shell"]
ENTRYPOINT ["/cncf/orchestrator.sh"]
