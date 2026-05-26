# SOC Home Lab

Built this lab from scratch to get hands-on experience with the tools and workflows used in real SOC environments. Everything here is self-built and actively used for daily detection and threat hunting practice.

## Lab Architecture

| VM | OS | Role | IP |
|---|---|---|---|
| DC01 | Windows Server 2022 | Active Directory Domain Controller | 192.168.10.10 |
| WIN11-Client | Windows 11 Pro | Domain-joined endpoint | 192.168.10.20 |
| ELK-Server | Ubuntu 22.04 | Elasticsearch + Kibana SIEM | 192.168.10.30 |

## Tools & Technologies
- **Active Directory** - domain `lab.local`, OUs, GPOs, 20 domain users
- **Sysmon** - endpoint telemetry with SwiftOnSecurity ruleset, deployed via GPO
- **Winlogbeat** - log shipping from Windows endpoints to Elasticsearch
- **Elastic Stack** - Elasticsearch 8.x + Kibana for log ingestion and analysis
- **PowerShell** - automation scripts for AD auditing and security reporting
- **KQL** - threat hunting queries in Kibana

## What I Built
- Three-VM enterprise lab on isolated internal network
- Active Directory domain with GPO-enforced password policy, audit logging, and Sysmon deployment
- End-to-end log ingestion pipeline from two Windows endpoints into Kibana
- Brute force attack simulation and detection using RDP failed logon events (Event ID 4625)
- AD user audit script identifying stale and inactive accounts
- KQL detection queries for authentication failures, process creation, and lateral movement indicators

## Key Event IDs Monitored
| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon - brute force detection |
| 4634 | Account logoff |
| 4720 | New user account created |
| 4740 | Account lockout |
| 4672 | Special privileges assigned |
| Sysmon 1 | Process creation |
| Sysmon 3 | Network connection |

## Repository Structure

- **scripts/** - PowerShell automation scripts
- **detections/** - KQL query library  
- **playbooks/** - Incident response playbooks
- **reports/** - Weekly threat reports


## Author
Deborah Adeline George - Cybersecurity Analyst
