#!/bin/bash
# ===========================
# SYSTEM HEALTH CHEK SCRIPT
# ===========================


# --- Configuration ---
REPORT_DIR="$HOME/reports"
REPORT_FILE="$REPORT_DIR/syscheck_$(date +%Y%m%d_%H%M%S).txt"
DISK_WARNING=80         # warn if disk usage is above 80%
MEM_WARNING=80          # WARN if memory usage is above 80%


# --- Colors for terminal output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'


# --- Helper Functions ---
print_header() {
    echo -e "\n${BLUE}==============================${NC}"
    echo -e "${BLUE}    $1${NC}"
    echo -e "${BLUE}=============================${NC}"
}


print_ok() {
   echo -e "    ${GREEN}[OK]${NC} $1" 
}


print_warn() {
    echo -e "   ${YELLOW}[WARN]${NC} $1"
}


print_error() {
   echo -e "    ${RED}[ERROR]${NC} $1" 
}


# --- Setup ---
setup() {
    mkdir -p "$REPORT_DIR"
    echo "System Health Check Report" > "$REPORT_FILE"
    echo "Generated: $(date)" >> "$REPORT_FILE"
    echo "Host: $(hostname)" >> "$REPORT_FILE"
    echo "================================" >> "$REPORT_FILE"
}

system_info() {
   print_header "System Information"

   local os=$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)
   local kernel="$(uname -r)"
   local hostname=$(hostname)
   local uptime=$(uptime -p)
   local cpu=$(grep "model name" /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)
   local cpu_cores=$(nproc)

   echo "   OS:         $os"
   echo "   kernel:     $kernel"
   echo "   Host:       $hostname"
   echo "   Uptime:     $uptime"
   echo "   CPU:        $cpu"
   echo "   Cores:      $cpu_cores"


   # Log to file
   echo "" >> "$REPORT_FILE"
   echo "SYSTEM INFO" >> "$REPORT_FILE"
   echo "   OS: $os" >> "$REPORT_FILE"
   echo "   Kernel: $kernel" >> "$REPORT_FILE"
   echo "   Uptime: $uptime" >> "$REPORT_FILE"
}

memory_check() {
   print_header "Memory Usage"

   local total=$(free -m | awk '/^Mem:/ {print $2}')
   local used=$(free -m | awk '/^Mem:/ {print $3}')
   local free_mem=$(free -m | awk '/^Mem:/ {print $4}')
   local percent=$((used * 100 / total))

   echo "   Total:  ${total}MB"
   echo "   Used:   ${used}MB (${percent}%)"
   echo "   Free:   ${free_mem}MB"

   if [ $percent -ge $MEM_WARNING ]; then
       print_warn "Memory usage is high: ${percent}%"
   else
       print_ok "Memory usage is normal: ${percent}%"
   fi

   echo "" >> "$REPORT_FILE"
   echo "MEMORY" >> "$REPORT_FILE"
   echo "   Used: ${used}MB / ${total}MB (${percent}%)" >> "$REPORT_FILE"
}

# --- Disk Check ---
disk_check() {
   print_header "Disk Usage"

   # Check ceach mounted filesystem
   while IFS= read -r line; do
       local usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
       local mount=$(echo "$line" | awk '{print $6}')
       local size=$(echo "$line" | awk '{print $2}')
       local used=$(echo "$line" | awk '{print $3}')

       echo "   Mount: $mount"
       echo "   Size: $size     Used: $used (${usage}%)"

       if [ "$usage" -ge "$DISK_WARNING" ] 2>/dev/null; then
           print_warn "Disk usage high on $mount: ${usage}%"
       else
           print_ok "Disk usage ok on $mount: ${usage}%"
       fi
       echo ""

       echo "    Disk $mount: ${usage}% used" >> "$REPORT_FILE"    
   done < <(df -h | grep '^/dev/')
}


# --- Network Check ---
network_check() {
    print_header "Network Connectivity"

    local hosts=("cloudflare.com" "github.com" "google.com")
    
    for host in "${hosts[@]}"; do
        if curl -s --connect-timeout 2 "$host" &>/dev/null; then
            print_ok "$host reachable"
            echo "   $host: OK" >> "$REPORT_FILE"
        else
            print_error "$host: FAILED" >> "$REPORT_FILE"
        fi
    done

    # Show IP address
    local ip=$(hostname -I | awk '{print $1}')
    echo ""
    echo "  Local IP: $ip"
}


# --- Process Check ---
process_check() {
    print_header "Top Processes by CPU"

    ps aux --sort=%cpu | head -6 | tail -5 | \
    while read -r line; do
        local cpu=$(echo "$line" | awk '{print $3}')
        local mem=$(echo "$line" | awk '{print $4}')
        local cmd=$(echo "$line" | awk '{print $11}')
        printf "    %-30s CPU: %5s%%  MEM: %5s%%\n" \
            "$(basename $cmd)" "$cpu" "$mem"
    done
}


# --- IMportant Services Check ---
services_check() {
    print_header "Command Availability"

    local commands=("python3" "git" "nvim" "nasm" "gcc" "curl" "wget")

    for cmd in "${commands[@]}"; do
        if command -v "$cmd" &>/dev/null; then
            local version=$("$cmd" --version 2>&1 | head -1)
            print_ok "$cmd: $version"
        else
            print_warn "$cmd: not found"
        fi
    done
}


# --- Summary ---
summary() {
   print_header "Report Summary"
   echo "   Report saved to:    $REPORT_FILE"
   echo "   Generated at:       $(date)"
   echo ""
   echo "   Run again anytime with:"
   echo "   ~/projects/bash/syscheck.sh"
}


# --- Main ---
main() {
    clear
    echo -e "${BLUE}"
    echo "  ==================================="
    echo "  =                                 ="
    echo "  =   SYSTEM HEALTH CHECK           ="
    echo "  =   $(date +"%Y-%m-%d %H:%M:%S")           ="
    echo "  =                                 ="
    echo "  ==================================="
    echo -e "${NC}"

    setup
    system_info
    memory_check
    disk_check
    network_check
    process_check
    services_check
    summary
}


# Run main
main
