# SOC Home Lab

A hands-on Security Operations Center (SOC) home lab built to develop and demonstrate practical blue team skills: Active Directory administration, log collection and analysis, attack simulation, and detection engineering.

## Machines

| Host | IP | OS | Role |
|---|---|---|---|
| Splunk-Server | 192.168.10.10 | Ubuntu 22.04 | SIEM (Splunk Enterprise 10.4.1) |
| DC01 | 192.168.10.20 | Windows Server 2022 | Domain Controller (homelab.local) |
| Win11-Client | 192.168.10.30 | Windows 11 Enterprise | Domain-joined endpoint |
| Kali | 192.168.10.40 | Kali Linux | Attack box |

All hosts run on a VirtualBox internal network, with NAT configured for internet access where needed.

## Tools

- Splunk Enterprise (SIEM / log analysis)
- Sysmon (SwiftOnSecurity config) for endpoint telemetry
- Splunk Universal Forwarder (DC01, Win11-Client)
- Kali Linux (attack platform)

## Repository Structure

```
detections/   Detection reports (DR-XXX)
playbooks/    Incident response playbooks
reports/      Investigations and deep dives
scripts/      Custom tooling and automation
```
