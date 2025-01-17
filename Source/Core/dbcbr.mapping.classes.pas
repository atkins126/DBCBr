{
      ORM Brasil � um ORM simples e descomplicado para quem utiliza Delphi

                   Copyright (c) 2016, Isaque Pinheiro
                          All rights reserved.

                    GNU Lesser General Public License
                      Vers�o 3, 29 de junho de 2007

       Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
       A todos � permitido copiar e distribuir c�pias deste documento de
       licen�a, mas mud�-lo n�o � permitido.

       Esta vers�o da GNU Lesser General Public License incorpora
       os termos e condi��es da vers�o 3 da GNU General Public License
       Licen�a, complementado pelas permiss�es adicionais listadas no
       arquivo LICENSE na pasta principal.
}

{ @abstract(ORMBr Framework.)
  @created(20 Jul 2016)
  @author(Isaque Pinheiro <isaquepsp@gmail.com>)
  @author(Skype : ispinheiro)
  @abstract(Website : http://www.ormbr.com.br)
  @abstract(Telagram : https://t.me/ormbr)
}

unit dbcbr.mapping.classes;

interface

uses
  DB,
  Classes,
  TypInfo,
  Rtti,
  SysUtils,
  Generics.Collections,
  dbcbr.mapping.attributes,
  dbcbr.types.mapping;

type
  TMappingDescription = class abstract
  protected
    FDescription: string;
  public
    property Description: string read FDescription write FDescription;
  end;

  /// TableMapping
  TTableMapping = class(TMappingDescription)
  private
    FName: string;
    FSchema: string;
  public
    property Name: string read FName write FName;
    property Schema: string read FSchema write FSchema;
  end;

  /// OrderByMapping
  TOrderByMapping = class
  private
    FColumnsName: string;
  public
    property ColumnsName: string read FColumnsName write FColumnsName;
  end;

  TSequenceMapping = class(TMappingDescription)
  private
    FTableName: string;
    FName: string;
    FInitial: Integer;
    FIncrement: Integer;
  public
    property TableName: string read FTableName write FTableName;
    property Name: string read FName write FName;
    property Initial: Integer read FInitial write FInitial;
    property Increment: Integer read FIncrement write FIncrement;
  end;

  /// TriggerMapping
  TTriggerMapping = class(TMappingDescription)
  private
    FName: string;
    FScript: string;
  public
    constructor Create(const AName, AScript: string);
    property Name: string read FName;
    property Script: string read FScript;
  end;
  // ColumnMappingList
  TTriggerMappingList = class(TObjectList<TTriggerMapping>);

  // ColumnMapping
  TColumnMapping = class(TMappingDescription)
  private
    FColumnName: string;
    FFieldType: TFieldType;
    FScale: Integer;
    FSize: Integer;
    FPrecision: Integer;
    FFieldIndex: Integer;
    FDefaultValue: string;
    FIsNoInsert: Boolean;
    FIsNotNull: Boolean;
    FIsCheck: Boolean;
    FIsUnique: Boolean;
    FIsJoinColumn: Boolean;
    FIsHidden: Boolean;
    FIsNoUpdate: Boolean;
    FIsPrimaryKey: Boolean;
    FIsNoValidate: Boolean;
    FIsNullable: Boolean;
    FIsLazy: Boolean;
    FIsVirtualData: Boolean;
    FProperty: TRttiProperty;
    FDictionary: Dictionary;
  public
    property FieldIndex: Integer read FFieldIndex write FFieldIndex;
    property ColumnName: string read FColumnName write FColumnName;
    property FieldType: TFieldType read FFieldType write FFieldType;
    property Scale: Integer read FScale write FScale;
    property Size: Integer read FSize write FSize;
    property Precision: Integer read FPrecision write FPrecision;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property IsNoInsert: Boolean read FIsNoInsert write FIsNoInsert;
    property IsNotNull: Boolean read FIsNotNull write FIsNotNull;
    property IsCheck: Boolean read FIsCheck write FIsCheck;
    property IsUnique: Boolean read FIsUnique write FIsUnique;
    property IsJoinColumn: Boolean read FIsJoinColumn write FIsJoinColumn;
    property IsNoUpdate: Boolean read FIsNoUpdate write FIsNoUpdate;
    property IsPrimaryKey: Boolean read FIsPrimaryKey write FIsPrimaryKey;
    property IsNoValidate: Boolean read FIsNoValidate write FIsNoValidate;
    property IsHidden: Boolean read FIsHidden write FIsHidden;
    property IsNullable: Boolean read FIsNullable write FIsNullable;
    property IsLazy: Boolean read FIsLazy write FIsLazy;
    property IsVirtualData: Boolean read FIsVirtualData write FIsVirtualData;
    property ColumnProperty: TRttiProperty read FProperty write FProperty;
    property ColumnDictionary: Dictionary read FDictionary write FDictionary;
  end;
  /// ColumnMappingList
  TColumnMappingList = class(TObjectList<TColumnMapping>);

  TCalcFieldMapping = class(TMappingDescription)
  private
    FFieldName: string;
    FFieldType: TFieldType;
    FSize: Integer;
    FProperty: TRttiProperty;
    FDictionary: Dictionary;
  public
    property FieldName: string read FFieldName write FFieldName;
    property FieldType: TFieldType read FFieldType write FFieldType;
    property Size: Integer read FSize write FSize;
    property CalcProperty: TRttiProperty read FProperty write FProperty;
    property CalcDictionary: Dictionary read FDictionary write FDictionary;
  end;
  /// ColumnMappingList
  TCalcFieldMappingList = class(TObjectList<TCalcFieldMapping>);

  /// AssociationMapping
  TAssociationMapping = class
  private
    FMultiplicity: TMultiplicity;
    FColumnsName: TList<string>;
    FColumnsNameRef: TList<string>;
    FClassNameRef: string;
    FLazy: Boolean;

    FProperty: TRttiProperty;
    FCascadeActions: TCascadeActions;
  public
    constructor Create(const AMultiplicity: TMultiplicity;
      const AColumnsName, AColumnsNameRef: TArray<string>;
      const AClassNameRef: string;
      const AProperty: TRttiProperty;
      const ALazy: Boolean;
      const ACascadeActions: TCascadeActions);
    destructor Destroy; override;
    property Multiplicity: TMultiplicity read FMultiplicity;
    property ColumnsName: TList<string> read FColumnsName;
    property ColumnsNameRef: TList<string> read FColumnsNameRef;
    property ClassNameRef: string read FClassNameRef;
    property Lazy: Boolean read FLazy;
    property PropertyRtti: TRttiProperty read FProperty;
    property CascadeActions: TCascadeActions read FCascadeActions;
  end;
  // AssociationMappingList
  TAssociationMappingList = class(TObjectList<TAssociationMapping>);

  // PrimaryKeyMapping
  TPrimaryKeyMapping = class(TMappingDescription)
  private
    FName: string;
    FColumns: TList<string>;
    FSortingOrder: TSortingOrder;
    FUnique: Boolean;
    FAutoIncrement: Boolean;
    FSequenceIncrement: Boolean;
    FTableIncrement: Boolean;
    FGuidIncrement: Boolean;
  public
    constructor Create(const AColumns: TArray<string>;
      const AAutoInc: Boolean;
      const ASequenceInc: Boolean;
      const ATableInc: Boolean;
      const AGuidInc: Boolean;
      const ASortingOrder: TSortingOrder;
      const AUnique: Boolean;
      const ADescription: string = '');
    destructor Destroy; override;
    property Name: string read FName;
    property Columns: TList<string> read FColumns;
    property SortingOrder: TSortingOrder read FSortingOrder;
    property Unique: Boolean read FUnique;
    property AutoIncrement: boolean read FAutoIncrement;
    property SequenceIncrement: boolean read FSequenceIncrement;
    property TableIncrement: boolean read FTableIncrement;
    property GuidIncrement: boolean read FGuidIncrement;
  end;

  // IndexeMapping
  TPrimaryKeyColumnsMapping = class(TMappingDescription)
  private
    FColumns: TList<TColumnMapping>;
  public
    constructor Create;
    destructor Destroy; override;
    property Columns: TList<TColumnMapping> read FColumns;
  end;

  // PrimaryKeyMapping
  TIndexeMapping = class(TPrimaryKeyMapping)
  public
    constructor Create(const AName: string; const AColumns: TArray<string>;
      const ASortingOrder: TSortingOrder;
      const AUnique: Boolean;
      const ADescription: string = '');
  end;
  // IndexeMappingList
  TIndexeMappingList = class(TObjectList<TIndexeMapping>);

  // CheckMapping
  TCheckMapping = class(TMappingDescription)
  private
    FName: string;
    FCondition: string;
  public
    constructor Create(const AName, ACondition, ADescription: string);
    property Name: string read FName;
    property Condition: string read FCondition;
  end;
  // CheckMappingList
  TCheckMappingList = class(TObjectList<TCheckMapping>);

  // RestrictionMapping
  TRestrictionMapping = class
  private
    FRestrictions: TRestrictions;
  public
    constructor Create(ARestrictions: TRestrictions);
    property Restrictions: TRestrictions read FRestrictions;
  end;
  // RestrictionMappingList
  TRestrictionMappingList = class(TObjectList<TRestrictionMapping>);

  // ForeignKeyKeyMapping
  TForeignKeyMapping = class(TMappingDescription)
  private
    FName: string;
    FTableNameRef: string;
    FFromColumns: TList<string>;
    FToColumns: TList<string>;
    FRuleUpdate: TRuleAction;
    FRuleDelete: TRuleAction;
  public
    constructor Create(const AName, ATableNameRef: string;
      const AFromColumns, AToColumns: TArray<string>;
      const ARuleDelete, ARuleUpdate: TRuleAction;
      const ADescription: string = '');
    destructor Destroy; override;
    property Name: string read FName;
    property TableNameRef: string read FTableNameRef;
    property FromColumns: TList<string> read FFromColumns;
    property ToColumns: TList<string> read FToColumns;
    property RuleDelete: TRuleAction read FRuleDelete;
    property RuleUpdate: TRuleAction read FRuleUpdate;
  end;
  // ForeignKeyMappingList
  TForeignKeyMappingList = class(TObjectList<TForeignKeyMapping>);

  // JoinColumnMapping
  TJoinColumnMapping = class
  private
    FColumnName: string;
    FRefTableName: string;
    FRefColumnName: string;
    FRefColumnNameSelect: string;
    FJoin: TJoin;
    FAliasColumn: string;
    FAliasRefTable: string;
  public
    constructor Create(const AColumnName, ARefTableName, ARefColumnName,
      ARefColumnNameSelect: string; const AJoin: TJoin;
      const AAliasColumn: string; const AAliasRefTable: string);
    property ColumnName: string read FColumnName;
    property RefColumnName: string read FRefColumnName;
    property RefTableName: string read FRefTableName;
    property RefColumnNameSelect: string read FRefColumnNameSelect;
    property Join: TJoin read FJoin;
    property AliasColumn: string read FAliasColumn;
    property AliasRefTable: string read FAliasRefTable;
  end;
  // JoinColumnMappingList
  TJoinColumnMappingList = class(TObjectList<TJoinColumnMapping>);

  TEnumerationMapping = class
  private
    FOrdinalType: TRttiOrdinalType;
    FEnumType: TEnumType;
    FEnumValues: TList<string>;
  public
    constructor Create(AOrdinalType: TRttiOrdinalType; AEnumType: TEnumType;
      AEnumValues: TList<Variant>);
    destructor Destroy; override;
    property OrdinalType: TRttiOrdinalType read FOrdinalType;
    property EnumType: TEnumType read FEnumType;
    property EnumValues: TList<string> read FEnumValues;
  end;
  // EnumerationMappingList
  TEnumerationMappingList = class(TObjectList<TEnumerationMapping>);

  // ViewMapping
  TViewMapping = class(TMappingDescription)
  private
    FName: string;
    FScript: string;
  public
    property Name: string read FName write FName;
    property Script: string read FScript write FScript;
  end;

  TFieldEventsMapping = class
  private
    FFieldName: String;
    FFieldEvents: TFieldEvents;
  public
    constructor Create(const AFieldName: String;
      const AFieldEvents: TFieldEvents);
    property FieldName: String read FFieldName;
    property Events: TFieldEvents read FFieldEvents;
  end;
  // FieldEventsMappingList
  TFieldEventsMappingList = class(TObjectList<TFieldEventsMapping>);

  TLazyMapping = class
  private
    FFieldLazy: TRttiField;
  public
    constructor Create(const AFieldLazy: TRttiField);
    property FieldLazy: TRttiField read FFieldLazy;
  end;

implementation

{ TOneToOneRelationMapping }

constructor TAssociationMapping.Create(const AMultiplicity: TMultiplicity;
  const AColumnsName, AColumnsNameRef: TArray<string>;
  const AClassNameRef: string;
  const AProperty: TRttiProperty;
  const ALazy: Boolean;
  const ACascadeActions: TCascadeActions);
var
  LFor: Integer;
begin
  FMultiplicity := AMultiplicity;
  FClassNameRef := AClassNameRef;
  FProperty := AProperty;
  FLazy := ALazy;
  FCascadeActions := ACascadeActions;
  // ColumnsName
  FColumnsName := TList<string>.Create;
  if Length(AColumnsName) > 0 then
  begin
    for LFor := Low(AColumnsName) to High(AColumnsName) do
      FColumnsName.Add(AColumnsName[LFor]);
  end;
  // ColumnsNameRef
  FColumnsNameRef := TList<string>.Create;
  if Length(AColumnsNameRef) > 0 then
  begin
    for LFor := Low(AColumnsNameRef) to High(AColumnsNameRef) do
      FColumnsNameRef.Add(AColumnsNameRef[LFor]);
  end;
end;

destructor TAssociationMapping.Destroy;
begin
  FColumnsName.Free;
  FColumnsNameRef.Free;
  inherited;
end;

{ TPrimaryKeyMapping }

constructor TPrimaryKeyMapping.Create(const AColumns: TArray<string>;
  const AAutoInc: Boolean;
  const ASequenceInc: Boolean;
  const ATableInc: Boolean;
  const AGuidInc: Boolean;
  const ASortingOrder: TSortingOrder;
  const AUnique: Boolean;
  const ADescription: string);
var
  iFor: Integer;
begin
  FName := 'PK_';
  FColumns := TList<string>.Create;
  FSortingOrder := ASortingOrder;
  FUnique := AUnique;
  FAutoIncrement := AAutoInc;
  FSequenceIncrement := ASequenceInc;
  FTableIncrement := ATableInc;
  FGuidIncrement := AGuidInc;
  FDescription := ADescription;
  if Length(AColumns) > 0 then
  begin
    for iFor := Low(AColumns) to High(AColumns) do
      FColumns.Add(Trim(AColumns[iFor]));
  end;
end;

destructor TPrimaryKeyMapping.Destroy;
begin
  FColumns.Free;
  inherited;
end;

{ TIndexMapping }

constructor TIndexeMapping.Create(const AName: string;
  const AColumns: TArray<string>;
  const ASortingOrder: TSortingOrder;
  const AUnique: Boolean;
  const ADescription: string);
var
  iFor: Integer;
begin
  FColumns := TList<string>.Create;
  FName := AName;
  FSortingOrder := ASortingOrder;
  FUnique := AUnique;
  FDescription := ADescription;
  if Length(AColumns) > 0 then
  begin
    for iFor := Low(AColumns) to High(AColumns) do
      FColumns.Add(Trim(AColumns[iFor]));
  end;
end;

{ TJoinColumnMapping }

constructor TJoinColumnMapping.Create(const AColumnName, ARefTableName,
  ARefColumnName, ARefColumnNameSelect: string; const AJoin: TJoin;
  const AAliasColumn: string; const AAliasRefTable: string);
begin
  FColumnName := AColumnName;
  FRefTableName := ARefTableName;
  FRefColumnName := ARefColumnName;
  FRefColumnNameSelect := ARefColumnNameSelect;
  FJoin := AJoin;
  FAliasColumn := AAliasColumn;
  FAliasRefTable := AAliasRefTable;
end;

{ TForeignKeyMapping }

constructor TForeignKeyMapping.Create(const AName, ATableNameRef: string;
  const AFromColumns, AToColumns: TArray<string>;
  const ARuleDelete, ARuleUpdate: TRuleAction; const ADescription: string);
var
  iFor: Integer;
begin
  if Length(AName) = 0 then
    FName := Format('FK_%s_%s', [ATableNameRef, AFromColumns[0]])
  else
    FName := AName;
  FTableNameRef := ATableNameRef;
  FRuleDelete := ARuleDelete;
  FRuleUpdate := ARuleUpdate;
  FDescription := ADescription;
  // FromColumns
  FFromColumns := TList<string>.Create;
  if Length(AFromColumns) > 0 then
  begin
    for iFor := Low(AFromColumns) to High(AFromColumns) do
      FFromColumns.Add(Trim(AFromColumns[iFor]));
  end;
  // ToColumns
  FToColumns := TList<string>.Create;
  if Length(AToColumns) > 0 then
  begin
    for iFor := Low(AToColumns) to High(AToColumns) do
      FToColumns.Add(Trim(AToColumns[iFor]));
  end;
end;

destructor TForeignKeyMapping.Destroy;
begin
  FFromColumns.Free;
  FToColumns.Free;
  inherited;
end;

{ TTriggerMapping }

constructor TTriggerMapping.Create(const AName, AScript: string);
begin
  FName := AName;
  FScript := AScript;
end;

{ TCheckMapping }

constructor TCheckMapping.Create(const AName, ACondition, ADescription: string);
begin
  FName := AName;
  FCondition := ACondition;
  FDescription := ADescription;
end;

{ TRestrictionMapping }

constructor TRestrictionMapping.Create(ARestrictions: TRestrictions);
begin
  FRestrictions := ARestrictions;
end;

{ TEnumeration }

constructor TEnumerationMapping.Create(AOrdinalType: TRttiOrdinalType;
  AEnumType: TEnumType; AEnumValues: TList<Variant>);
var
  iFor: Integer;
begin
  // EnumValues
  FOrdinalType := AOrdinalType;
  FEnumType := AEnumType;
  FEnumValues := TList<string>.Create;
  if AEnumValues.Count > 0 then
  begin
    for iFor := 0 to AEnumValues.Count -1 do
      FEnumValues.Add(Trim(AEnumValues[iFor]));
  end;
end;

destructor TEnumerationMapping.Destroy;
begin
  FEnumValues.Free;
  inherited;
end;

{ TFieldEvents }

constructor TFieldEventsMapping.Create(const AFieldName: String;
  const AFieldEvents: TFieldEvents);
begin
  FFieldName := AFieldName;
  FFieldEvents := AFieldEvents;
end;

{ TPrimaryKeyColumnsMapping }

constructor TPrimaryKeyColumnsMapping.Create;
begin
  FColumns := TList<TColumnMapping>.Create;
end;

destructor TPrimaryKeyColumnsMapping.Destroy;
begin
  FColumns.Free;
  inherited;
end;

{ TLazyMapping }

constructor TLazyMapping.Create(const AFieldLazy: TRttiField);
begin
  FFieldLazy := AFieldLazy;
end;

end.
