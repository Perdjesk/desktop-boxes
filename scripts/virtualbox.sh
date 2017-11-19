#!/bin/sh -eux

if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  exit 0
fi

sudo dnf -y install bzip2 dkms make kernel-devel-$(uname -r)

# https://www.packer.io/docs/builders/virtualbox-iso.html#guest_additions_path
# By default this is "VBoxGuestAdditions.iso" which should upload into the login directory of the user.
sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
sudo /mnt/VBoxLinuxAdditions.run || :
sudo umount /mnt/
rm -f ~/VBoxGuestAdditions.iso
