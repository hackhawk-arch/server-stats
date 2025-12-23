
````md
# Server Stats – Dockerized Linux Health Monitor

A lightweight, Docker-based Bash script that provides a quick health snapshot
of a Linux system. Built as a DevOps learning project and designed for
observability, monitoring, and infrastructure diagnostics.

---

## 🚀 Features

- OS and kernel information
- System uptime and load average
- Logged-in users
- Recent failed SSH login attempts
- Real CPU usage calculation
- Accurate memory usage (using `MemAvailable`)
- Disk usage for root filesystem
- Top CPU- and memory-consuming processes

---

## 🛠️ Tech Stack

- Bash
- Alpine Linux
- Docker
- Linux `/proc` filesystem
- WSL2 (Windows 11 compatible)

---

## 📁 Project Structure

```text
server-stats/
├── server-stats.sh
├── Dockerfile
├── .dockerignore
├── .gitignore
├── README.md
└── LICENSE
````

---

## ✅ Supported Systems

Tested on:

* Alpine Linux
* Ubuntu 18.04 / 20.04 / 22.04
* Debian 10 / 11 / 12
* RHEL / CentOS 7 / 8 / 9

---

## ▶️ Usage (Local)

```bash
git clone https://github.com/hackhawk-arch/server-stats.git
cd server-stats
chmod +x server-stats.sh
./server-stats.sh
```

---

## 🐳 Docker Usage (Recommended)

This script can be run inside a Docker container while still collecting
Linux system metrics.

### Build the image

```bash
docker build -t server-stats .
```

### Run the container

```bash
docker run --rm \
  --pid=host \
  server-stats
```

> ⚠️ Note: Access to host system metrics requires elevated permissions.

---

## 🪟 WSL2 Limitation Notice

When running Docker on Windows 11 using WSL2, mounting `/proc` or `/sys`
from the host into the container is **not supported**.

For WSL2 environments, run the container using:

```bash
docker run --rm --pid=host server-stats
```

When using WSL2, the reported metrics reflect the Linux (WSL) environment,
not the Windows host operating system.

---

## 🔧 Portability & Compatibility Notes

### Line Endings (Windows Users)

When editing `server-stats.sh` on Windows, ensure the file uses Unix (LF)
line endings. Windows-style CRLF line endings may cause syntax errors
when running inside Linux containers.

Recommended fix:

```bash
dos2unix server-stats.sh
```

### Shell Compatibility

The script uses POSIX-compatible conditionals (`[ ... ]`) instead of
Bash-only syntax (`[[ ... ]]`) to ensure reliable execution across:

* Alpine Linux
* Minimal containers
* CI/CD runners
* WSL-based environments

---

## 🧠 Why this project?

This project demonstrates:

* Linux system internals awareness
* Bash scripting best practices
* Docker containerization
* Host vs container isolation understanding
* Cross-platform (Windows + Linux) compatibility
* Observability and monitoring fundamentals

---

## 🗺️ Roadmap

* [ ] GitHub Actions CI (ShellCheck + Docker build)
* [ ] Docker Compose setup
* [ ] Cron-based execution
* [ ] Prometheus metrics exporter
* [ ] Publish image to Docker Hub

---
