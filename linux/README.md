# Sysmon for Linux

An open-source system monitor tool developed to collect security events from Linux environments using eBPF (Extended Berkeley Packet Filter) and sending them to Syslog for easy consumption. Sysmon for Linux is built on a library named [sysinternalsEBPF](https://github.com/Sysinternals/SysinternalsEBPF) which is built on [libbpf](https://github.com/libbpf/libbpf) including a library of eBPF inline functions used as helpers.

According to the [eBPF Foundation](https://ebpf.io/), eBPF is a technology that allows programs to run in a sandbox in an operating system kernel. In other words, eBPF enables programmers to write code which gets executed in kernel space in a more secure and restricted way in order to add additional capabilities to the operating system at runtime. 

From an event-tracing perspective, eBPF allows us to write event-driven programs and have pre-defined hooks into operations such as system calls, network connections, file write/read, etc. We can then collect those events and use them to understand adversary behavior during research or an investigation.

## Resources

* [Sysmon configurations](configs)

## References
* [https://techcommunity.microsoft.com/t5/azure-sentinel/automating-the-deployment-of-sysmon-for-linux-and-azure-sentinel/ba-p/2847054](https://techcommunity.microsoft.com/t5/azure-sentinel/automating-the-deployment-of-sysmon-for-linux-and-azure-sentinel/ba-p/2847054)