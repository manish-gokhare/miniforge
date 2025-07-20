#!/bin/bash

# Define users and their passwords
declare -A USERS
USERS=(
  [danny]="Password123"
  [koen]="Password123"
  [david]="Password123"
)

# Optional: Create a shared group for JupyterHub users
GROUP="jupyterusers"
if ! getent group "$GROUP" > /dev/null; then
  echo "Creating group: $GROUP"
  groupadd "$GROUP"
fi

# Create users and set passwords
for USER in "${!USERS[@]}"; do
  PASSWORD="${USERS[$USER]}"
  
  if id "$USER" &>/dev/null; then
    echo "User '$USER' already exists. Skipping..."
  else
    echo "Creating user '$USER'"
    useradd -m -s /bin/bash -g "$GROUP" "$USER"
    echo "$USER:$PASSWORD" | chpasswd
    echo "User '$USER' created and password set."
  fi
done

echo "All requested users created (or already present)."
