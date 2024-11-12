public class APIDataWrapper {
    
	public CaseInformation CaseInformation {get;set;}
    
    public class CaseInformation {
		public String CaseID {get;set;} 
		public String CaseNumber {get;set;} 
		public CaseActivities CaseActivities {get;set;} 
		public String CreatedDateTime {get;set;}
	}
    
    public class CaseActivities {
		public String CaseTypeCode {get;set;} 
		public String CaseType {get;set;} 
		public String CaseTitle {get;set;} 
		public String FiledDate {get;set;} 
		public String NodeID {get;set;} 
		public String CourtName {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public CaseStatus CaseStatus {get;set;}
        //Additonal params
        public List<CaseFlags> CaseFlags {get;set;} 
		public CaseFlagsSingle CaseFlagsSingle {get;set;}        
        public List<CaseCrossReferences> CaseCrossReferences {get;set;}
        public CaseCrossReferencesSingle CaseCrossReferencesSingle {get;set;}
        public PartiesSingle PartiesSingle {get;set;}
        public List<Parties> Parties {get;set;}
        public List<CaseParties> CaseParties {get;set;} 
        public CasePartiesSingle CasePartiesSingle {get;set;}
        public List<Charges> Charges {get;set;}
        public ChargesSingle ChargesSingle {get;set;}
        public List<CaseEvents> CaseEvents {get;set;}
        public CaseEventsSingle CaseEventsSingle {get;set;}
        public List<Hearings> Hearings {get;set;} 
        public HearingsSingle HearingsSingle {get;set;}
        public List<Pleas> Pleas {get;set;}
        public PleasSingle PleasSingle {get;set;}
        public List<BondSettings> BondSettings {get;set;}
        public BondSettingsSingle BondSettingsSingle {get;set;}
        public List<StatisticalClosures> StatisticalClosures {get;set;}
        public StatisticalClosuresSingle StatisticalClosuresSingle {get;set;}
        public List<Dispositions> Dispositions {get;set;} 
        public DispositionsSingle DispositionsSingle {get;set;}
        public List<SentenceEvents> SentenceEvents {get;set;}
        public SentenceEventsSingle SentenceEventsSingle {get;set;}
	}
    
    public class CaseFlags {
		public String FlagCode {get;set;} 
		public String FlagDescription {get;set;} 
	}
    
    public class CaseFlagsSingle {
		public CaseFlag CaseFlag {get;set;}        
	}
    
    public class CaseFlag {
		public String FlagCode {get;set;} 
		public String FlagDescription {get;set;}
	}
    
    public class CaseCrossReferencesSingle {
		public String CaseCrossReference {get;set;}
	}
    
	public class CaseCrossReferences {
		public String CaseCrossReferenceTypeCode {get;set;} 
		public String CaseCrossReferenceType {get;set;} 
		public String CrossCaseNumber {get;set;}
	}
    
    public class CaseCrossReference {
		public String CaseCrossReferenceTypeCode {get;set;} 
		public String CaseCrossReferenceType {get;set;} 
		public String CrossCaseNumber {get;set;}
	}
    
    public class PartiesSingle {
		public Party Party {get;set;}
	}
    
    public class Party {
		public String PartyID {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String NameTypeKey {get;set;} 
		public String NameTypeDesc {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMiddle {get;set;} 
		public String NameLast {get;set;} 
		public List<AKAs> AKAs {get;set;}
        public AKAsSingle AKAsSingle {get;set;}
		public String DateOfBirth {get;set;} 
		public String SONumber {get;set;} 
		public String HeightFeet {get;set;} 
		public String HeightInches {get;set;} 
		public String WeightPounds {get;set;} 
		public Gender Gender {get;set;} 
		public Race Race {get;set;} 
		public EyeColor EyeColor {get;set;} 
		public HairColor HairColor {get;set;} 
		public Address Address {get;set;} 
		public StateID StateID {get;set;} 
		public DriversLicense DriversLicense {get;set;} 
		public List<Vehicles> Vehicles {get;set;}
        public VehiclesSingle VehiclesSingle {get;set;}
	}
    
    public class Parties {
		public String PartyID {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String NameTypeKey {get;set;} 
		public String NameTypeDesc {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMiddle {get;set;} 
		public String NameLast {get;set;} 
		public List<AKAs> AKAs {get;set;}
        public AKAsSingle AKAsSingle {get;set;} 
		public String DateOfBirth {get;set;} 
		public String SONumber {get;set;} 
		public String HeightFeet {get;set;} 
		public String HeightInches {get;set;} 
		public String WeightPounds {get;set;} 
		public Gender Gender {get;set;} 
		public Race Race {get;set;} 
		public EyeColor EyeColor {get;set;} 
		public HairColor HairColor {get;set;} 
		public Address Address {get;set;} 
		public StateID StateID {get;set;} 
		public DriversLicense DriversLicense {get;set;} 
		public List<Vehicles> Vehicles {get;set;}
        public VehiclesSingle VehiclesSingle {get;set;}
	}
    public class CasePartiesSingle {
    	public CaseParty CaseParty {get;set;} 
    }
    public class CaseParty {
		public String PartyID {get;set;} 
		public String PartyNameFormatted {get;set;} 
		public String NameLast {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public CasePartyAttorney CasePartyAttorney {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMid {get;set;}
	}
    
    public class CaseParties {
		public String PartyID {get;set;} 
		public String PartyNameFormatted {get;set;} 
		public String NameLast {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public CasePartyAttorney CasePartyAttorney {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMid {get;set;}
	}
    public class ChargesSingle {
    	public Charge Charge {get;set;}
    }
    public class Charge {
		public String ChargeID {get;set;} 
		public String ChargeOffenseDate {get;set;} 
		public String ChargeFiledDate {get;set;} 
		public ArrestingAgency ArrestingAgency {get;set;} 
		public BookingAgency BookingAgency {get;set;} 
		public List<ChargeStages> ChargeStages {get;set;}
        public ChargeStagesSingle ChargeStagesSingle {get;set;}
	}
    public class Charges {
		public String ChargeID {get;set;} 
		public String ChargeOffenseDate {get;set;} 
		public String ChargeFiledDate {get;set;} 
		public ArrestingAgency ArrestingAgency {get;set;} 
		public BookingAgency BookingAgency {get;set;} 
		public List<ChargeStages> ChargeStages {get;set;}
        public ChargeStagesSingle ChargeStagesSingle {get;set;}
	}
    public class CaseEventsSingle {
		public CaseEvent CaseEvent {get;set;} 
	}
    public class CaseEvents {
		public String EventID {get;set;} 
		public String EventDate {get;set;} 
		public String EventCode {get;set;} 
		public String EventType {get;set;} 
		public String Comment {get;set;}
	}
    public class CaseEvent {
		public String EventID {get;set;} 
		public String EventDate {get;set;} 
		public String EventCode {get;set;} 
		public String EventType {get;set;} 
		public String Comment {get;set;}
	}
    
    public class HearingsSingle {
		public Hearing Hearing {get;set;}
	}
     public class Hearing {
		public String HearingID {get;set;} 
		public String HearingTypeCode {get;set;} 
		public String HearingType {get;set;} 
		public List<Settings> Settings {get;set;}
        public SettingsSingle SettingsSingle {get;set;}
	}
    public class Hearings {
		public String HearingID {get;set;} 
		public String HearingTypeCode {get;set;} 
		public String HearingType {get;set;} 
		public List<Settings> Settings {get;set;}
        public SettingsSingle SettingsSingle {get;set;}
	}
    public class PleasSingle {
		public Plea Plea {get;set;}
	}
    public class Plea {
		public String PleaID {get;set;} 
		public String PleaEventDate {get;set;} 
		public String ChargeID {get;set;} 
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String PleaTypeCode {get;set;} 
		public String PleaType {get;set;}
	}
    public class Pleas {
		public String PleaID {get;set;} 
		public String PleaEventDate {get;set;} 
		public String ChargeID {get;set;} 
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String PleaTypeCode {get;set;} 
		public String PleaType {get;set;}
	}
    public class BondSettingsSingle {
		public BondSetting BondSetting {get;set;}
	}
    public class BondSetting {
		public String BondSettingID {get;set;} 
		public String PartyID {get;set;} 
		public String SettingGroupType {get;set;} 
		public String SettingDate {get;set;} 
		public String BondSettingTypeCode {get;set;} 
		public String BondSettingType {get;set;} 
	}
    public class BondSettings {
		public String BondSettingID {get;set;} 
		public String PartyID {get;set;} 
		public String SettingGroupType {get;set;} 
		public String SettingDate {get;set;} 
		public String BondSettingTypeCode {get;set;} 
		public String BondSettingType {get;set;} 
	}
    public class StatisticalClosuresSingle {
		public StatisticalClosure StatisticalClosure {get;set;} 
	}
    public class StatisticalClosure {
		public String DispositionID {get;set;} 
		public String StatisticalClosureTypeCode {get;set;} 
		public String StatisticalClosureType {get;set;} 
		public String DateF {get;set;} // in json: Date
	}
    public class StatisticalClosures {
		public String DispositionID {get;set;} 
		public String StatisticalClosureTypeCode {get;set;} 
		public String StatisticalClosureType {get;set;} 
		public String DateF {get;set;} // in json: Date
	}
	public class DispositionsSingle {
		public Disposition Disposition {get;set;}
	}
    public class Disposition {
		public String DispositionID {get;set;} 
		public String DispositionEventDate {get;set;} 
		public String ChargeID {get;set;} 
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String DispositionTypeCode {get;set;} 
		public String DispositionType {get;set;}
	}
    public class Dispositions {
		public String DispositionID {get;set;} 
		public String DispositionEventDate {get;set;} 
		public String ChargeID {get;set;} 
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String DispositionTypeCode {get;set;} 
		public String DispositionType {get;set;}
	}
	public class SentenceEventsSingle {
		public SentenceEvent SentenceEvent {get;set;}
	}
    public class SentenceEvent {
		public String SentenceEventID {get;set;} 
		public String SentenceTypeCode {get;set;} 
		public String SentenceType {get;set;} 
		public String SentenceDate {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public Sentence Sentence {get;set;}		
	}
    public class SentenceEvents {
		public String SentenceEventID {get;set;} 
		public String SentenceTypeCode {get;set;} 
		public String SentenceType {get;set;} 
		public String SentenceDate {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public Sentence Sentence {get;set;}		
	}    
    public class SentenceCharge {
		public String ChargeID {get;set;} 
		public String ChargeNumber {get;set;}
	}
	
	public class Address {
		public String AddressLine1 {get;set;} 
		public String City {get;set;} 
		public String State {get;set;} 
		public String Zip {get;set;} 
		public String IsCurrent {get;set;} 
		public String IsCorrespondence {get;set;}		
	}
	
	public class Gender {
		public String GenderCode {get;set;} 
		public String GenderDescription {get;set;}		
	}
	
	public class CAProbationComponent {
		public String DispositionComponentInstanceID {get;set;} 
		public String TypeCode {get;set;} 
		public String TypeDescription {get;set;} 
		public TermDuration TermDuration {get;set;} 
		public String ExcludeTollingDays {get;set;} 
		public String ImpositionOfSentenceSuspended {get;set;} 
		public ProbationStatuses ProbationStatuses {get;set;} 
		public List<ProbationConditions> ProbationConditions {get;set;}
        public ProbationConditionsSingle ProbationConditionsSingle {get;set;}
	}
    
    public class ProbationConditionsSingle {
		public ProbationCondition ProbationCondition {get;set;}
	}
	public class ProbationCondition {
		public String ConditionID {get;set;} 
		public String ConditionTypeCode {get;set;} 
		public String ConditionType {get;set;} 
		public String EffectiveDateStart {get;set;} 
		public Status Status {get;set;} 
		public String Comment {get;set;} 
	}
    public class ProbationConditions {
		public String ConditionID {get;set;} 
		public String ConditionTypeCode {get;set;} 
		public String ConditionType {get;set;} 
		public String EffectiveDateStart {get;set;} 
		public Status Status {get;set;} 
		public String Comment {get;set;} 
	}
	public class EyeColor {
		public String EyeColorCode {get;set;} 
		public String EyeColorDescription {get;set;}		
	}
	
	public class Sentence {
		public String SentenceID {get;set;} 
		public SentenceCharge SentenceCharge {get;set;} 
		public Details Details {get;set;} 		
	}
	public class Status {
		public String StatusCode {get;set;} 
		public String StatusType {get;set;} 
		public String StatusDate {get;set;}
	}
    
	public class ArrestingAgency {
		public String ArrestDate {get;set;} 
		public String AgencyCode {get;set;} 
		public String Agency {get;set;} 
		public String ORI {get;set;} 
		public String ControlNumber {get;set;}
	}
    
	public class CACommentComponent {
		public String DispositionComponentInstanceID {get;set;} 
		public String Comment {get;set;}
	}	
    public class PresentParty {
        public String PartyID {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String PartyNameFormatted {get;set;} 
		public String NameLast {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMid {get;set;} 
    }
    
    public class PresentParties {
        public String PartyID {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String PartyNameFormatted {get;set;} 
		public String NameLast {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMid {get;set;}
    }
    public class PresentPartiesSingle {
        PresentParty PresentParty {get;set;}
    }
	public class CasePartyAttorney {
		public String PartyID {get;set;} 
		public String LeadAttorney {get;set;} 
		public String BarNum {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String NameFirst {get;set;} 
		public String NameMiddle {get;set;} 
		public String NameLast {get;set;}
	}
	public class Details {
		public CAConfinementComponent CAConfinementComponent {get;set;} 
		public CAProbationComponent CAProbationComponent {get;set;} 
		public CACommentComponent CACommentComponent {get;set;}
	}
	
	public class CaseStatus {
		public String CaseStatusCode {get;set;} 
		public String CaseStatusType {get;set;} 
		public String DateF {get;set;} // in json: Date
	}
	public class TermDuration {
		public String Days {get;set;}
	}
	
	
	/*
	public class CasePartyAttorney_Z {
		public String PartyID {get;set;} 
		public String LeadAttorney {get;set;} 
		public String BarNum {get;set;} 
		public String ConnectionCode {get;set;} 
		public String Connection {get;set;} 
		public String NameFirst {get;set;} 
		public String NameLast {get;set;}		
	}
	public class Settings_Z {
		public Setting_Z Setting {get;set;}		
	}	
	public class Settings_Y {
		public Setting_Y Setting {get;set;}		
	}	
	public class Setting_Y {
		public String SettingID {get;set;} 
		public String HearingDate {get;set;} 
		public String StartTime {get;set;} 
		public String DepartmentCode {get;set;} 
		public String Department {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public String HearingResultCode {get;set;} 
		public String HearingResult {get;set;} 
		public List<SettingResources> SettingResources {get;set;} 
		public PresentParties PresentParties {get;set;}		
	}	
	public class Setting_Z {
		public String SettingID {get;set;} 
		public String HearingDate {get;set;} 
		public String StartTime {get;set;} 
		public String DepartmentCode {get;set;} 
		public String Department {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public String HearingResultCode {get;set;} 
		public String HearingResult {get;set;} 
		public List<SettingResources> SettingResources {get;set;} 
        public List<PresentParties> PresentParties {get;set;}		
	}
	*/
	
	
	public class Race {
		public String RaceCode {get;set;} 
		public String RaceDescription {get;set;} 
	}
	
	public class ProbationStatuses {
		public ProbationStatus ProbationStatus {get;set;}
	}
	public class DriversLicense {
		public String DriversLicenseNumber {get;set;} 
		public String DriversLicenseStateCode {get;set;} 
		public String DriversLicenseState {get;set;}
	}
	
	public class ProbationStatus {
		public String ProbationStatusCollectionID {get;set;} 
		public String ProbationStatusCode {get;set;} 
		public String ProbationStatus {get;set;} 
		public String ProbationStatusDate {get;set;}
	}
	
	public class AKAsSingle {
		public AKA AKA {get;set;}
	}
    public class AKA {
		public String NameLast {get;set;} 
		public String NameTypeKey {get;set;} 
		public String NameTypeDesc {get;set;} 
		public String CasePartyNameTypeKey {get;set;} 
		public String CasePartyNameTypeDesc {get;set;} 
	}
    public class AKAs {
		public String NameLast {get;set;} 
		public String NameTypeKey {get;set;} 
		public String NameTypeDesc {get;set;} 
		public String CasePartyNameTypeKey {get;set;} 
		public String CasePartyNameTypeDesc {get;set;}
	}
	
	public class StateID {
		public String StateIDNumber {get;set;} 
		public String StateIDCode {get;set;} 
		public String StateIDState {get;set;}
	}
    
	/*
	public class PresentParties_Z {
		public PresentParties PresentParty {get;set;}
	}*/
	
	public class HairColor {
		public String HairColorCode {get;set;} 
		public String HairColorDescription {get;set;} 
	}
	public class CAConfinementComponent {
		public String DispositionComponentInstanceID {get;set;} 
		public String TypeCode {get;set;} 
		public String Type {get;set;} 
		public String FacilityCode {get;set;} 
		public String Facility {get;set;} 
		public String TermTypeCode {get;set;} 
		public String TermTypeDescription {get;set;} 
		public TermDuration TermDuration {get;set;} 
		public TermDuration CreditForTimeServedDuration {get;set;} 
		public TermDuration ConductCreditDuration {get;set;}
	}
	public class BookingAgency {
		public String ControlNumber {get;set;} 
	}
    public class SettingsSingle {
		public Setting Setting {get;set;}
	}
	public class Setting {
		public String SettingID {get;set;} 
		public String HearingDate {get;set;} 
		public String StartTime {get;set;} 
		public String DepartmentCode {get;set;} 
		public String Department {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public String HearingResultCode {get;set;} 
		public String HearingResult {get;set;} 
        public PresentPartiesSingle PresentPartiesSingle {get;set;}
        public List<PresentParties> PresentParties {get;set;}
		public List<SettingResources> SettingResources {get;set;}
        public SettingResourcesSingle SettingResourcesSingle {get;set;}
	}    
	public class Settings {
		public String SettingID {get;set;} 
		public String HearingDate {get;set;} 
		public String StartTime {get;set;} 
		public String DepartmentCode {get;set;} 
		public String Department {get;set;} 
		public String JudicialOfficerCode {get;set;} 
		public String JudicialOfficer {get;set;} 
		public String HearingResultCode {get;set;} 
		public String HearingResult {get;set;} 
        public PresentPartiesSingle PresentPartiesSingle {get;set;}
        public List<PresentParties> PresentParties {get;set;}
		public List<SettingResources> SettingResources {get;set;}
        public SettingResourcesSingle SettingResourcesSingle {get;set;}
	}
    public class SettingResourcesSingle {
		public SettingResource SettingResource {get;set;} 
	}
    public class SettingResource {
		public String ResourceType {get;set;} 
		public String ResourceCode {get;set;} 
		public String Resource {get;set;}
	} 
	public class SettingResources {
		public String ResourceType {get;set;} 
		public String ResourceCode {get;set;} 
		public String Resource {get;set;}
	}
    public class ChargeStagesSingle {
        public ChargeStage ChargeStage {get;set;} 
    }
    public class ChargeStage {
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String OffenseStageID {get;set;} 
		public String OffenseStage {get;set;} 
		public String JurisdictionCode {get;set;} 
		public String Jurisdiction {get;set;} 
		public String StatuteNumber {get;set;} 
		public String StatuteCode {get;set;} 
		public String StatuteDescription {get;set;} 
		public String StatuteDegreeCode {get;set;} 
		public String StatuteDegree {get;set;} 
		public String LiteralID {get;set;} 
		public String Deleted {get;set;}		
	}
    public class ChargeStages {
		public String ChargeNumber {get;set;} 
		public String OffenseHistoryID {get;set;} 
		public String OffenseStageID {get;set;} 
		public String OffenseStage {get;set;} 
		public String JurisdictionCode {get;set;} 
		public String Jurisdiction {get;set;} 
		public String StatuteNumber {get;set;} 
		public String StatuteCode {get;set;} 
		public String StatuteDescription {get;set;} 
		public String StatuteDegreeCode {get;set;} 
		public String StatuteDegree {get;set;} 
		public String LiteralID {get;set;} 
		public String Deleted {get;set;}
	}	
    public class VehiclesSingle {
		public Vehicle Vehicle {get;set;}		
	}
	public class Vehicle {
		public String PlateNumber {get;set;} 
		public String PlateStateCode {get;set;} 
		public String PlateState {get;set;} 
		public String Commercial {get;set;} 
		public String HazMaterials {get;set;} 
		public String Inactive {get;set;}
	}
	public class Vehicles {
		public String PlateNumber {get;set;} 
		public String PlateStateCode {get;set;} 
		public String PlateState {get;set;} 
		public String Commercial {get;set;} 
		public String HazMaterials {get;set;} 
		public String Inactive {get;set;}
	}
	public static APIDataWrapper parse(String json) {
		return (APIDataWrapper) System.JSON.deserialize(json, APIDataWrapper.class);
    }
}