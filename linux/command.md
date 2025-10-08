# Command

That’s a great goal — learning **Linux commands** will help you a lot as a software engineer, especially for DevOps, SRE, and backend work.
Let’s start step-by-step 👇

---

## 🧭 1. What Is Linux?

**Linux** is an open-source operating system used for servers, development environments, and embedded systems.
The terminal (or “shell”) is where you type commands to interact with the system.

```sh
docker run -it ubuntu bash
```

---

## 💻 2. Basic Command Categories

| Category               | Example Commands                      | Description                                  |
| ---------------------- | ------------------------------------- | -------------------------------------------- |
| **Navigation**         | `pwd`, `cd`, `ls`                     | Move around the file system                  |
| **File Operations**    | `cp`, `mv`, `rm`, `mkdir`, `rmdir`    | Copy, move, delete, and manage directories   |
| **File Viewing**       | `cat`, `less`, `head`, `tail`         | Display file contents                        |
| **Permissions**        | `chmod`, `chown`, `ls -l`             | Change file permissions and ownership        |
| **System Info**        | `uname -a`, `top`, `df -h`, `free -m` | Check OS, CPU, memory, and disk info         |
| **Networking**         | `ping`, `curl`, `netstat`, `ss`       | Test connectivity and monitor network status |
| **Package Management** | `apt`, `yum`, `dnf`, `brew`           | Install and update software packages         |
| **Process Management** | `ps`, `kill`, `htop`                  | List or stop running processes               |
| **Text Search**        | `grep`, `find`, `locate`              | Search files or directories                  |
| **User Management**    | `whoami`, `useradd`, `passwd`         | Manage users and passwords                   |

---

## ⚙️ 3. Example Commands

```bash
# Check current directory
pwd

# List files (long format + human readable sizes)
ls -lh

# Change directory
cd /etc

# Create and remove folders
mkdir my_folder
rmdir my_folder

# Copy and move files
cp file1.txt backup/
mv file1.txt folder/

# Display the first 10 lines of a file
head file1.txt

# Search for a word in a file
grep "error" logfile.txt

# Show running processes
ps aux | grep nginx

# Display disk usage
df -h

# Show memory usage
free -m
free -h
```

---

## 🚀 4. Learning Plan

| Week   | Focus                            | Practice Ideas                           |
| ------ | -------------------------------- | ---------------------------------------- |
| Week 1 | Basic navigation & file commands | Move around `/home`, create/delete files |
| Week 2 | Viewing, editing & permissions   | Use `cat`, `chmod`, and `nano`           |
| Week 3 | System & process management      | Try `ps`, `kill`, `top`, `htop`          |
| Week 4 | Networking & package management  | Use `ping`, `curl`, and install packages |

---

## 💡 Tips

* Use `man <command>` to read the manual, e.g. `man ls`.
* Try `--help` after any command for quick info, e.g. `ls --help`.
* Practice daily in a Linux environment or use **WSL (Windows Subsystem for Linux)** or **Docker container**.

# Advanced Linux Command-Line (CLI) topics

Excellent — you’ve already mastered the essentials 🎯
Now let’s move into **Advanced Linux Command-Line (CLI) topics**, which are powerful for engineers, SREs, and developers like you.

Below is a **structured roadmap** with explanations, examples, and practice ideas.

---

## ⚙️ **1. File Operations — the Advanced Way**

### 🔹 `find` — locate files dynamically

```bash
find /var/log -type f -name "*.log" -size +10M
find /var/log -type f -name "*.log"
```

> Find all `.log` files larger than 10 MB in `/var/log`.

### 🔹 `grep` — powerful text searching

```bash
grep -r "error" /var/log
grep -i "timeout" nginx.log
```

> `-r`: recursive, `-i`: case-insensitive

### 🔹 Combine with pipes (`|`)

```bash
cat access.log | grep "200" | wc -l
```

> Count how many HTTP 200 lines appear in `access.log`.

---

## 🧩 **2. Pipes, Redirection & Operators**

| Operator | Function                            | Example                        |                                 |           |   |                |
| -------- | ----------------------------------- | ------------------------------ | ------------------------------- | --------- | - | -------------- |
| `>`      | Redirect output to file (overwrite) | `echo "hi" > file.txt`         |                                 |           |   |                |
| `>>`     | Append output                       | `echo "again" >> file.txt`     |                                 |           |   |                |
| `<`      | Input from file                     | `cat < file.txt`               |                                 |           |   |                |
| `        | `                                   | Pipe output to another command | `ls                             | grep txt` |   |                |
| `&&`     | Run next only if previous succeeds  | `mkdir test && cd test`        |                                 |           |   |                |
| `        |                                     | `                              | Run next only if previous fails | `cd /nope |   | echo "failed"` |

---

## 🧠 **3. Process & Job Control**

| Command        | Description                        |
| -------------- | ---------------------------------- |
| `ps aux`       | Show all running processes         |
| `top` / `htop` | Interactive process monitor        |
| `kill PID`     | Terminate a process                |
| `bg`, `fg`     | Send jobs to background/foreground |
| `jobs`         | List background jobs               |
| `nohup`        | Run command immune to hangups      |

Example:

```bash
python3 server.py &
jobs
fg %1
```

---

## 🧮 **4. Disk, Memory & Performance Monitoring**

| Command    | Description                |
| ---------- | -------------------------- |
| `df -h`    | Disk usage                 |
| `du -sh *` | Size of directories        |
| `free -h`  | Memory usage               |
| `vmstat 2` | CPU/memory stats every 2 s |
| `iostat`   | Disk I/O                   |
| `uptime`   | System load averages       |

> 🧩 Try `watch -n 1 free -h` — real-time memory refresh.

---

## 🧰 **5. System Management & Scheduling**

### 🔹 `systemctl`

```bash
sudo systemctl status nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### 🔹 `cron` — scheduled tasks

```bash
crontab -e
# Example: backup every night
0 2 * * * /usr/local/bin/backup.sh
```

---

## 🧱 **6. Networking & Security Tools**

| Command                        | Description              |
| ------------------------------ | ------------------------ |
| `netstat -tulnp` / `ss -tulnp` | Ports in use             |
| `lsof -i :80`                  | Processes using port 80  |
| `curl -I https://example.com`  | HTTP headers             |
| `scp` / `rsync`                | Secure copy / sync files |
| `ufw enable` / `ufw allow 22`  | Ubuntu Firewall          |
| `ssh user@ip`                  | Connect to remote server |
| `ssh-keygen`                   | Create SSH key pair      |

Example:

```bash
rsync -avz /var/www/ root@192.168.1.2:/backup/
```

---

## 🧾 **7. Package & Log Management**

### 🔹 Logs

```bash
tail -f /var/log/syslog
journalctl -xe
```

### 🔹 Packages

```bash
apt list --installed
apt show nginx
dpkg -L nginx
```

---

## 💡 **8. Environment & Shell Configuration**

| File               | Purpose                    |
| ------------------ | -------------------------- |
| `~/.bashrc`        | Shell settings and aliases |
| `~/.profile`       | Environment variables      |
| `/etc/environment` | System-wide vars           |

Example — add alias:

```bash
echo "alias ll='ls -la --color=auto'" >> ~/.bashrc
source ~/.bashrc
```

---

## ⚙️ **9. Bash Scripting Basics**

Simple automation example:

```bash
#!/bin/bash
for file in *.log; do
  echo "Processing $file"
  grep "ERROR" "$file" >> errors.txt
done
```

Run it:

```bash
chmod +x script.sh
./script.sh
```

---

## 🧱 **10. Advanced Tools for Engineers**

| Tool         | Description                                    |
| ------------ | ---------------------------------------------- |
| `tmux`       | Terminal multiplexer (split screens, sessions) |
| `screen`     | Similar to tmux                                |
| `awk`, `sed` | Text processing and pattern substitution       |
| `xargs`      | Build command lines from input                 |
| `watch`      | Run command repeatedly                         |
| `strace`     | Trace system calls                             |
| `dmesg`      | Kernel logs                                    |

Example:

```bash
cat access.log | awk '{print $9}' | sort | uniq -c
```

> Count HTTP status codes from log file.

---

## 🚀 **11. Practice Project Ideas**

| Project                   | Description                                                |
| ------------------------- | ---------------------------------------------------------- |
| 🧹 **Log Cleaner Script** | Create a script to find and remove logs older than 7 days. |
| 🧾 **Backup Automation**  | Use `tar`, `cron`, and `rsync` to back up `/home`.         |
| 🧠 **System Monitor**     | Write a script showing CPU/mem/disk usage every 5 s.       |
