ifeq ($(PACKAGE_SET),dom0)
RPM_SPEC_FILES := rpm_spec/notset-release-dom0.spec
else
RPM_SPEC_FILES := rpm_spec/notset-release-vm.spec
DEBIAN_BUILD_DIRS := debian
endif
