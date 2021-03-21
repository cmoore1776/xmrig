FROM --platform=amd64 alpine:edge

RUN \
  apk add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev linux-headers musl-dev && \
  git clone https://github.com/xmrig/xmrig && \
  mkdir xmrig/build && \
  cd xmrig/build && \
  sed -i '1s/^/#include <limits.h>\n/' /xmrig/src/backend/opencl/wrappers/AdlLib_linux.cpp && \
  cmake ..  && \
  make -j$(nproc)

ENTRYPOINT [ "/xmrig/build/xmrig" ]