# Ubuntu

Perfect — let’s go over **Ubuntu CLI (Command Line Interface)** so you can start using it confidently.

---

## 🧭 1. What the Ubuntu CLI Is

The **CLI (Command Line Interface)** is a text-based way to interact with Ubuntu (and all Linux systems).
You use it through the **terminal**, typically opened with:

```bash
Ctrl + Alt + T
```

Unlike the GUI (Graphical User Interface), the CLI lets you **control the system directly with commands**, which is faster, more powerful, and essential for servers.

---

## ⚙️ 2. Basic Command Structure

A typical Linux command looks like this:

```bash
command [options] [arguments]
```

Example:

```bash
ls -l /home
```

* `ls` → command (list files)
* `-l` → option (long format)
* `/home` → argument (target directory)

---

## 📂 3. File & Directory Commands

| Command | Description            | Example                     |
| ------- | ---------------------- | --------------------------- |
| `pwd`   | Show current directory | `pwd`                       |
| `ls`    | List files             | `ls -a` (show hidden)       |
| `cd`    | Change directory       | `cd /etc`                   |
| `mkdir` | Make directory         | `mkdir new_folder`          |
| `rmdir` | Remove empty directory | `rmdir old_folder`          |
| `rm`    | Remove file or folder  | `rm file.txt`, `rm -r dir/` |
| `cp`    | Copy files             | `cp a.txt b.txt`            |
| `mv`    | Move or rename         | `mv a.txt /tmp/`            |
| `cat`   | Show file content      | `cat file.txt`              |
| `less`  | View long files        | `less /var/log/syslog`      |

---

## 👥 4. User & Permission Commands

| Command   | Description          |
| --------- | -------------------- |
| `whoami`  | Show current user    |
| `sudo`    | Run command as admin |
| `chmod`   | Change permissions   |
| `chown`   | Change file owner    |
| `passwd`  | Change password      |
| `adduser` | Add a new user       |
| `deluser` | Delete a user        |

Example:

```bash
sudo apt update
```

---

## 🌐 5. Network Commands

| Command                | Description              |
| ---------------------- | ------------------------ |
| `ping`                 | Check network connection |
| `curl`                 | Send HTTP requests       |
| `wget`                 | Download files           |
| `ifconfig` / `ip addr` | Show network info        |
| `netstat` / `ss`       | Show active connections  |

Example:

```bash
ping google.com
```

---

## 🔍 6. System & Process Commands

| Command          | Description            |
| ---------------- | ---------------------- |
| `top` / `htop`   | Show running processes |
| `ps aux`         | List processes         |
| `kill`           | Stop process by PID    |
| `df -h`          | Show disk usage        |
| `du -sh folder/` | Show folder size       |
| `free -h`        | Show memory usage      |
| `uptime`         | System running time    |
| `uname -a`       | System info            |

---

## 📦 7. Package Management (APT)

APT is the Ubuntu package manager.

| Command                  | Description                |
| ------------------------ | -------------------------- |
| `sudo apt update`        | Update package info        |
| `sudo apt upgrade`       | Upgrade installed packages |
| `sudo apt install nginx` | Install package            |
| `sudo apt remove nginx`  | Remove package             |
| `apt search keyword`     | Search packages            |
| `dpkg -l`                | List installed packages    |

---

## 📑 8. File Viewing & Searching

| Command               | Description                             |
| --------------------- | --------------------------------------- |
| `cat`, `less`, `more` | Read files                              |
| `grep`                | Search text patterns                    |
| `find`                | Search files by name                    |
| `locate`              | Search files quickly (needs `updatedb`) |
| `history`             | Show previous commands                  |

Example:

```bash
grep "error" /var/log/syslog
```

---

## 🧰 9. Useful Shortcuts

| Shortcut   | Function               |
| ---------- | ---------------------- |
| `Ctrl + C` | Stop running command   |
| `Ctrl + L` | Clear screen           |
| `Tab`      | Auto-complete command  |
| `↑ / ↓`    | Command history        |
| `Ctrl + R` | Search command history |

---

## 🚀 10. Practice Exercise

Try these to get comfortable:

```bash
mkdir test
cd test
touch file1.txt file2.txt
ls -l
echo "Hello Ubuntu CLI" > file1.txt
cat file1.txt
cp file1.txt backup.txt
rm file2.txt
cd ..
rmdir test
```

---

Would you like me to make a **step-by-step beginner’s tutorial** (with exercises and small projects, like a “file manager in CLI”)?
That’s a great way to learn Ubuntu CLI practically.
