// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShareHistoryCollection on Isar {
  IsarCollection<ShareHistory> get shareHistorys => this.collection();
}

const ShareHistorySchema = CollectionSchema(
  name: r'ShareHistory',
  id: -4270466041369013744,
  properties: {
    r'exchangeType': PropertySchema(
      id: 0,
      name: r'exchangeType',
      type: IsarType.byte,
      enumMap: _ShareHistoryexchangeTypeEnumValueMap,
    ),
    r'exchangedAt': PropertySchema(
      id: 1,
      name: r'exchangedAt',
      type: IsarType.dateTime,
    ),
    r'method': PropertySchema(
      id: 2,
      name: r'method',
      type: IsarType.string,
    )
  },
  estimateSize: _shareHistoryEstimateSize,
  serialize: _shareHistorySerialize,
  deserialize: _shareHistoryDeserialize,
  deserializeProp: _shareHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'namecard': LinkSchema(
      id: -699268010551874746,
      name: r'namecard',
      target: r'Namecard',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _shareHistoryGetId,
  getLinks: _shareHistoryGetLinks,
  attach: _shareHistoryAttach,
  version: '3.1.0+1',
);

int _shareHistoryEstimateSize(
  ShareHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.method.length * 3;
  return bytesCount;
}

void _shareHistorySerialize(
  ShareHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.exchangeType.index);
  writer.writeDateTime(offsets[1], object.exchangedAt);
  writer.writeString(offsets[2], object.method);
}

ShareHistory _shareHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShareHistory();
  object.exchangeType = _ShareHistoryexchangeTypeValueEnumMap[
          reader.readByteOrNull(offsets[0])] ??
      ExchangeType.shared;
  object.exchangedAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.method = reader.readString(offsets[2]);
  return object;
}

P _shareHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ShareHistoryexchangeTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ExchangeType.shared) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ShareHistoryexchangeTypeEnumValueMap = {
  'shared': 0,
  'received': 1,
};
const _ShareHistoryexchangeTypeValueEnumMap = {
  0: ExchangeType.shared,
  1: ExchangeType.received,
};

Id _shareHistoryGetId(ShareHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shareHistoryGetLinks(ShareHistory object) {
  return [object.namecard];
}

void _shareHistoryAttach(
    IsarCollection<dynamic> col, Id id, ShareHistory object) {
  object.id = id;
  object.namecard.attach(col, col.isar.collection<Namecard>(), r'namecard', id);
}

extension ShareHistoryQueryWhereSort
    on QueryBuilder<ShareHistory, ShareHistory, QWhere> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShareHistoryQueryWhere
    on QueryBuilder<ShareHistory, ShareHistory, QWhereClause> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShareHistoryQueryFilter
    on QueryBuilder<ShareHistory, ShareHistory, QFilterCondition> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangeTypeEqualTo(ExchangeType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeType',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangeTypeGreaterThan(
    ExchangeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeType',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangeTypeLessThan(
    ExchangeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeType',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangeTypeBetween(
    ExchangeType lower,
    ExchangeType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      exchangedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> methodEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> methodBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'method',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'method',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> methodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'method',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'method',
        value: '',
      ));
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      methodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'method',
        value: '',
      ));
    });
  }
}

extension ShareHistoryQueryObject
    on QueryBuilder<ShareHistory, ShareHistory, QFilterCondition> {}

extension ShareHistoryQueryLinks
    on QueryBuilder<ShareHistory, ShareHistory, QFilterCondition> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition> namecard(
      FilterQuery<Namecard> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'namecard');
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterFilterCondition>
      namecardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'namecard', 0, true, 0, true);
    });
  }
}

extension ShareHistoryQuerySortBy
    on QueryBuilder<ShareHistory, ShareHistory, QSortBy> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> sortByExchangeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeType', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy>
      sortByExchangeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeType', Sort.desc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> sortByExchangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangedAt', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy>
      sortByExchangedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangedAt', Sort.desc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> sortByMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> sortByMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.desc);
    });
  }
}

extension ShareHistoryQuerySortThenBy
    on QueryBuilder<ShareHistory, ShareHistory, QSortThenBy> {
  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenByExchangeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeType', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy>
      thenByExchangeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeType', Sort.desc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenByExchangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangedAt', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy>
      thenByExchangedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangedAt', Sort.desc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenByMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.asc);
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QAfterSortBy> thenByMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'method', Sort.desc);
    });
  }
}

extension ShareHistoryQueryWhereDistinct
    on QueryBuilder<ShareHistory, ShareHistory, QDistinct> {
  QueryBuilder<ShareHistory, ShareHistory, QDistinct> distinctByExchangeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeType');
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QDistinct> distinctByExchangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangedAt');
    });
  }

  QueryBuilder<ShareHistory, ShareHistory, QDistinct> distinctByMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'method', caseSensitive: caseSensitive);
    });
  }
}

extension ShareHistoryQueryProperty
    on QueryBuilder<ShareHistory, ShareHistory, QQueryProperty> {
  QueryBuilder<ShareHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShareHistory, ExchangeType, QQueryOperations>
      exchangeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeType');
    });
  }

  QueryBuilder<ShareHistory, DateTime, QQueryOperations> exchangedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangedAt');
    });
  }

  QueryBuilder<ShareHistory, String, QQueryOperations> methodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'method');
    });
  }
}
