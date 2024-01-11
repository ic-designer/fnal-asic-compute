# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```markdown
## [Unreleased] - YYYY-MM-DD
### Added
### Changed
### Deprecated
### Fixed
### Security
```

## [0.3.1] - 2023-01-10
### Added
- Added an installation successful message to the `install` target.
- The Makefile variable `WORKDIR_ROOT` can now be overidden on the command line.
### Changed
- Build dependencies are now populated under `$(WORKDIR_ROOT)/deps/`.
- Build artifacts are now populated under `$(WORKDIR_ROOT)/build/`.
- Test artifacts are now populated under`$(WORKDIR_ROOT)/test/`.
### Fixed
- Running target `check` and `test`, now try to test the dependencies as well


## [0.3.0] - 2024-01-09
### Added
- Initial documentation for this repo added to README.md.
### Changed
- MacOS prompt now provides either a tag or a hash when the repo has a detached head.
- Removed the version string from the install directories to simplify uninstall
### Fixed
- Corrected issus where kerberos username must match the local username.


## [0.2.1] - 2024-01-08
### Changed
- Updated the Makefiles to the use standard installation directory variables.
- Updated the Makefiles to the use the shared Boxbird utilities.
- Removed shared-recipes.mk from the repo.
- Removed the `pkg_override` and `pkg_list` targets.
### Fixed
- Corrected issue with GitHub workflow where make target were not properly ran by calling each
  make target as a seperate command.


## [0.2.0] - 2024-01-06
### Added
- Created special files CHANGELOG.md, LICENSE, README.md, and TODO.md
- Automated testing for both Linux and MacOS using GitHub workflows.
### Changed
- Installation and testing managed through Makefiles instead of custom bash scripts.
- Repository has been moved to the `ic-designer` organization to keep with dependencies.
- MacOS scripts for `vnctools` now provided by the `bash-vnctools` repo


## [0.1.0] - 2023-12-30
### Added
- Initial configuration for MacOS
- Initial configuration for Scientific Linux
- Update script for installing the compute configurations
