// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EVCarModelsTable extends EVCarModels
    with TableInfo<$EVCarModelsTable, EVCarModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EVCarModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _modelNameMeta = const VerificationMeta(
    'modelName',
  );
  @override
  late final GeneratedColumn<String> modelName = GeneratedColumn<String>(
    'model_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelYearMeta = const VerificationMeta(
    'modelYear',
  );
  @override
  late final GeneratedColumn<int> modelYear = GeneratedColumn<int>(
    'model_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batteryCapacityMeta = const VerificationMeta(
    'batteryCapacity',
  );
  @override
  late final GeneratedColumn<double> batteryCapacity = GeneratedColumn<double>(
    'battery_capacity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxChargingPowerMeta = const VerificationMeta(
    'maxChargingPower',
  );
  @override
  late final GeneratedColumn<double> maxChargingPower = GeneratedColumn<double>(
    'max_charging_power',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    modelName,
    modelYear,
    batteryCapacity,
    maxChargingPower,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'e_v_car_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<EVCarModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('model_name')) {
      context.handle(
        _modelNameMeta,
        modelName.isAcceptableOrUnknown(data['model_name']!, _modelNameMeta),
      );
    } else if (isInserting) {
      context.missing(_modelNameMeta);
    }
    if (data.containsKey('model_year')) {
      context.handle(
        _modelYearMeta,
        modelYear.isAcceptableOrUnknown(data['model_year']!, _modelYearMeta),
      );
    } else if (isInserting) {
      context.missing(_modelYearMeta);
    }
    if (data.containsKey('battery_capacity')) {
      context.handle(
        _batteryCapacityMeta,
        batteryCapacity.isAcceptableOrUnknown(
          data['battery_capacity']!,
          _batteryCapacityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batteryCapacityMeta);
    }
    if (data.containsKey('max_charging_power')) {
      context.handle(
        _maxChargingPowerMeta,
        maxChargingPower.isAcceptableOrUnknown(
          data['max_charging_power']!,
          _maxChargingPowerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxChargingPowerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EVCarModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EVCarModel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      modelName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}model_name'],
          )!,
      modelYear:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}model_year'],
          )!,
      batteryCapacity:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}battery_capacity'],
          )!,
      maxChargingPower:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}max_charging_power'],
          )!,
    );
  }

  @override
  $EVCarModelsTable createAlias(String alias) {
    return $EVCarModelsTable(attachedDatabase, alias);
  }
}

class EVCarModel extends DataClass implements Insertable<EVCarModel> {
  final int id;
  final String modelName;
  final int modelYear;
  final double batteryCapacity;
  final double maxChargingPower;
  const EVCarModel({
    required this.id,
    required this.modelName,
    required this.modelYear,
    required this.batteryCapacity,
    required this.maxChargingPower,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['model_name'] = Variable<String>(modelName);
    map['model_year'] = Variable<int>(modelYear);
    map['battery_capacity'] = Variable<double>(batteryCapacity);
    map['max_charging_power'] = Variable<double>(maxChargingPower);
    return map;
  }

  EVCarModelsCompanion toCompanion(bool nullToAbsent) {
    return EVCarModelsCompanion(
      id: Value(id),
      modelName: Value(modelName),
      modelYear: Value(modelYear),
      batteryCapacity: Value(batteryCapacity),
      maxChargingPower: Value(maxChargingPower),
    );
  }

  factory EVCarModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EVCarModel(
      id: serializer.fromJson<int>(json['id']),
      modelName: serializer.fromJson<String>(json['modelName']),
      modelYear: serializer.fromJson<int>(json['modelYear']),
      batteryCapacity: serializer.fromJson<double>(json['batteryCapacity']),
      maxChargingPower: serializer.fromJson<double>(json['maxChargingPower']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'modelName': serializer.toJson<String>(modelName),
      'modelYear': serializer.toJson<int>(modelYear),
      'batteryCapacity': serializer.toJson<double>(batteryCapacity),
      'maxChargingPower': serializer.toJson<double>(maxChargingPower),
    };
  }

  EVCarModel copyWith({
    int? id,
    String? modelName,
    int? modelYear,
    double? batteryCapacity,
    double? maxChargingPower,
  }) => EVCarModel(
    id: id ?? this.id,
    modelName: modelName ?? this.modelName,
    modelYear: modelYear ?? this.modelYear,
    batteryCapacity: batteryCapacity ?? this.batteryCapacity,
    maxChargingPower: maxChargingPower ?? this.maxChargingPower,
  );
  EVCarModel copyWithCompanion(EVCarModelsCompanion data) {
    return EVCarModel(
      id: data.id.present ? data.id.value : this.id,
      modelName: data.modelName.present ? data.modelName.value : this.modelName,
      modelYear: data.modelYear.present ? data.modelYear.value : this.modelYear,
      batteryCapacity:
          data.batteryCapacity.present
              ? data.batteryCapacity.value
              : this.batteryCapacity,
      maxChargingPower:
          data.maxChargingPower.present
              ? data.maxChargingPower.value
              : this.maxChargingPower,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EVCarModel(')
          ..write('id: $id, ')
          ..write('modelName: $modelName, ')
          ..write('modelYear: $modelYear, ')
          ..write('batteryCapacity: $batteryCapacity, ')
          ..write('maxChargingPower: $maxChargingPower')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, modelName, modelYear, batteryCapacity, maxChargingPower);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EVCarModel &&
          other.id == this.id &&
          other.modelName == this.modelName &&
          other.modelYear == this.modelYear &&
          other.batteryCapacity == this.batteryCapacity &&
          other.maxChargingPower == this.maxChargingPower);
}

class EVCarModelsCompanion extends UpdateCompanion<EVCarModel> {
  final Value<int> id;
  final Value<String> modelName;
  final Value<int> modelYear;
  final Value<double> batteryCapacity;
  final Value<double> maxChargingPower;
  const EVCarModelsCompanion({
    this.id = const Value.absent(),
    this.modelName = const Value.absent(),
    this.modelYear = const Value.absent(),
    this.batteryCapacity = const Value.absent(),
    this.maxChargingPower = const Value.absent(),
  });
  EVCarModelsCompanion.insert({
    this.id = const Value.absent(),
    required String modelName,
    required int modelYear,
    required double batteryCapacity,
    required double maxChargingPower,
  }) : modelName = Value(modelName),
       modelYear = Value(modelYear),
       batteryCapacity = Value(batteryCapacity),
       maxChargingPower = Value(maxChargingPower);
  static Insertable<EVCarModel> custom({
    Expression<int>? id,
    Expression<String>? modelName,
    Expression<int>? modelYear,
    Expression<double>? batteryCapacity,
    Expression<double>? maxChargingPower,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (modelName != null) 'model_name': modelName,
      if (modelYear != null) 'model_year': modelYear,
      if (batteryCapacity != null) 'battery_capacity': batteryCapacity,
      if (maxChargingPower != null) 'max_charging_power': maxChargingPower,
    });
  }

  EVCarModelsCompanion copyWith({
    Value<int>? id,
    Value<String>? modelName,
    Value<int>? modelYear,
    Value<double>? batteryCapacity,
    Value<double>? maxChargingPower,
  }) {
    return EVCarModelsCompanion(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
      modelYear: modelYear ?? this.modelYear,
      batteryCapacity: batteryCapacity ?? this.batteryCapacity,
      maxChargingPower: maxChargingPower ?? this.maxChargingPower,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (modelName.present) {
      map['model_name'] = Variable<String>(modelName.value);
    }
    if (modelYear.present) {
      map['model_year'] = Variable<int>(modelYear.value);
    }
    if (batteryCapacity.present) {
      map['battery_capacity'] = Variable<double>(batteryCapacity.value);
    }
    if (maxChargingPower.present) {
      map['max_charging_power'] = Variable<double>(maxChargingPower.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EVCarModelsCompanion(')
          ..write('id: $id, ')
          ..write('modelName: $modelName, ')
          ..write('modelYear: $modelYear, ')
          ..write('batteryCapacity: $batteryCapacity, ')
          ..write('maxChargingPower: $maxChargingPower')
          ..write(')'))
        .toString();
  }
}

class $UserEVsTable extends UserEVs with TableInfo<$UserEVsTable, UserEV> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserEVsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carModelIdMeta = const VerificationMeta(
    'carModelId',
  );
  @override
  late final GeneratedColumn<int> carModelId = GeneratedColumn<int>(
    'car_model_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES e_v_car_models (id)',
    ),
  );
  static const VerificationMeta _userSetNameMeta = const VerificationMeta(
    'userSetName',
  );
  @override
  late final GeneratedColumn<String> userSetName = GeneratedColumn<String>(
    'user_set_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentChargeMeta = const VerificationMeta(
    'currentCharge',
  );
  @override
  late final GeneratedColumn<double> currentCharge = GeneratedColumn<double>(
    'current_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carModelId,
    userSetName,
    currentCharge,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_e_vs';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserEV> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_model_id')) {
      context.handle(
        _carModelIdMeta,
        carModelId.isAcceptableOrUnknown(
          data['car_model_id']!,
          _carModelIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carModelIdMeta);
    }
    if (data.containsKey('user_set_name')) {
      context.handle(
        _userSetNameMeta,
        userSetName.isAcceptableOrUnknown(
          data['user_set_name']!,
          _userSetNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userSetNameMeta);
    }
    if (data.containsKey('current_charge')) {
      context.handle(
        _currentChargeMeta,
        currentCharge.isAcceptableOrUnknown(
          data['current_charge']!,
          _currentChargeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentChargeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserEV map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserEV(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      carModelId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}car_model_id'],
          )!,
      userSetName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_set_name'],
          )!,
      currentCharge:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}current_charge'],
          )!,
    );
  }

  @override
  $UserEVsTable createAlias(String alias) {
    return $UserEVsTable(attachedDatabase, alias);
  }
}

class UserEV extends DataClass implements Insertable<UserEV> {
  final int id;
  final int carModelId;
  final String userSetName;
  final double currentCharge;
  const UserEV({
    required this.id,
    required this.carModelId,
    required this.userSetName,
    required this.currentCharge,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_model_id'] = Variable<int>(carModelId);
    map['user_set_name'] = Variable<String>(userSetName);
    map['current_charge'] = Variable<double>(currentCharge);
    return map;
  }

  UserEVsCompanion toCompanion(bool nullToAbsent) {
    return UserEVsCompanion(
      id: Value(id),
      carModelId: Value(carModelId),
      userSetName: Value(userSetName),
      currentCharge: Value(currentCharge),
    );
  }

  factory UserEV.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserEV(
      id: serializer.fromJson<int>(json['id']),
      carModelId: serializer.fromJson<int>(json['carModelId']),
      userSetName: serializer.fromJson<String>(json['userSetName']),
      currentCharge: serializer.fromJson<double>(json['currentCharge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carModelId': serializer.toJson<int>(carModelId),
      'userSetName': serializer.toJson<String>(userSetName),
      'currentCharge': serializer.toJson<double>(currentCharge),
    };
  }

  UserEV copyWith({
    int? id,
    int? carModelId,
    String? userSetName,
    double? currentCharge,
  }) => UserEV(
    id: id ?? this.id,
    carModelId: carModelId ?? this.carModelId,
    userSetName: userSetName ?? this.userSetName,
    currentCharge: currentCharge ?? this.currentCharge,
  );
  UserEV copyWithCompanion(UserEVsCompanion data) {
    return UserEV(
      id: data.id.present ? data.id.value : this.id,
      carModelId:
          data.carModelId.present ? data.carModelId.value : this.carModelId,
      userSetName:
          data.userSetName.present ? data.userSetName.value : this.userSetName,
      currentCharge:
          data.currentCharge.present
              ? data.currentCharge.value
              : this.currentCharge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserEV(')
          ..write('id: $id, ')
          ..write('carModelId: $carModelId, ')
          ..write('userSetName: $userSetName, ')
          ..write('currentCharge: $currentCharge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, carModelId, userSetName, currentCharge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEV &&
          other.id == this.id &&
          other.carModelId == this.carModelId &&
          other.userSetName == this.userSetName &&
          other.currentCharge == this.currentCharge);
}

class UserEVsCompanion extends UpdateCompanion<UserEV> {
  final Value<int> id;
  final Value<int> carModelId;
  final Value<String> userSetName;
  final Value<double> currentCharge;
  const UserEVsCompanion({
    this.id = const Value.absent(),
    this.carModelId = const Value.absent(),
    this.userSetName = const Value.absent(),
    this.currentCharge = const Value.absent(),
  });
  UserEVsCompanion.insert({
    this.id = const Value.absent(),
    required int carModelId,
    required String userSetName,
    required double currentCharge,
  }) : carModelId = Value(carModelId),
       userSetName = Value(userSetName),
       currentCharge = Value(currentCharge);
  static Insertable<UserEV> custom({
    Expression<int>? id,
    Expression<int>? carModelId,
    Expression<String>? userSetName,
    Expression<double>? currentCharge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carModelId != null) 'car_model_id': carModelId,
      if (userSetName != null) 'user_set_name': userSetName,
      if (currentCharge != null) 'current_charge': currentCharge,
    });
  }

  UserEVsCompanion copyWith({
    Value<int>? id,
    Value<int>? carModelId,
    Value<String>? userSetName,
    Value<double>? currentCharge,
  }) {
    return UserEVsCompanion(
      id: id ?? this.id,
      carModelId: carModelId ?? this.carModelId,
      userSetName: userSetName ?? this.userSetName,
      currentCharge: currentCharge ?? this.currentCharge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carModelId.present) {
      map['car_model_id'] = Variable<int>(carModelId.value);
    }
    if (userSetName.present) {
      map['user_set_name'] = Variable<String>(userSetName.value);
    }
    if (currentCharge.present) {
      map['current_charge'] = Variable<double>(currentCharge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserEVsCompanion(')
          ..write('id: $id, ')
          ..write('carModelId: $carModelId, ')
          ..write('userSetName: $userSetName, ')
          ..write('currentCharge: $currentCharge')
          ..write(')'))
        .toString();
  }
}

class $ConstraintsTable extends Constraints
    with TableInfo<$ConstraintsTable, Constraint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConstraintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userCarModelIdMeta = const VerificationMeta(
    'userCarModelId',
  );
  @override
  late final GeneratedColumn<int> userCarModelId = GeneratedColumn<int>(
    'user_car_model_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_e_vs (id)',
    ),
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    check: () => ComparableExpr(dayOfWeek).isBetweenValues(0, 6),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinutesMeta = const VerificationMeta(
    'startMinutes',
  );
  @override
  late final GeneratedColumn<int> startMinutes = GeneratedColumn<int>(
    'start_minutes',
    aliasedName,
    false,
    check: () => ComparableExpr(startMinutes).isBetweenValues(0, 1440),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinutesMeta = const VerificationMeta(
    'endMinutes',
  );
  @override
  late final GeneratedColumn<int> endMinutes = GeneratedColumn<int>(
    'end_minutes',
    aliasedName,
    false,
    check: () => ComparableExpr(endMinutes).isBetweenValues(0, 1440),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userCarModelId,
    dayOfWeek,
    startMinutes,
    endMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'constraints';
  @override
  VerificationContext validateIntegrity(
    Insertable<Constraint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_car_model_id')) {
      context.handle(
        _userCarModelIdMeta,
        userCarModelId.isAcceptableOrUnknown(
          data['user_car_model_id']!,
          _userCarModelIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userCarModelIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('start_minutes')) {
      context.handle(
        _startMinutesMeta,
        startMinutes.isAcceptableOrUnknown(
          data['start_minutes']!,
          _startMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinutesMeta);
    }
    if (data.containsKey('end_minutes')) {
      context.handle(
        _endMinutesMeta,
        endMinutes.isAcceptableOrUnknown(data['end_minutes']!, _endMinutesMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Constraint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Constraint(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userCarModelId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_car_model_id'],
          )!,
      dayOfWeek:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}day_of_week'],
          )!,
      startMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}start_minutes'],
          )!,
      endMinutes:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}end_minutes'],
          )!,
    );
  }

  @override
  $ConstraintsTable createAlias(String alias) {
    return $ConstraintsTable(attachedDatabase, alias);
  }
}

class Constraint extends DataClass implements Insertable<Constraint> {
  final int id;
  final int userCarModelId;
  final int dayOfWeek;
  final int startMinutes;
  final int endMinutes;
  const Constraint({
    required this.id,
    required this.userCarModelId,
    required this.dayOfWeek,
    required this.startMinutes,
    required this.endMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_car_model_id'] = Variable<int>(userCarModelId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['start_minutes'] = Variable<int>(startMinutes);
    map['end_minutes'] = Variable<int>(endMinutes);
    return map;
  }

  ConstraintsCompanion toCompanion(bool nullToAbsent) {
    return ConstraintsCompanion(
      id: Value(id),
      userCarModelId: Value(userCarModelId),
      dayOfWeek: Value(dayOfWeek),
      startMinutes: Value(startMinutes),
      endMinutes: Value(endMinutes),
    );
  }

  factory Constraint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Constraint(
      id: serializer.fromJson<int>(json['id']),
      userCarModelId: serializer.fromJson<int>(json['userCarModelId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      startMinutes: serializer.fromJson<int>(json['startMinutes']),
      endMinutes: serializer.fromJson<int>(json['endMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userCarModelId': serializer.toJson<int>(userCarModelId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'startMinutes': serializer.toJson<int>(startMinutes),
      'endMinutes': serializer.toJson<int>(endMinutes),
    };
  }

  Constraint copyWith({
    int? id,
    int? userCarModelId,
    int? dayOfWeek,
    int? startMinutes,
    int? endMinutes,
  }) => Constraint(
    id: id ?? this.id,
    userCarModelId: userCarModelId ?? this.userCarModelId,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
  );
  Constraint copyWithCompanion(ConstraintsCompanion data) {
    return Constraint(
      id: data.id.present ? data.id.value : this.id,
      userCarModelId:
          data.userCarModelId.present
              ? data.userCarModelId.value
              : this.userCarModelId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      startMinutes:
          data.startMinutes.present
              ? data.startMinutes.value
              : this.startMinutes,
      endMinutes:
          data.endMinutes.present ? data.endMinutes.value : this.endMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Constraint(')
          ..write('id: $id, ')
          ..write('userCarModelId: $userCarModelId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userCarModelId, dayOfWeek, startMinutes, endMinutes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Constraint &&
          other.id == this.id &&
          other.userCarModelId == this.userCarModelId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.startMinutes == this.startMinutes &&
          other.endMinutes == this.endMinutes);
}

class ConstraintsCompanion extends UpdateCompanion<Constraint> {
  final Value<int> id;
  final Value<int> userCarModelId;
  final Value<int> dayOfWeek;
  final Value<int> startMinutes;
  final Value<int> endMinutes;
  const ConstraintsCompanion({
    this.id = const Value.absent(),
    this.userCarModelId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
  });
  ConstraintsCompanion.insert({
    this.id = const Value.absent(),
    required int userCarModelId,
    required int dayOfWeek,
    required int startMinutes,
    required int endMinutes,
  }) : userCarModelId = Value(userCarModelId),
       dayOfWeek = Value(dayOfWeek),
       startMinutes = Value(startMinutes),
       endMinutes = Value(endMinutes);
  static Insertable<Constraint> custom({
    Expression<int>? id,
    Expression<int>? userCarModelId,
    Expression<int>? dayOfWeek,
    Expression<int>? startMinutes,
    Expression<int>? endMinutes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userCarModelId != null) 'user_car_model_id': userCarModelId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (startMinutes != null) 'start_minutes': startMinutes,
      if (endMinutes != null) 'end_minutes': endMinutes,
    });
  }

  ConstraintsCompanion copyWith({
    Value<int>? id,
    Value<int>? userCarModelId,
    Value<int>? dayOfWeek,
    Value<int>? startMinutes,
    Value<int>? endMinutes,
  }) {
    return ConstraintsCompanion(
      id: id ?? this.id,
      userCarModelId: userCarModelId ?? this.userCarModelId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userCarModelId.present) {
      map['user_car_model_id'] = Variable<int>(userCarModelId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (startMinutes.present) {
      map['start_minutes'] = Variable<int>(startMinutes.value);
    }
    if (endMinutes.present) {
      map['end_minutes'] = Variable<int>(endMinutes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConstraintsCompanion(')
          ..write('id: $id, ')
          ..write('userCarModelId: $userCarModelId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes')
          ..write(')'))
        .toString();
  }
}

class $ScheduleTable extends Schedule
    with TableInfo<$ScheduleTable, ScheduleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userEvIdMeta = const VerificationMeta(
    'userEvId',
  );
  @override
  late final GeneratedColumn<int> userEvId = GeneratedColumn<int>(
    'user_ev_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_e_vs (id)',
    ),
  );
  static const VerificationMeta _chargeKwhMeta = const VerificationMeta(
    'chargeKwh',
  );
  @override
  late final GeneratedColumn<double> chargeKwh = GeneratedColumn<double>(
    'charge_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chargeHourMeta = const VerificationMeta(
    'chargeHour',
  );
  @override
  late final GeneratedColumn<int> chargeHour = GeneratedColumn<int>(
    'charge_hour',
    aliasedName,
    false,
    check: () => ComparableExpr(chargeHour).isBetweenValues(0, 24),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userEvId,
    chargeKwh,
    chargeHour,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_ev_id')) {
      context.handle(
        _userEvIdMeta,
        userEvId.isAcceptableOrUnknown(data['user_ev_id']!, _userEvIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userEvIdMeta);
    }
    if (data.containsKey('charge_kwh')) {
      context.handle(
        _chargeKwhMeta,
        chargeKwh.isAcceptableOrUnknown(data['charge_kwh']!, _chargeKwhMeta),
      );
    } else if (isInserting) {
      context.missing(_chargeKwhMeta);
    }
    if (data.containsKey('charge_hour')) {
      context.handle(
        _chargeHourMeta,
        chargeHour.isAcceptableOrUnknown(data['charge_hour']!, _chargeHourMeta),
      );
    } else if (isInserting) {
      context.missing(_chargeHourMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userEvId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_ev_id'],
          )!,
      chargeKwh:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}charge_kwh'],
          )!,
      chargeHour:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}charge_hour'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $ScheduleTable createAlias(String alias) {
    return $ScheduleTable(attachedDatabase, alias);
  }
}

class ScheduleData extends DataClass implements Insertable<ScheduleData> {
  final int id;
  final int userEvId;

  /// Amount of energy needed (in kWh) for this hour
  final double chargeKwh;

  /// The hour offset from [createdAt], e.g. 0 = current hour, 1 = +1h
  final int chargeHour;

  /// When this schedule was generated (e.g., by API call)
  final DateTime createdAt;
  const ScheduleData({
    required this.id,
    required this.userEvId,
    required this.chargeKwh,
    required this.chargeHour,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_ev_id'] = Variable<int>(userEvId);
    map['charge_kwh'] = Variable<double>(chargeKwh);
    map['charge_hour'] = Variable<int>(chargeHour);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScheduleCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCompanion(
      id: Value(id),
      userEvId: Value(userEvId),
      chargeKwh: Value(chargeKwh),
      chargeHour: Value(chargeHour),
      createdAt: Value(createdAt),
    );
  }

  factory ScheduleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleData(
      id: serializer.fromJson<int>(json['id']),
      userEvId: serializer.fromJson<int>(json['userEvId']),
      chargeKwh: serializer.fromJson<double>(json['chargeKwh']),
      chargeHour: serializer.fromJson<int>(json['chargeHour']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userEvId': serializer.toJson<int>(userEvId),
      'chargeKwh': serializer.toJson<double>(chargeKwh),
      'chargeHour': serializer.toJson<int>(chargeHour),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScheduleData copyWith({
    int? id,
    int? userEvId,
    double? chargeKwh,
    int? chargeHour,
    DateTime? createdAt,
  }) => ScheduleData(
    id: id ?? this.id,
    userEvId: userEvId ?? this.userEvId,
    chargeKwh: chargeKwh ?? this.chargeKwh,
    chargeHour: chargeHour ?? this.chargeHour,
    createdAt: createdAt ?? this.createdAt,
  );
  ScheduleData copyWithCompanion(ScheduleCompanion data) {
    return ScheduleData(
      id: data.id.present ? data.id.value : this.id,
      userEvId: data.userEvId.present ? data.userEvId.value : this.userEvId,
      chargeKwh: data.chargeKwh.present ? data.chargeKwh.value : this.chargeKwh,
      chargeHour:
          data.chargeHour.present ? data.chargeHour.value : this.chargeHour,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleData(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('chargeKwh: $chargeKwh, ')
          ..write('chargeHour: $chargeHour, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userEvId, chargeKwh, chargeHour, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleData &&
          other.id == this.id &&
          other.userEvId == this.userEvId &&
          other.chargeKwh == this.chargeKwh &&
          other.chargeHour == this.chargeHour &&
          other.createdAt == this.createdAt);
}

class ScheduleCompanion extends UpdateCompanion<ScheduleData> {
  final Value<int> id;
  final Value<int> userEvId;
  final Value<double> chargeKwh;
  final Value<int> chargeHour;
  final Value<DateTime> createdAt;
  const ScheduleCompanion({
    this.id = const Value.absent(),
    this.userEvId = const Value.absent(),
    this.chargeKwh = const Value.absent(),
    this.chargeHour = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScheduleCompanion.insert({
    this.id = const Value.absent(),
    required int userEvId,
    required double chargeKwh,
    required int chargeHour,
    this.createdAt = const Value.absent(),
  }) : userEvId = Value(userEvId),
       chargeKwh = Value(chargeKwh),
       chargeHour = Value(chargeHour);
  static Insertable<ScheduleData> custom({
    Expression<int>? id,
    Expression<int>? userEvId,
    Expression<double>? chargeKwh,
    Expression<int>? chargeHour,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userEvId != null) 'user_ev_id': userEvId,
      if (chargeKwh != null) 'charge_kwh': chargeKwh,
      if (chargeHour != null) 'charge_hour': chargeHour,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScheduleCompanion copyWith({
    Value<int>? id,
    Value<int>? userEvId,
    Value<double>? chargeKwh,
    Value<int>? chargeHour,
    Value<DateTime>? createdAt,
  }) {
    return ScheduleCompanion(
      id: id ?? this.id,
      userEvId: userEvId ?? this.userEvId,
      chargeKwh: chargeKwh ?? this.chargeKwh,
      chargeHour: chargeHour ?? this.chargeHour,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userEvId.present) {
      map['user_ev_id'] = Variable<int>(userEvId.value);
    }
    if (chargeKwh.present) {
      map['charge_kwh'] = Variable<double>(chargeKwh.value);
    }
    if (chargeHour.present) {
      map['charge_hour'] = Variable<int>(chargeHour.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCompanion(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('chargeKwh: $chargeKwh, ')
          ..write('chargeHour: $chargeHour, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EVCarModelsTable eVCarModels = $EVCarModelsTable(this);
  late final $UserEVsTable userEVs = $UserEVsTable(this);
  late final $ConstraintsTable constraints = $ConstraintsTable(this);
  late final $ScheduleTable schedule = $ScheduleTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eVCarModels,
    userEVs,
    constraints,
    schedule,
  ];
}

typedef $$EVCarModelsTableCreateCompanionBuilder =
    EVCarModelsCompanion Function({
      Value<int> id,
      required String modelName,
      required int modelYear,
      required double batteryCapacity,
      required double maxChargingPower,
    });
typedef $$EVCarModelsTableUpdateCompanionBuilder =
    EVCarModelsCompanion Function({
      Value<int> id,
      Value<String> modelName,
      Value<int> modelYear,
      Value<double> batteryCapacity,
      Value<double> maxChargingPower,
    });

final class $$EVCarModelsTableReferences
    extends BaseReferences<_$AppDatabase, $EVCarModelsTable, EVCarModel> {
  $$EVCarModelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserEVsTable, List<UserEV>> _userEVsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.userEVs,
    aliasName: $_aliasNameGenerator(db.eVCarModels.id, db.userEVs.carModelId),
  );

  $$UserEVsTableProcessedTableManager get userEVsRefs {
    final manager = $$UserEVsTableTableManager(
      $_db,
      $_db.userEVs,
    ).filter((f) => f.carModelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userEVsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EVCarModelsTableFilterComposer
    extends Composer<_$AppDatabase, $EVCarModelsTable> {
  $$EVCarModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxChargingPower => $composableBuilder(
    column: $table.maxChargingPower,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userEVsRefs(
    Expression<bool> Function($$UserEVsTableFilterComposer f) f,
  ) {
    final $$UserEVsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.carModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableFilterComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EVCarModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $EVCarModelsTable> {
  $$EVCarModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelName => $composableBuilder(
    column: $table.modelName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxChargingPower => $composableBuilder(
    column: $table.maxChargingPower,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EVCarModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EVCarModelsTable> {
  $$EVCarModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get modelName =>
      $composableBuilder(column: $table.modelName, builder: (column) => column);

  GeneratedColumn<int> get modelYear =>
      $composableBuilder(column: $table.modelYear, builder: (column) => column);

  GeneratedColumn<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxChargingPower => $composableBuilder(
    column: $table.maxChargingPower,
    builder: (column) => column,
  );

  Expression<T> userEVsRefs<T extends Object>(
    Expression<T> Function($$UserEVsTableAnnotationComposer a) f,
  ) {
    final $$UserEVsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.carModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableAnnotationComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EVCarModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EVCarModelsTable,
          EVCarModel,
          $$EVCarModelsTableFilterComposer,
          $$EVCarModelsTableOrderingComposer,
          $$EVCarModelsTableAnnotationComposer,
          $$EVCarModelsTableCreateCompanionBuilder,
          $$EVCarModelsTableUpdateCompanionBuilder,
          (EVCarModel, $$EVCarModelsTableReferences),
          EVCarModel,
          PrefetchHooks Function({bool userEVsRefs})
        > {
  $$EVCarModelsTableTableManager(_$AppDatabase db, $EVCarModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EVCarModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EVCarModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$EVCarModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> modelName = const Value.absent(),
                Value<int> modelYear = const Value.absent(),
                Value<double> batteryCapacity = const Value.absent(),
                Value<double> maxChargingPower = const Value.absent(),
              }) => EVCarModelsCompanion(
                id: id,
                modelName: modelName,
                modelYear: modelYear,
                batteryCapacity: batteryCapacity,
                maxChargingPower: maxChargingPower,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String modelName,
                required int modelYear,
                required double batteryCapacity,
                required double maxChargingPower,
              }) => EVCarModelsCompanion.insert(
                id: id,
                modelName: modelName,
                modelYear: modelYear,
                batteryCapacity: batteryCapacity,
                maxChargingPower: maxChargingPower,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EVCarModelsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userEVsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userEVsRefs) db.userEVs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userEVsRefs)
                    await $_getPrefetchedData<
                      EVCarModel,
                      $EVCarModelsTable,
                      UserEV
                    >(
                      currentTable: table,
                      referencedTable: $$EVCarModelsTableReferences
                          ._userEVsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$EVCarModelsTableReferences(
                                db,
                                table,
                                p0,
                              ).userEVsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.carModelId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EVCarModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EVCarModelsTable,
      EVCarModel,
      $$EVCarModelsTableFilterComposer,
      $$EVCarModelsTableOrderingComposer,
      $$EVCarModelsTableAnnotationComposer,
      $$EVCarModelsTableCreateCompanionBuilder,
      $$EVCarModelsTableUpdateCompanionBuilder,
      (EVCarModel, $$EVCarModelsTableReferences),
      EVCarModel,
      PrefetchHooks Function({bool userEVsRefs})
    >;
typedef $$UserEVsTableCreateCompanionBuilder =
    UserEVsCompanion Function({
      Value<int> id,
      required int carModelId,
      required String userSetName,
      required double currentCharge,
    });
typedef $$UserEVsTableUpdateCompanionBuilder =
    UserEVsCompanion Function({
      Value<int> id,
      Value<int> carModelId,
      Value<String> userSetName,
      Value<double> currentCharge,
    });

final class $$UserEVsTableReferences
    extends BaseReferences<_$AppDatabase, $UserEVsTable, UserEV> {
  $$UserEVsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EVCarModelsTable _carModelIdTable(_$AppDatabase db) =>
      db.eVCarModels.createAlias(
        $_aliasNameGenerator(db.userEVs.carModelId, db.eVCarModels.id),
      );

  $$EVCarModelsTableProcessedTableManager get carModelId {
    final $_column = $_itemColumn<int>('car_model_id')!;

    final manager = $$EVCarModelsTableTableManager(
      $_db,
      $_db.eVCarModels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carModelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ConstraintsTable, List<Constraint>>
  _constraintsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.constraints,
    aliasName: $_aliasNameGenerator(
      db.userEVs.id,
      db.constraints.userCarModelId,
    ),
  );

  $$ConstraintsTableProcessedTableManager get constraintsRefs {
    final manager = $$ConstraintsTableTableManager(
      $_db,
      $_db.constraints,
    ).filter((f) => f.userCarModelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_constraintsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScheduleTable, List<ScheduleData>>
  _scheduleRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedule,
    aliasName: $_aliasNameGenerator(db.userEVs.id, db.schedule.userEvId),
  );

  $$ScheduleTableProcessedTableManager get scheduleRefs {
    final manager = $$ScheduleTableTableManager(
      $_db,
      $_db.schedule,
    ).filter((f) => f.userEvId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scheduleRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserEVsTableFilterComposer
    extends Composer<_$AppDatabase, $UserEVsTable> {
  $$UserEVsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userSetName => $composableBuilder(
    column: $table.userSetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentCharge => $composableBuilder(
    column: $table.currentCharge,
    builder: (column) => ColumnFilters(column),
  );

  $$EVCarModelsTableFilterComposer get carModelId {
    final $$EVCarModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carModelId,
      referencedTable: $db.eVCarModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EVCarModelsTableFilterComposer(
            $db: $db,
            $table: $db.eVCarModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> constraintsRefs(
    Expression<bool> Function($$ConstraintsTableFilterComposer f) f,
  ) {
    final $$ConstraintsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.constraints,
      getReferencedColumn: (t) => t.userCarModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConstraintsTableFilterComposer(
            $db: $db,
            $table: $db.constraints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduleRefs(
    Expression<bool> Function($$ScheduleTableFilterComposer f) f,
  ) {
    final $$ScheduleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedule,
      getReferencedColumn: (t) => t.userEvId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleTableFilterComposer(
            $db: $db,
            $table: $db.schedule,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserEVsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserEVsTable> {
  $$UserEVsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userSetName => $composableBuilder(
    column: $table.userSetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentCharge => $composableBuilder(
    column: $table.currentCharge,
    builder: (column) => ColumnOrderings(column),
  );

  $$EVCarModelsTableOrderingComposer get carModelId {
    final $$EVCarModelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carModelId,
      referencedTable: $db.eVCarModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EVCarModelsTableOrderingComposer(
            $db: $db,
            $table: $db.eVCarModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserEVsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserEVsTable> {
  $$UserEVsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userSetName => $composableBuilder(
    column: $table.userSetName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentCharge => $composableBuilder(
    column: $table.currentCharge,
    builder: (column) => column,
  );

  $$EVCarModelsTableAnnotationComposer get carModelId {
    final $$EVCarModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carModelId,
      referencedTable: $db.eVCarModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EVCarModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.eVCarModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> constraintsRefs<T extends Object>(
    Expression<T> Function($$ConstraintsTableAnnotationComposer a) f,
  ) {
    final $$ConstraintsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.constraints,
      getReferencedColumn: (t) => t.userCarModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConstraintsTableAnnotationComposer(
            $db: $db,
            $table: $db.constraints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scheduleRefs<T extends Object>(
    Expression<T> Function($$ScheduleTableAnnotationComposer a) f,
  ) {
    final $$ScheduleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedule,
      getReferencedColumn: (t) => t.userEvId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleTableAnnotationComposer(
            $db: $db,
            $table: $db.schedule,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserEVsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserEVsTable,
          UserEV,
          $$UserEVsTableFilterComposer,
          $$UserEVsTableOrderingComposer,
          $$UserEVsTableAnnotationComposer,
          $$UserEVsTableCreateCompanionBuilder,
          $$UserEVsTableUpdateCompanionBuilder,
          (UserEV, $$UserEVsTableReferences),
          UserEV,
          PrefetchHooks Function({
            bool carModelId,
            bool constraintsRefs,
            bool scheduleRefs,
          })
        > {
  $$UserEVsTableTableManager(_$AppDatabase db, $UserEVsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserEVsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserEVsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UserEVsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carModelId = const Value.absent(),
                Value<String> userSetName = const Value.absent(),
                Value<double> currentCharge = const Value.absent(),
              }) => UserEVsCompanion(
                id: id,
                carModelId: carModelId,
                userSetName: userSetName,
                currentCharge: currentCharge,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carModelId,
                required String userSetName,
                required double currentCharge,
              }) => UserEVsCompanion.insert(
                id: id,
                carModelId: carModelId,
                userSetName: userSetName,
                currentCharge: currentCharge,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UserEVsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            carModelId = false,
            constraintsRefs = false,
            scheduleRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (constraintsRefs) db.constraints,
                if (scheduleRefs) db.schedule,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (carModelId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.carModelId,
                            referencedTable: $$UserEVsTableReferences
                                ._carModelIdTable(db),
                            referencedColumn:
                                $$UserEVsTableReferences
                                    ._carModelIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (constraintsRefs)
                    await $_getPrefetchedData<
                      UserEV,
                      $UserEVsTable,
                      Constraint
                    >(
                      currentTable: table,
                      referencedTable: $$UserEVsTableReferences
                          ._constraintsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UserEVsTableReferences(
                                db,
                                table,
                                p0,
                              ).constraintsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.userCarModelId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (scheduleRefs)
                    await $_getPrefetchedData<
                      UserEV,
                      $UserEVsTable,
                      ScheduleData
                    >(
                      currentTable: table,
                      referencedTable: $$UserEVsTableReferences
                          ._scheduleRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UserEVsTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.userEvId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserEVsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserEVsTable,
      UserEV,
      $$UserEVsTableFilterComposer,
      $$UserEVsTableOrderingComposer,
      $$UserEVsTableAnnotationComposer,
      $$UserEVsTableCreateCompanionBuilder,
      $$UserEVsTableUpdateCompanionBuilder,
      (UserEV, $$UserEVsTableReferences),
      UserEV,
      PrefetchHooks Function({
        bool carModelId,
        bool constraintsRefs,
        bool scheduleRefs,
      })
    >;
typedef $$ConstraintsTableCreateCompanionBuilder =
    ConstraintsCompanion Function({
      Value<int> id,
      required int userCarModelId,
      required int dayOfWeek,
      required int startMinutes,
      required int endMinutes,
    });
typedef $$ConstraintsTableUpdateCompanionBuilder =
    ConstraintsCompanion Function({
      Value<int> id,
      Value<int> userCarModelId,
      Value<int> dayOfWeek,
      Value<int> startMinutes,
      Value<int> endMinutes,
    });

final class $$ConstraintsTableReferences
    extends BaseReferences<_$AppDatabase, $ConstraintsTable, Constraint> {
  $$ConstraintsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserEVsTable _userCarModelIdTable(_$AppDatabase db) =>
      db.userEVs.createAlias(
        $_aliasNameGenerator(db.constraints.userCarModelId, db.userEVs.id),
      );

  $$UserEVsTableProcessedTableManager get userCarModelId {
    final $_column = $_itemColumn<int>('user_car_model_id')!;

    final manager = $$UserEVsTableTableManager(
      $_db,
      $_db.userEVs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userCarModelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConstraintsTableFilterComposer
    extends Composer<_$AppDatabase, $ConstraintsTable> {
  $$ConstraintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnFilters(column),
  );

  $$UserEVsTableFilterComposer get userCarModelId {
    final $$UserEVsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCarModelId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableFilterComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConstraintsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConstraintsTable> {
  $$ConstraintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserEVsTableOrderingComposer get userCarModelId {
    final $$UserEVsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCarModelId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableOrderingComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConstraintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConstraintsTable> {
  $$ConstraintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => column,
  );

  $$UserEVsTableAnnotationComposer get userCarModelId {
    final $$UserEVsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCarModelId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableAnnotationComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConstraintsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConstraintsTable,
          Constraint,
          $$ConstraintsTableFilterComposer,
          $$ConstraintsTableOrderingComposer,
          $$ConstraintsTableAnnotationComposer,
          $$ConstraintsTableCreateCompanionBuilder,
          $$ConstraintsTableUpdateCompanionBuilder,
          (Constraint, $$ConstraintsTableReferences),
          Constraint,
          PrefetchHooks Function({bool userCarModelId})
        > {
  $$ConstraintsTableTableManager(_$AppDatabase db, $ConstraintsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ConstraintsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ConstraintsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ConstraintsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userCarModelId = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<int> startMinutes = const Value.absent(),
                Value<int> endMinutes = const Value.absent(),
              }) => ConstraintsCompanion(
                id: id,
                userCarModelId: userCarModelId,
                dayOfWeek: dayOfWeek,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userCarModelId,
                required int dayOfWeek,
                required int startMinutes,
                required int endMinutes,
              }) => ConstraintsCompanion.insert(
                id: id,
                userCarModelId: userCarModelId,
                dayOfWeek: dayOfWeek,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ConstraintsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userCarModelId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userCarModelId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userCarModelId,
                            referencedTable: $$ConstraintsTableReferences
                                ._userCarModelIdTable(db),
                            referencedColumn:
                                $$ConstraintsTableReferences
                                    ._userCarModelIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConstraintsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConstraintsTable,
      Constraint,
      $$ConstraintsTableFilterComposer,
      $$ConstraintsTableOrderingComposer,
      $$ConstraintsTableAnnotationComposer,
      $$ConstraintsTableCreateCompanionBuilder,
      $$ConstraintsTableUpdateCompanionBuilder,
      (Constraint, $$ConstraintsTableReferences),
      Constraint,
      PrefetchHooks Function({bool userCarModelId})
    >;
typedef $$ScheduleTableCreateCompanionBuilder =
    ScheduleCompanion Function({
      Value<int> id,
      required int userEvId,
      required double chargeKwh,
      required int chargeHour,
      Value<DateTime> createdAt,
    });
typedef $$ScheduleTableUpdateCompanionBuilder =
    ScheduleCompanion Function({
      Value<int> id,
      Value<int> userEvId,
      Value<double> chargeKwh,
      Value<int> chargeHour,
      Value<DateTime> createdAt,
    });

final class $$ScheduleTableReferences
    extends BaseReferences<_$AppDatabase, $ScheduleTable, ScheduleData> {
  $$ScheduleTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserEVsTable _userEvIdTable(_$AppDatabase db) => db.userEVs
      .createAlias($_aliasNameGenerator(db.schedule.userEvId, db.userEVs.id));

  $$UserEVsTableProcessedTableManager get userEvId {
    final $_column = $_itemColumn<int>('user_ev_id')!;

    final manager = $$UserEVsTableTableManager(
      $_db,
      $_db.userEVs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userEvIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScheduleTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleTable> {
  $$ScheduleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chargeKwh => $composableBuilder(
    column: $table.chargeKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chargeHour => $composableBuilder(
    column: $table.chargeHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserEVsTableFilterComposer get userEvId {
    final $$UserEVsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userEvId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableFilterComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleTable> {
  $$ScheduleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chargeKwh => $composableBuilder(
    column: $table.chargeKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chargeHour => $composableBuilder(
    column: $table.chargeHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserEVsTableOrderingComposer get userEvId {
    final $$UserEVsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userEvId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableOrderingComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleTable> {
  $$ScheduleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get chargeKwh =>
      $composableBuilder(column: $table.chargeKwh, builder: (column) => column);

  GeneratedColumn<int> get chargeHour => $composableBuilder(
    column: $table.chargeHour,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UserEVsTableAnnotationComposer get userEvId {
    final $$UserEVsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userEvId,
      referencedTable: $db.userEVs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserEVsTableAnnotationComposer(
            $db: $db,
            $table: $db.userEVs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleTable,
          ScheduleData,
          $$ScheduleTableFilterComposer,
          $$ScheduleTableOrderingComposer,
          $$ScheduleTableAnnotationComposer,
          $$ScheduleTableCreateCompanionBuilder,
          $$ScheduleTableUpdateCompanionBuilder,
          (ScheduleData, $$ScheduleTableReferences),
          ScheduleData,
          PrefetchHooks Function({bool userEvId})
        > {
  $$ScheduleTableTableManager(_$AppDatabase db, $ScheduleTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ScheduleTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ScheduleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ScheduleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userEvId = const Value.absent(),
                Value<double> chargeKwh = const Value.absent(),
                Value<int> chargeHour = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScheduleCompanion(
                id: id,
                userEvId: userEvId,
                chargeKwh: chargeKwh,
                chargeHour: chargeHour,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userEvId,
                required double chargeKwh,
                required int chargeHour,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScheduleCompanion.insert(
                id: id,
                userEvId: userEvId,
                chargeKwh: chargeKwh,
                chargeHour: chargeHour,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ScheduleTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userEvId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userEvId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userEvId,
                            referencedTable: $$ScheduleTableReferences
                                ._userEvIdTable(db),
                            referencedColumn:
                                $$ScheduleTableReferences._userEvIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScheduleTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleTable,
      ScheduleData,
      $$ScheduleTableFilterComposer,
      $$ScheduleTableOrderingComposer,
      $$ScheduleTableAnnotationComposer,
      $$ScheduleTableCreateCompanionBuilder,
      $$ScheduleTableUpdateCompanionBuilder,
      (ScheduleData, $$ScheduleTableReferences),
      ScheduleData,
      PrefetchHooks Function({bool userEvId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EVCarModelsTableTableManager get eVCarModels =>
      $$EVCarModelsTableTableManager(_db, _db.eVCarModels);
  $$UserEVsTableTableManager get userEVs =>
      $$UserEVsTableTableManager(_db, _db.userEVs);
  $$ConstraintsTableTableManager get constraints =>
      $$ConstraintsTableTableManager(_db, _db.constraints);
  $$ScheduleTableTableManager get schedule =>
      $$ScheduleTableTableManager(_db, _db.schedule);
}
