// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_signs_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVitalSignsEntityCollection on Isar {
  IsarCollection<VitalSignsEntity> get vitalSignsEntitys => this.collection();
}

const VitalSignsEntitySchema = CollectionSchema(
  name: r'VitalSignsEntity',
  id: 7604125667105568132,
  properties: {
    r'bpDia': PropertySchema(
      id: 0,
      name: r'bpDia',
      type: IsarType.long,
    ),
    r'bpSys': PropertySchema(
      id: 1,
      name: r'bpSys',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'heartRate': PropertySchema(
      id: 3,
      name: r'heartRate',
      type: IsarType.long,
    ),
    r'tempC': PropertySchema(
      id: 4,
      name: r'tempC',
      type: IsarType.double,
    )
  },
  estimateSize: _vitalSignsEntityEstimateSize,
  serialize: _vitalSignsEntitySerialize,
  deserialize: _vitalSignsEntityDeserialize,
  deserializeProp: _vitalSignsEntityDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _vitalSignsEntityGetId,
  getLinks: _vitalSignsEntityGetLinks,
  attach: _vitalSignsEntityAttach,
  version: '3.1.0+1',
);

int _vitalSignsEntityEstimateSize(
  VitalSignsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _vitalSignsEntitySerialize(
  VitalSignsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bpDia);
  writer.writeLong(offsets[1], object.bpSys);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.heartRate);
  writer.writeDouble(offsets[4], object.tempC);
}

VitalSignsEntity _vitalSignsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VitalSignsEntity(
    bpDia: reader.readLong(offsets[0]),
    bpSys: reader.readLong(offsets[1]),
    createdAt: reader.readDateTime(offsets[2]),
    heartRate: reader.readLong(offsets[3]),
    tempC: reader.readDouble(offsets[4]),
  );
  object.isarId = id;
  return object;
}

P _vitalSignsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vitalSignsEntityGetId(VitalSignsEntity object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _vitalSignsEntityGetLinks(VitalSignsEntity object) {
  return [];
}

void _vitalSignsEntityAttach(
    IsarCollection<dynamic> col, Id id, VitalSignsEntity object) {
  object.isarId = id;
}

extension VitalSignsEntityQueryWhereSort
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QWhere> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VitalSignsEntityQueryWhere
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QWhereClause> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VitalSignsEntityQueryFilter
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QFilterCondition> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpDiaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bpDia',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpDiaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bpDia',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpDiaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bpDia',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpDiaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bpDia',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpSysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bpSys',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpSysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bpSys',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpSysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bpSys',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      bpSysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bpSys',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      heartRateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      heartRateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      heartRateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      heartRateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heartRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      tempCEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tempC',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      tempCGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tempC',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      tempCLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tempC',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterFilterCondition>
      tempCBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tempC',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension VitalSignsEntityQueryObject
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QFilterCondition> {}

extension VitalSignsEntityQueryLinks
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QFilterCondition> {}

extension VitalSignsEntityQuerySortBy
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QSortBy> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> sortByBpDia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDia', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByBpDiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDia', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> sortByBpSys() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSys', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByBpSysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSys', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heartRate', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByHeartRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heartRate', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> sortByTempC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempC', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      sortByTempCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempC', Sort.desc);
    });
  }
}

extension VitalSignsEntityQuerySortThenBy
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QSortThenBy> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> thenByBpDia() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDia', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByBpDiaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpDia', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> thenByBpSys() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSys', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByBpSysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bpSys', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heartRate', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByHeartRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heartRate', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy> thenByTempC() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempC', Sort.asc);
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QAfterSortBy>
      thenByTempCDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempC', Sort.desc);
    });
  }
}

extension VitalSignsEntityQueryWhereDistinct
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct> {
  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct>
      distinctByBpDia() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bpDia');
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct>
      distinctByBpSys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bpSys');
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct>
      distinctByHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heartRate');
    });
  }

  QueryBuilder<VitalSignsEntity, VitalSignsEntity, QDistinct>
      distinctByTempC() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempC');
    });
  }
}

extension VitalSignsEntityQueryProperty
    on QueryBuilder<VitalSignsEntity, VitalSignsEntity, QQueryProperty> {
  QueryBuilder<VitalSignsEntity, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<VitalSignsEntity, int, QQueryOperations> bpDiaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bpDia');
    });
  }

  QueryBuilder<VitalSignsEntity, int, QQueryOperations> bpSysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bpSys');
    });
  }

  QueryBuilder<VitalSignsEntity, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<VitalSignsEntity, int, QQueryOperations> heartRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heartRate');
    });
  }

  QueryBuilder<VitalSignsEntity, double, QQueryOperations> tempCProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempC');
    });
  }
}
