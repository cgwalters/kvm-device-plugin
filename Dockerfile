FROM registry.svc.ci.openshift.org/openshift/release:golang-1.15 AS builder
WORKDIR /go/src/github.com/cgwalters/kubernetes-device-plugins
COPY . .
RUN make

FROM registry.svc.ci.openshift.org/openshift/origin-v4.0:base
COPY --from=builder /go/src/github.com/cgwalters/kubernetes-device-plugins/cmd/kvm /usr/bin/device-plugin-kvm
CMD ["/usr/bin/device-plugin-kvm"]
