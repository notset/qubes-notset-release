SHELL = /bin/bash

ifneq (,$(wildcard /etc/fedora-release))
DIST ?= fc$(shell rpm --eval %{fedora})
else ifneq (,$(wildcard /etc/fedora-release))
DIST ?= centos$(shell rpm --eval %{centos})
else
DIST ?= fc30
endif

all:
	@true

install-dom0:
	# repos
	install -Dm 0644 repos/notset-qubes-dom0.repo $(DESTDIR)/etc/yum.repos.d/notset-qubes-dom0.repo
	DIST='$(DIST)'; sed -i "s/@DIST@/$$DIST/g" $(DESTDIR)/etc/yum.repos.d/notset-qubes-dom0.repo

	#GPG key
	install -Dpm 644 RPM-GPG-KEY-notset $(DESTDIR)/etc/pki/rpm-gpg/RPM-GPG-KEY-notset

install-vm-rh:
	# repos
	install -Dm 0644 repos/notset-qubes-vm.repo $(DESTDIR)/etc/yum.repos.d/notset-qubes.repo
	DIST='$(DIST)'; sed -i "s/@DIST@/$$DIST/g" $(DESTDIR)/etc/yum.repos.d/notset-qubes.repo

	#GPG key
	install -Dpm 644 RPM-GPG-KEY-notset $(DESTDIR)/etc/pki/rpm-gpg/RPM-GPG-KEY-notset

install-vm-deb:
	mkdir -p $(DESTDIR)/etc/apt/sources.list.d
	sed -e "s/@DIST@/`lsb_release -cs`/" repos/notset-qubes-vm.list.in > $(DESTDIR)/etc/apt/sources.list.d/notset-qubes.list
	gpg --dearmor --output $(DESTDIR)/etc/apt/trusted.gpg.d/notset-archive-keyring.gpg RPM-GPG-KEY-notset
