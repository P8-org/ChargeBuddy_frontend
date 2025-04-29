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
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carModelId,
    userSetName,
    currentCharge,
    state,
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
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
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
      state:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}state'],
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
  final String state;
  const UserEV({
    required this.id,
    required this.carModelId,
    required this.userSetName,
    required this.currentCharge,
    required this.state,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_model_id'] = Variable<int>(carModelId);
    map['user_set_name'] = Variable<String>(userSetName);
    map['current_charge'] = Variable<double>(currentCharge);
    map['state'] = Variable<String>(state);
    return map;
  }

  UserEVsCompanion toCompanion(bool nullToAbsent) {
    return UserEVsCompanion(
      id: Value(id),
      carModelId: Value(carModelId),
      userSetName: Value(userSetName),
      currentCharge: Value(currentCharge),
      state: Value(state),
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
      state: serializer.fromJson<String>(json['state']),
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
      'state': serializer.toJson<String>(state),
    };
  }

  UserEV copyWith({
    int? id,
    int? carModelId,
    String? userSetName,
    double? currentCharge,
    String? state,
  }) => UserEV(
    id: id ?? this.id,
    carModelId: carModelId ?? this.carModelId,
    userSetName: userSetName ?? this.userSetName,
    currentCharge: currentCharge ?? this.currentCharge,
    state: state ?? this.state,
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
      state: data.state.present ? data.state.value : this.state,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserEV(')
          ..write('id: $id, ')
          ..write('carModelId: $carModelId, ')
          ..write('userSetName: $userSetName, ')
          ..write('currentCharge: $currentCharge, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, carModelId, userSetName, currentCharge, state);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEV &&
          other.id == this.id &&
          other.carModelId == this.carModelId &&
          other.userSetName == this.userSetName &&
          other.currentCharge == this.currentCharge &&
          other.state == this.state);
}

class UserEVsCompanion extends UpdateCompanion<UserEV> {
  final Value<int> id;
  final Value<int> carModelId;
  final Value<String> userSetName;
  final Value<double> currentCharge;
  final Value<String> state;
  const UserEVsCompanion({
    this.id = const Value.absent(),
    this.carModelId = const Value.absent(),
    this.userSetName = const Value.absent(),
    this.currentCharge = const Value.absent(),
    this.state = const Value.absent(),
  });
  UserEVsCompanion.insert({
    this.id = const Value.absent(),
    required int carModelId,
    required String userSetName,
    required double currentCharge,
    required String state,
  }) : carModelId = Value(carModelId),
       userSetName = Value(userSetName),
       currentCharge = Value(currentCharge),
       state = Value(state);
  static Insertable<UserEV> custom({
    Expression<int>? id,
    Expression<int>? carModelId,
    Expression<String>? userSetName,
    Expression<double>? currentCharge,
    Expression<String>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carModelId != null) 'car_model_id': carModelId,
      if (userSetName != null) 'user_set_name': userSetName,
      if (currentCharge != null) 'current_charge': currentCharge,
      if (state != null) 'state': state,
    });
  }

  UserEVsCompanion copyWith({
    Value<int>? id,
    Value<int>? carModelId,
    Value<String>? userSetName,
    Value<double>? currentCharge,
    Value<String>? state,
  }) {
    return UserEVsCompanion(
      id: id ?? this.id,
      carModelId: carModelId ?? this.carModelId,
      userSetName: userSetName ?? this.userSetName,
      currentCharge: currentCharge ?? this.currentCharge,
      state: state ?? this.state,
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
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserEVsCompanion(')
          ..write('id: $id, ')
          ..write('carModelId: $carModelId, ')
          ..write('userSetName: $userSetName, ')
          ..write('currentCharge: $currentCharge, ')
          ..write('state: $state')
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
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chargedByMeta = const VerificationMeta(
    'chargedBy',
  );
  @override
  late final GeneratedColumn<DateTime> chargedBy = GeneratedColumn<DateTime>(
    'charged_by',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minPercentageMeta = const VerificationMeta(
    'minPercentage',
  );
  @override
  late final GeneratedColumn<double> minPercentage = GeneratedColumn<double>(
    'min_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userEvId,
    startTime,
    chargedBy,
    minPercentage,
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
    if (data.containsKey('user_ev_id')) {
      context.handle(
        _userEvIdMeta,
        userEvId.isAcceptableOrUnknown(data['user_ev_id']!, _userEvIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userEvIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('charged_by')) {
      context.handle(
        _chargedByMeta,
        chargedBy.isAcceptableOrUnknown(data['charged_by']!, _chargedByMeta),
      );
    } else if (isInserting) {
      context.missing(_chargedByMeta);
    }
    if (data.containsKey('min_percentage')) {
      context.handle(
        _minPercentageMeta,
        minPercentage.isAcceptableOrUnknown(
          data['min_percentage']!,
          _minPercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minPercentageMeta);
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
      userEvId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_ev_id'],
          )!,
      startTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_time'],
          )!,
      chargedBy:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}charged_by'],
          )!,
      minPercentage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}min_percentage'],
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
  final int userEvId;
  final DateTime startTime;
  final DateTime chargedBy;
  final double minPercentage;
  const Constraint({
    required this.id,
    required this.userEvId,
    required this.startTime,
    required this.chargedBy,
    required this.minPercentage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_ev_id'] = Variable<int>(userEvId);
    map['start_time'] = Variable<DateTime>(startTime);
    map['charged_by'] = Variable<DateTime>(chargedBy);
    map['min_percentage'] = Variable<double>(minPercentage);
    return map;
  }

  ConstraintsCompanion toCompanion(bool nullToAbsent) {
    return ConstraintsCompanion(
      id: Value(id),
      userEvId: Value(userEvId),
      startTime: Value(startTime),
      chargedBy: Value(chargedBy),
      minPercentage: Value(minPercentage),
    );
  }

  factory Constraint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Constraint(
      id: serializer.fromJson<int>(json['id']),
      userEvId: serializer.fromJson<int>(json['userEvId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      chargedBy: serializer.fromJson<DateTime>(json['chargedBy']),
      minPercentage: serializer.fromJson<double>(json['minPercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userEvId': serializer.toJson<int>(userEvId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'chargedBy': serializer.toJson<DateTime>(chargedBy),
      'minPercentage': serializer.toJson<double>(minPercentage),
    };
  }

  Constraint copyWith({
    int? id,
    int? userEvId,
    DateTime? startTime,
    DateTime? chargedBy,
    double? minPercentage,
  }) => Constraint(
    id: id ?? this.id,
    userEvId: userEvId ?? this.userEvId,
    startTime: startTime ?? this.startTime,
    chargedBy: chargedBy ?? this.chargedBy,
    minPercentage: minPercentage ?? this.minPercentage,
  );
  Constraint copyWithCompanion(ConstraintsCompanion data) {
    return Constraint(
      id: data.id.present ? data.id.value : this.id,
      userEvId: data.userEvId.present ? data.userEvId.value : this.userEvId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      chargedBy: data.chargedBy.present ? data.chargedBy.value : this.chargedBy,
      minPercentage:
          data.minPercentage.present
              ? data.minPercentage.value
              : this.minPercentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Constraint(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('startTime: $startTime, ')
          ..write('chargedBy: $chargedBy, ')
          ..write('minPercentage: $minPercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userEvId, startTime, chargedBy, minPercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Constraint &&
          other.id == this.id &&
          other.userEvId == this.userEvId &&
          other.startTime == this.startTime &&
          other.chargedBy == this.chargedBy &&
          other.minPercentage == this.minPercentage);
}

class ConstraintsCompanion extends UpdateCompanion<Constraint> {
  final Value<int> id;
  final Value<int> userEvId;
  final Value<DateTime> startTime;
  final Value<DateTime> chargedBy;
  final Value<double> minPercentage;
  const ConstraintsCompanion({
    this.id = const Value.absent(),
    this.userEvId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.chargedBy = const Value.absent(),
    this.minPercentage = const Value.absent(),
  });
  ConstraintsCompanion.insert({
    this.id = const Value.absent(),
    required int userEvId,
    required DateTime startTime,
    required DateTime chargedBy,
    required double minPercentage,
  }) : userEvId = Value(userEvId),
       startTime = Value(startTime),
       chargedBy = Value(chargedBy),
       minPercentage = Value(minPercentage);
  static Insertable<Constraint> custom({
    Expression<int>? id,
    Expression<int>? userEvId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? chargedBy,
    Expression<double>? minPercentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userEvId != null) 'user_ev_id': userEvId,
      if (startTime != null) 'start_time': startTime,
      if (chargedBy != null) 'charged_by': chargedBy,
      if (minPercentage != null) 'min_percentage': minPercentage,
    });
  }

  ConstraintsCompanion copyWith({
    Value<int>? id,
    Value<int>? userEvId,
    Value<DateTime>? startTime,
    Value<DateTime>? chargedBy,
    Value<double>? minPercentage,
  }) {
    return ConstraintsCompanion(
      id: id ?? this.id,
      userEvId: userEvId ?? this.userEvId,
      startTime: startTime ?? this.startTime,
      chargedBy: chargedBy ?? this.chargedBy,
      minPercentage: minPercentage ?? this.minPercentage,
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
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (chargedBy.present) {
      map['charged_by'] = Variable<DateTime>(chargedBy.value);
    }
    if (minPercentage.present) {
      map['min_percentage'] = Variable<double>(minPercentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConstraintsCompanion(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('startTime: $startTime, ')
          ..write('chargedBy: $chargedBy, ')
          ..write('minPercentage: $minPercentage')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleDataMeta = const VerificationMeta(
    'scheduleData',
  );
  @override
  late final GeneratedColumn<String> scheduleData = GeneratedColumn<String>(
    'schedule_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userEvId,
    start,
    end,
    scheduleData,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Schedule> instance, {
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
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('schedule_data')) {
      context.handle(
        _scheduleDataMeta,
        scheduleData.isAcceptableOrUnknown(
          data['schedule_data']!,
          _scheduleDataMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
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
      start:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start'],
          )!,
      end:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end'],
          )!,
      scheduleData:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}schedule_data'],
          )!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final int userEvId;
  final DateTime start;
  final DateTime end;
  final String scheduleData;
  const Schedule({
    required this.id,
    required this.userEvId,
    required this.start,
    required this.end,
    required this.scheduleData,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_ev_id'] = Variable<int>(userEvId);
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    map['schedule_data'] = Variable<String>(scheduleData);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      userEvId: Value(userEvId),
      start: Value(start),
      end: Value(end),
      scheduleData: Value(scheduleData),
    );
  }

  factory Schedule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      userEvId: serializer.fromJson<int>(json['userEvId']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      scheduleData: serializer.fromJson<String>(json['scheduleData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userEvId': serializer.toJson<int>(userEvId),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'scheduleData': serializer.toJson<String>(scheduleData),
    };
  }

  Schedule copyWith({
    int? id,
    int? userEvId,
    DateTime? start,
    DateTime? end,
    String? scheduleData,
  }) => Schedule(
    id: id ?? this.id,
    userEvId: userEvId ?? this.userEvId,
    start: start ?? this.start,
    end: end ?? this.end,
    scheduleData: scheduleData ?? this.scheduleData,
  );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      userEvId: data.userEvId.present ? data.userEvId.value : this.userEvId,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      scheduleData:
          data.scheduleData.present
              ? data.scheduleData.value
              : this.scheduleData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('scheduleData: $scheduleData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userEvId, start, end, scheduleData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.userEvId == this.userEvId &&
          other.start == this.start &&
          other.end == this.end &&
          other.scheduleData == this.scheduleData);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<int> userEvId;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<String> scheduleData;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.userEvId = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.scheduleData = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required int userEvId,
    required DateTime start,
    required DateTime end,
    required String scheduleData,
  }) : userEvId = Value(userEvId),
       start = Value(start),
       end = Value(end),
       scheduleData = Value(scheduleData);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<int>? userEvId,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<String>? scheduleData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userEvId != null) 'user_ev_id': userEvId,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (scheduleData != null) 'schedule_data': scheduleData,
    });
  }

  SchedulesCompanion copyWith({
    Value<int>? id,
    Value<int>? userEvId,
    Value<DateTime>? start,
    Value<DateTime>? end,
    Value<String>? scheduleData,
  }) {
    return SchedulesCompanion(
      id: id ?? this.id,
      userEvId: userEvId ?? this.userEvId,
      start: start ?? this.start,
      end: end ?? this.end,
      scheduleData: scheduleData ?? this.scheduleData,
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
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (scheduleData.present) {
      map['schedule_data'] = Variable<String>(scheduleData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('userEvId: $userEvId, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('scheduleData: $scheduleData')
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
  late final $SchedulesTable schedules = $SchedulesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eVCarModels,
    userEVs,
    constraints,
    schedules,
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
      required String state,
    });
typedef $$UserEVsTableUpdateCompanionBuilder =
    UserEVsCompanion Function({
      Value<int> id,
      Value<int> carModelId,
      Value<String> userSetName,
      Value<double> currentCharge,
      Value<String> state,
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
    aliasName: $_aliasNameGenerator(db.userEVs.id, db.constraints.userEvId),
  );

  $$ConstraintsTableProcessedTableManager get constraintsRefs {
    final manager = $$ConstraintsTableTableManager(
      $_db,
      $_db.constraints,
    ).filter((f) => f.userEvId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_constraintsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SchedulesTable, List<Schedule>>
  _schedulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.schedules,
    aliasName: $_aliasNameGenerator(db.userEVs.id, db.schedules.userEvId),
  );

  $$SchedulesTableProcessedTableManager get schedulesRefs {
    final manager = $$SchedulesTableTableManager(
      $_db,
      $_db.schedules,
    ).filter((f) => f.userEvId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_schedulesRefsTable($_db));
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

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
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
      getReferencedColumn: (t) => t.userEvId,
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

  Expression<bool> schedulesRefs(
    Expression<bool> Function($$SchedulesTableFilterComposer f) f,
  ) {
    final $$SchedulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.userEvId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableFilterComposer(
            $db: $db,
            $table: $db.schedules,
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

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
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

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

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
      getReferencedColumn: (t) => t.userEvId,
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

  Expression<T> schedulesRefs<T extends Object>(
    Expression<T> Function($$SchedulesTableAnnotationComposer a) f,
  ) {
    final $$SchedulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.schedules,
      getReferencedColumn: (t) => t.userEvId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SchedulesTableAnnotationComposer(
            $db: $db,
            $table: $db.schedules,
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
            bool schedulesRefs,
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
                Value<String> state = const Value.absent(),
              }) => UserEVsCompanion(
                id: id,
                carModelId: carModelId,
                userSetName: userSetName,
                currentCharge: currentCharge,
                state: state,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carModelId,
                required String userSetName,
                required double currentCharge,
                required String state,
              }) => UserEVsCompanion.insert(
                id: id,
                carModelId: carModelId,
                userSetName: userSetName,
                currentCharge: currentCharge,
                state: state,
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
            schedulesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (constraintsRefs) db.constraints,
                if (schedulesRefs) db.schedules,
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
                            (e) => e.userEvId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (schedulesRefs)
                    await $_getPrefetchedData<UserEV, $UserEVsTable, Schedule>(
                      currentTable: table,
                      referencedTable: $$UserEVsTableReferences
                          ._schedulesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UserEVsTableReferences(
                                db,
                                table,
                                p0,
                              ).schedulesRefs,
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
        bool schedulesRefs,
      })
    >;
typedef $$ConstraintsTableCreateCompanionBuilder =
    ConstraintsCompanion Function({
      Value<int> id,
      required int userEvId,
      required DateTime startTime,
      required DateTime chargedBy,
      required double minPercentage,
    });
typedef $$ConstraintsTableUpdateCompanionBuilder =
    ConstraintsCompanion Function({
      Value<int> id,
      Value<int> userEvId,
      Value<DateTime> startTime,
      Value<DateTime> chargedBy,
      Value<double> minPercentage,
    });

final class $$ConstraintsTableReferences
    extends BaseReferences<_$AppDatabase, $ConstraintsTable, Constraint> {
  $$ConstraintsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserEVsTable _userEvIdTable(_$AppDatabase db) =>
      db.userEVs.createAlias(
        $_aliasNameGenerator(db.constraints.userEvId, db.userEVs.id),
      );

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

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get chargedBy => $composableBuilder(
    column: $table.chargedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minPercentage => $composableBuilder(
    column: $table.minPercentage,
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

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get chargedBy => $composableBuilder(
    column: $table.chargedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minPercentage => $composableBuilder(
    column: $table.minPercentage,
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

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get chargedBy =>
      $composableBuilder(column: $table.chargedBy, builder: (column) => column);

  GeneratedColumn<double> get minPercentage => $composableBuilder(
    column: $table.minPercentage,
    builder: (column) => column,
  );

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
          PrefetchHooks Function({bool userEvId})
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
                Value<int> userEvId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> chargedBy = const Value.absent(),
                Value<double> minPercentage = const Value.absent(),
              }) => ConstraintsCompanion(
                id: id,
                userEvId: userEvId,
                startTime: startTime,
                chargedBy: chargedBy,
                minPercentage: minPercentage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userEvId,
                required DateTime startTime,
                required DateTime chargedBy,
                required double minPercentage,
              }) => ConstraintsCompanion.insert(
                id: id,
                userEvId: userEvId,
                startTime: startTime,
                chargedBy: chargedBy,
                minPercentage: minPercentage,
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
                            referencedTable: $$ConstraintsTableReferences
                                ._userEvIdTable(db),
                            referencedColumn:
                                $$ConstraintsTableReferences
                                    ._userEvIdTable(db)
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
      PrefetchHooks Function({bool userEvId})
    >;
typedef $$SchedulesTableCreateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      required int userEvId,
      required DateTime start,
      required DateTime end,
      required String scheduleData,
    });
typedef $$SchedulesTableUpdateCompanionBuilder =
    SchedulesCompanion Function({
      Value<int> id,
      Value<int> userEvId,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<String> scheduleData,
    });

final class $$SchedulesTableReferences
    extends BaseReferences<_$AppDatabase, $SchedulesTable, Schedule> {
  $$SchedulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserEVsTable _userEvIdTable(_$AppDatabase db) => db.userEVs
      .createAlias($_aliasNameGenerator(db.schedules.userEvId, db.userEVs.id));

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

class $$SchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
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

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleData => $composableBuilder(
    column: $table.scheduleData,
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

class $$SchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleData => $composableBuilder(
    column: $table.scheduleData,
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

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<String> get scheduleData => $composableBuilder(
    column: $table.scheduleData,
    builder: (column) => column,
  );

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

class $$SchedulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchedulesTable,
          Schedule,
          $$SchedulesTableFilterComposer,
          $$SchedulesTableOrderingComposer,
          $$SchedulesTableAnnotationComposer,
          $$SchedulesTableCreateCompanionBuilder,
          $$SchedulesTableUpdateCompanionBuilder,
          (Schedule, $$SchedulesTableReferences),
          Schedule,
          PrefetchHooks Function({bool userEvId})
        > {
  $$SchedulesTableTableManager(_$AppDatabase db, $SchedulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userEvId = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime> end = const Value.absent(),
                Value<String> scheduleData = const Value.absent(),
              }) => SchedulesCompanion(
                id: id,
                userEvId: userEvId,
                start: start,
                end: end,
                scheduleData: scheduleData,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userEvId,
                required DateTime start,
                required DateTime end,
                required String scheduleData,
              }) => SchedulesCompanion.insert(
                id: id,
                userEvId: userEvId,
                start: start,
                end: end,
                scheduleData: scheduleData,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SchedulesTableReferences(db, table, e),
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
                            referencedTable: $$SchedulesTableReferences
                                ._userEvIdTable(db),
                            referencedColumn:
                                $$SchedulesTableReferences
                                    ._userEvIdTable(db)
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

typedef $$SchedulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchedulesTable,
      Schedule,
      $$SchedulesTableFilterComposer,
      $$SchedulesTableOrderingComposer,
      $$SchedulesTableAnnotationComposer,
      $$SchedulesTableCreateCompanionBuilder,
      $$SchedulesTableUpdateCompanionBuilder,
      (Schedule, $$SchedulesTableReferences),
      Schedule,
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
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
}
