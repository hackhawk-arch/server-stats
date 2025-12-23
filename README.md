# Server Stats – Dockerized Linux Health Monitor

A lightweight, Docker-based Bash script that provides a quick health snapshot
of a Linux system. Built as a DevOps learning project and designed for
observability, monitoring, and infrastructure diagnostics.

## 🚀 Features

- OS and kernel information
- System uptime and load average
- Logged-in users
- Recent failed SSH login attempts
- Real CPU usage calculation
- Accurate memory usage (using MemAvailable)
- Disk usage for root filesystem
- Top CPU- and memory-consuming processes

## 🛠️ Tech Stack

- Bash
- Alpine Linux
- Docker
- Linux `/proc` filesystem
- WSL2 (Windows 11 compatible)

## 📁 Project Structure

```text
server-stats/
├── server-stats.sh
├── Dockerfile
├── .dockerignore
├── .gitignore
├── README.md
└── LICENSE
```
## Supported Systems

Tested on:
- Alpine
- Ubuntu 18.04 / 20.04 / 22.04
- Debian 10 / 11 / 12
- RHEL / CentOS 7 / 8 / 9

## Usage

```bash
git clone https://github.com/hackhawk-arch/server-stats.git
cd server-stats
chmod +x server-stats.sh
./server-stats.sh
```

## Docker Usage (Recommended)

This script can be run inside a Docker container while still collecting
host system metrics.

### Build image

```bash
docker build -t server-stats .

docker run --rm \
  --pid=host \
  -v /proc:/proc:ro \
  -v /sys:/sys:ro \
  server-stats
```
Note: Access to host system metrics requires elevated permissions.

---

## 8. WSL2 + Docker Desktop notes (important for reviewers)

This project is tested using Docker Desktop with WSL2 integration.  
Refer to the following documentation if you encounter issues:

- [Install WSL on Windows](https://learn.microsoft.com/windows/wsl/install)
- [Docker Desktop WSL2 backend](https://docs.docker.com/desktop/wsl/)

When running on Windows 11 with WSL2 and Docker Desktop, the script
reports metrics for the Linux environment (WSL VM), not the Windows host.




