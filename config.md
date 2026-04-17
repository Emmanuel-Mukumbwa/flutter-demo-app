sudo apt update
sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev

# Flutter kiosk deployment (Openbox)

A concise guide to deploy a Flutter Linux build to an Ubuntu machine running an Openbox kiosk session.

This document shows the recommended steps to:

- Copy your Flutter project to the server
- Build the release binary for Linux
- Install and configure Openbox as a lightweight kiosk session
- Auto-login and auto-start the Flutter app in single-instance fullscreen mode

> Note: replace username, host and paths below with values for your environment (examples use `thiscity` and `/home/thiscity/my_new_app`).

---

## Table of contents

- Prerequisites
- 1) Copy project to server
- 2) Connect to server
- 3) Build the app (Linux release)
- 4) Install Openbox and required packages
- 5) Register Openbox session
- 6) Enable automatic login (gdm3)
- 7) Set Openbox as default for the user
- 8) Create app launcher script
- 9) Openbox autostart configuration
- 10) Cleanup duplicate starters
- Reboot and expected result
- Notes and optional hardening

---
    
## Prerequisites

- A Linux (Ubuntu) server with SSH access.
- The Flutter SDK installed on your local machine to build Linux targets, or build on the server if you prefer.
- gdm3 (or equivalent display manager) used for automatic login examples below.
- Replace `server-name` and IP address `192.168.` with your username and server IP.

## 1) Copy project to server (from Windows PowerShell)

Run this from your local Windows machine:

```powershell
scp -r C:\Users\aRelic\Downloads\flutterprojects\my_new_app thiscity@192.168.:/home/thiscity/
```

## 2) Connect to the server

```bash
ssh server-name@192.168.
```

## 3) Build the app (Linux release)

On the server (or locally before copying), prepare and build:

```bash
cd /home/thiscity/my_new_app
flutter clean
flutter pub get
flutter build linux --release
```

The release binary will be in `build/linux/x64/release/bundle/`.

## 4) Install Openbox and required packages

```bash
sudo apt update
sudo apt install -y openbox xinit x11-xserver-utils
```

## 5) Register Openbox as a session

Create a desktop session file so it appears in session lists:

```bash
sudo tee /usr/share/xsessions/openbox.desktop > /dev/null <<'EOF'
[Desktop Entry]
Name=Openbox
Exec=openbox-session
Type=Application
EOF
```

## 6) Enable automatic login (example for gdm3)

Edit or write the gdm3 custom config (replace `thiscity`):

```bash
sudo tee /etc/gdm3/custom.conf > /dev/null <<'EOF'
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=thiscity
EOF
```

If you use a different display manager (lightdm, sddm, etc.), adapt the auto-login configuration accordingly.

## 7) Set Openbox as the default session for the user

Tell AccountsService which session to use for the user (replace `thiscity`):

```bash
sudo tee /var/lib/AccountsService/users/thiscity > /dev/null <<'EOF'
[User]
XSession=openbox
SystemAccount=false
EOF
```

## 8) Create a small launcher script for the app

Create `~/.local/bin/pos-app` to run the bundled executable. Update the path to match your build output.

```bash
mkdir -p ~/.local/bin
tee ~/.local/bin/pos-app > /dev/null <<'EOF'
#!/bin/sh
exec /home/thiscity/my_new_app/build/linux/x64/release/bundle/my_new_app
EOF
chmod +x ~/.local/bin/pos-app
```

## 9) Openbox autostart (fullscreen-friendly)

Create Openbox autostart entries to disable screensavers and start the app:

```bash
mkdir -p ~/.config/openbox
tee ~/.config/openbox/autostart > /dev/null <<'EOF'
xset s off
xset s noblank
xset -dpms

~/.local/bin/pos-app
EOF
```

## 10) Cleanup duplicate starters and (optional) systemd service removal

Remove unexpected autostart entries and any previously installed systemd service that may start the app twice:

```bash
rm -f ~/.config/autostart/*
sudo systemctl disable --now flutter-app.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/flutter-app.service || true
sudo systemctl daemon-reload
```

## Reboot

```bash
sudo reboot
```

## Expected result after reboot

- Automatic login for the specified user
- Openbox session runs instead of a full desktop environment
- Flutter app starts automatically in fullscreen
- Single instance behavior (no duplicate launchers)

## Notes

- Paths and usernames in this guide are examples. Update them for your environment.
- If you build locally, copy only the `build/linux/.../bundle` directory and the files it needs to the server.
- For other display managers, consult their documentation for auto-login configuration.

## Optional hardening (short list of ideas)

- Lock or disable virtual terminals (Ctrl+Alt+F1–F6) to prevent TTY access
- Restrict common window manager shortcuts (Alt+Tab, Alt+F4)
- Limit USB/device access via udev rules
- Use systemd watchdogs and restart policies to auto-recover the app

---

If you'd like, I can also provide a ready-to-use systemd service file, a script to package and copy only the built bundle, or a minimal post-install checklist to increase reliability.