# ZeroMQ

ZeroMQ (also known as 0MQ, or zmq) looks like an embeddable networking library but acts like a concurrency framework. It gives you sockets that carry atomic messages across various transports like in-process, inter-process, TCP, and multicast. You can connect sockets N-to-N with patterns like fan-out, pub-sub, task distribution, and request-reply. It's fast enough to be the fabric for clustered products. Its asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing tasks. It has a score of language APIs and runs on most operating systems.



Read more about ZeroMQ on their [website](https://zeromq.org/).





## Licensing

The libzmq library is licensed under the GNU Lesser General Public License V3 plus a static linking exception.



## The ZeroMQ module on the HPC

The ZeroMQ module can be loaded into your environment with the following command:

```bash
$ module add zeromq
```

The ZeroMQ module is available on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC3
  - zeromq 4.3.1
  - `module add zeromq/4.3.1`

```
