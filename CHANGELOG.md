# Changelog

All notable changes to this project will be documented in this file.

## [3.1.1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v3.1.0...v3.1.1) (2025-10-21)

### Bug Fixes

* Update CI workflow versions to latest ([#21](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/21)) ([58edfc5](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/58edfc5c7979d8bd38e88ddb414887218f3b2ac6))

## [3.1.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v3.0.0...v3.1.0) (2025-09-09)


### Features

* Add the capability to disable alert manager creation ([#20](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/20)) ([c838818](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/c838818ef91fd171fa1cd1e3cb773fb214b513f3))


### Bug Fixes

* Update CI workflow versions to latest ([#18](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/18)) ([69d8d68](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/69d8d68355d590f3ac19812f07cb3515339f9642))

## [3.0.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.2.3...v3.0.0) (2024-05-20)


### ⚠ BREAKING CHANGES

* Add support for `kms_key_arn`; bump MSV of Terraform and AWS provider to `1.3` and `5.32` respectively to support (#16)

### Features

* Add support for `kms_key_arn`; bump MSV of Terraform and AWS provider to `1.3` and `5.32` respectively to support ([#16](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/16)) ([fc33f68](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/fc33f68c596ac50f431172a91feed7ab17f65b11))

## [2.2.3](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.2.2...v2.2.3) (2024-03-06)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#13](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/13)) ([7049872](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/7049872c58881b578c357a428b8821049a9684e6))

### [2.2.2](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.2.1...v2.2.2) (2022-11-07)


### Bug Fixes

* Update CI configuration files to use latest version ([#11](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/11)) ([1f39d99](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/1f39d99ba23e065456956946e3e1b5d5b1caf2d7))

### [2.2.1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.2.0...v2.2.1) (2022-10-20)


### Bug Fixes

* Fix dependencies and implementation of the logging configuration support feature ([#9](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/9)) ([53fed8d](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/53fed8d0b3dc0a843485138ca5013cfef4454d34))

## [2.2.0](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.1.3...v2.2.0) (2022-07-28)


### Features

* Add support for using an existing/external workspace ([#6](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/6)) ([f26527a](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/f26527ac36569120b8f76dedd0dea645c8318a66))

### [2.1.3](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.1.2...v2.1.3) (2022-07-01)


### Bug Fixes

* Correct alert manager default definition ([#4](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/4)) ([2bfb4ab](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/2bfb4abd24b1bda3a602d36ac7c874e49fbc7624))

### [2.1.2](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.1.1...v2.1.2) (2022-04-26)


### Bug Fixes

* Add default value for `alert_manager_definition` ([#3](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/3)) ([a66025f](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/a66025fbde409a012f2622a48ac4d78755c0c9ff))

### [2.1.1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/compare/v2.1.0...v2.1.1) (2022-04-21)


### Bug Fixes

* Update documentation to remove prior notice and deprecated workflow ([#1](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/1)) ([4a29aa2](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/4a29aa21339851bcd5f7ec168532625ef5a99a6a))
* Update documentation to remove prior notice and deprecated workflow ([#2](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/issues/2)) ([7e69d6e](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/commit/7e69d6e3a369a7be23e62e78ab0b4673975715ef))

## [2.1.0](https://github.com/clowdhaus/terraform-aws-managed-service-prometheus/compare/v2.0.0...v2.1.0) (2022-04-20)


### Features

* Repo has moved to [terraform-aws-modules](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus) organization ([01d445b](https://github.com/clowdhaus/terraform-aws-managed-service-prometheus/commit/01d445b6c6ccbe97ee17b29c00fb14590bc05cd8))


### Bug Fixes

* Correct release script one last time ([27e19fa](https://github.com/clowdhaus/terraform-aws-managed-service-prometheus/commit/27e19faae60498c8e756d605dfb862a9a43755af))
