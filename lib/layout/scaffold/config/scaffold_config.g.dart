// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaffold_config.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class ScaffoldConfigInfoNull {
  final DynamicRouteLayout? layout;
  const ScaffoldConfigInfoNull({
    required this.layout,
  });
}

abstract class ScaffoldConfigInfo implements ScaffoldConfigInfoNull {
  @override
  final DynamicRouteLayout layout;
  const ScaffoldConfigInfo({
    required this.layout,
  });
}

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
    super.layout,
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
    required super.layout,
    required this.builders,
    required this.whether,
  });
  ScaffoldConfig.copy({
    required super.layout,
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
      layout: override.layout ?? def.layout,
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
    DynamicRouteLayout? layout,
    ScaffoldBuilders? builders,
    ScaffoldWhether? whether,
  }) {
    return ScaffoldConfig.copy(
      layout: layout ?? this.layout,
      builders: builders ?? this.builders,
      whether: whether ?? this.whether,
    );
  }
}
