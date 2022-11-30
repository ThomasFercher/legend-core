// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaffold_config.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class ScaffoldConfigInfoNull {}

abstract class ScaffoldConfigInfo implements ScaffoldConfigInfoNull {}

class ScaffoldConfigComponentsInfo {
  final ScaffoldBuildersInfoNull? builders;
  final ScaffoldWhetherInfoNull? whether;
  ScaffoldConfigComponentsInfo({
    this.builders,
    this.whether,
  });
}

class ScaffoldConfigComponentsOverride implements ScaffoldConfigComponentsInfo {
  @override
  final ScaffoldBuildersOverride? builders;
  @override
  final ScaffoldWhetherOverride? whether;
  ScaffoldConfigComponentsOverride({
    this.builders,
    this.whether,
  });
}

class ScaffoldConfigComponents implements ScaffoldConfigComponentsInfo {
  @override
  final ScaffoldBuilders builders;
  @override
  final ScaffoldWhether whether;
  ScaffoldConfigComponents({
    required this.builders,
    required this.whether,
  });
}

class ScaffoldConfigOverride extends ScaffoldConfigInfoNull
    implements ScaffoldConfigComponentsOverride {
  @override
  final ScaffoldBuildersOverride? builders;
  @override
  final ScaffoldWhetherOverride? whether;
  ScaffoldConfigOverride({
    this.builders,
    this.whether,
  });
}

class ScaffoldConfig extends ScaffoldConfigInfo
    implements ScaffoldConfigComponents {
  @override
  final ScaffoldBuilders builders;
  @override
  final ScaffoldWhether whether;
  ScaffoldConfig({
    required this.builders,
    required this.whether,
  });
  ScaffoldConfig.copy({
    required this.builders,
    required this.whether,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory ScaffoldConfig.override(
    ScaffoldConfig def,
    ScaffoldConfigOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return ScaffoldConfig(
      builders: ScaffoldBuilders.override(
        def.builders,
        override.builders,
      ),
      whether: ScaffoldWhether.override(
        def.whether,
        override.whether,
      ),
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  ScaffoldConfig copyWith({
    ScaffoldBuilders? builders,
    ScaffoldWhether? whether,
  }) {
    return ScaffoldConfig.copy(
      builders: builders ?? this.builders,
      whether: whether ?? this.whether,
    );
  }
}
