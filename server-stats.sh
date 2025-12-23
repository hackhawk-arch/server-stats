# system to run  the script using bash, wherever installed
#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status,
# if an undefined variable is used, or if any command in a pipeline fails
set -euo pipefail

# Function to print section headers in blue and bold
section() {
    printf '\n\e[1;34m=== %s ===\e[0m\n' "$1"
}

# OS & Uptime info
if [[ -f /etc/os-release]]: then
    . /etc/os-release
    echo "Distribution: $PRETTY_NAME"
else
    echo "Distribution : $(uname -s) $(uname -r)"
fi
echo "kernel         : $(uname -r)"
echo "Uptime         : $(uptime -p 2>/dev/null || uptime)"
echo "Load avarage   : $(uptime | awk -F'load avarage:' '{ print $2 }')"

# Logged in users
section "Logged in users"
who | awk '{printf "%-12s %-10s %s\n", $1, $2, $3" "$4}' || echo "No users logged in."

# recent failed ssh login attempts
# useful for spotting brute-force attacks
section "Recent failed SSH login attempts"
if command -v journalctl &>/dev/null; then
    journalctl -u ssh --since "1 day ago" | grep -i "failed password" | tail -n5 || echo "None (or journalctl unavailable)."
else
    grep -i "failed password" /var/log/auth.log | tail -n5 || echo "None (or log file not readable)."
fi

# CPU usage calculations
section "CPU Usage"
cpu_line1=$(awk '/^cpu /{print $2+$3+$4+$5+$6+$7+$8}' /proc/stat)
idle1=$(awk '/^cpu /{print $5}' /proc/stat)
sleep 0.1
cpu_line2=$(awk '/^cpu /{print $2+$3+$4+$5+$6+$7+$8}' /proc/stat)
idle2=$(awk '/^cpu /{print $5}' /proc/stat)

cpu_total=$((cpu_line2 - cpu_line1))
cpu_idle=$((idle2 - idle1))
cpu_usage=$((100 * (cpu_total - cpu_idle) / cpu_total))
echo "Total CPU Usage: ${cpu_usage}%"

# Memory usage
section "Memory Usage"
read -r mem_total mem_used mem_free mem_shared mem_bluff_cache mem_available \
    <<< "$(awk '/^MemTotal:/ {t=$2} /^MemFree:/ {f=$2} /^MemAvailable:/ {a=$2} END {u=t-a; printf "%d %d %d %d %d %d", t, u, f, 0, t-u-f, a}' /proc/meminfo)"

mem_total_mb=$((mem_total / 1024))
mem_used_mb=$((mem_used / 1024))
mem_free_mb=$((mem_available / 1024))
mem_used_pct=$((100 * mem_used / mem_total))

printf "Total: %6d MiB\n" "$mem_total_mb"
printf "Used : %6d MiB (%d%%)\n" "$mem_used_mb" "$mem_used_pct"
printf "Free : %6d MiB\n" "$mem_free_mb"

# Disk usage
section "Disk Usage"
read -r disk_size disk_used disk_avail disk_used_pct disk_mount \
    <<< "$(df -h / | awk 'NR==2 {print $2, $3, $4, $5, $6}')"
echo "Mount point : $disk_mount"
echo "Total size  : $disk_size"
echo "Used space  : $disk_used ($disk_used_pct)"
echo "Available   : $disk_avail"

# Top 5 memory-consuming processes
section "Top 5 Memory-Consuming Processes"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n6

# Top 5 CPU-consuming processes
section "Top 5 CPU-Consuming Processes"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n6

printf '\n\e[1;32mServer stats collected at %s\e[0m\n' "$(date)"