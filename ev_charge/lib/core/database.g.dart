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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
      modelYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}model_year'],
      ),
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
  final int? modelYear;
  final double batteryCapacity;
  final double maxChargingPower;
  const EVCarModel({
    required this.id,
    required this.modelName,
    this.modelYear,
    required this.batteryCapacity,
    required this.maxChargingPower,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['model_name'] = Variable<String>(modelName);
    if (!nullToAbsent || modelYear != null) {
      map['model_year'] = Variable<int>(modelYear);
    }
    map['battery_capacity'] = Variable<double>(batteryCapacity);
    map['max_charging_power'] = Variable<double>(maxChargingPower);
    return map;
  }

  EVCarModelsCompanion toCompanion(bool nullToAbsent) {
    return EVCarModelsCompanion(
      id: Value(id),
      modelName: Value(modelName),
      modelYear:
          modelYear == null && nullToAbsent
              ? const Value.absent()
              : Value(modelYear),
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
      modelYear: serializer.fromJson<int?>(json['modelYear']),
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
      'modelYear': serializer.toJson<int?>(modelYear),
      'batteryCapacity': serializer.toJson<double>(batteryCapacity),
      'maxChargingPower': serializer.toJson<double>(maxChargingPower),
    };
  }

  EVCarModel copyWith({
    int? id,
    String? modelName,
    Value<int?> modelYear = const Value.absent(),
    double? batteryCapacity,
    double? maxChargingPower,
  }) => EVCarModel(
    id: id ?? this.id,
    modelName: modelName ?? this.modelName,
    modelYear: modelYear.present ? modelYear.value : this.modelYear,
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
  final Value<int?> modelYear;
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
    this.modelYear = const Value.absent(),
    required double batteryCapacity,
    required double maxChargingPower,
  }) : modelName = Value(modelName),
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
    Value<int?>? modelYear,
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EVCarModelsTable eVCarModels = $EVCarModelsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [eVCarModels];
}

typedef $$EVCarModelsTableCreateCompanionBuilder =
    EVCarModelsCompanion Function({
      Value<int> id,
      required String modelName,
      Value<int?> modelYear,
      required double batteryCapacity,
      required double maxChargingPower,
    });
typedef $$EVCarModelsTableUpdateCompanionBuilder =
    EVCarModelsCompanion Function({
      Value<int> id,
      Value<String> modelName,
      Value<int?> modelYear,
      Value<double> batteryCapacity,
      Value<double> maxChargingPower,
    });

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
          (
            EVCarModel,
            BaseReferences<_$AppDatabase, $EVCarModelsTable, EVCarModel>,
          ),
          EVCarModel,
          PrefetchHooks Function()
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
                Value<int?> modelYear = const Value.absent(),
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
                Value<int?> modelYear = const Value.absent(),
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
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
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
      (
        EVCarModel,
        BaseReferences<_$AppDatabase, $EVCarModelsTable, EVCarModel>,
      ),
      EVCarModel,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EVCarModelsTableTableManager get eVCarModels =>
      $$EVCarModelsTableTableManager(_db, _db.eVCarModels);
}
