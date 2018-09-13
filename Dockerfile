FROM provisioning
LABEL maintainer="Hui Luo <luoh@vmware.com>"

COPY *.sh /cncf/
COPY ccm /cncf/ccm
COPY *.py /cncf/

CMD ["shell"]
ENTRYPOINT ["/cncf/orchestrator.sh"]
