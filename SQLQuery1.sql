/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  *
  FROM [CDWWork].[Dim].[ICD10]
  where sta3n = 580 and (ICD10Code like 'c88%' or ICD10Code like 'c90%')
  -- c88 is waldenstrom, really c88.0
  --icd10sid 1001480161

SELECT TOP (10) 
Sta3n
--[InpatientSID]
--      ,[PTFIEN]
--      ,[Sta3n]
--      ,[PatientSID]
--      ,[MeansTestIndicator]
      ,[AdmitDateTime]
      --,[AdmitVistaErrorDate]
      --,[AdmitDateTimeTransformSID]
      --,[AdmitDateSID]
      --,[AdmitSourceSID]
      --,[AdmitEligibilitySID]
      --,[TransferFromFacility]
      --,[TransferFromFacilitySuffix]
      --,[SourceOfPayment]
      --,[SuicideSelfInflict]
      --,[PsychSeverity]
      --,[PsychFunctional]
      --,[PsychHighLevel]
      --,[TransmissionStatus]
      --,[DischargeFromFacility]
      --,[DischargeFromFacilitySuffix]
      ,[DischargeDateTime]
      --,[DischargeVistaErrorDate]
      --,[DischargeDateTimeTransformSID]
      --,[DischargeDateSID]
      --,[DischargeStatus]
      --,[OutpatientReferralFlag]
      --,[DispositionType]
      --,[PlaceOfDispositionSID]
      --,[TransferToFacility]
      --,[TransferToFacilitySuffix]
      --,[ASIHDays]
      --,[CPStatus]
      --,[AbusedSubstanceSID]
      ,[PrincipalDiagnosisICD9SID]
      ,[PrincipalDiagnosisICD10SID]
      ,[PrincipalDiagnosisPOAIndicator]
      ,[AdmitMASMovementTypeSID]
      --,[AdmitFacilityMovementTypeSID]
      --,[AdmitFromInstitutionSID]
      --,[AdmitWardLocationSID]
      --,[AdmitRoomBedSID]
      ,[AdmitDiagnosis]
      --,[AdmitForServiceConnectedFlag]
      --,[AdmitRegulationSID]
      --,[AdmitASIHSequence]
      --,[ScheduledAdmissionFlag]
      --,[AdmitEnteredByStaffSID]
      --,[AdmitEnteredOnDateTime]
      --,[AdmitLastEditedByStaffSID]
      --,[AdmitLastEditedOnDateTime]
      --,[DischargeMASMovementTypeSID]
      --,[DischargeFacilityMovementTypeSID]
      --,[DischargeToInstitutionSID]
      --,[DischargeAttendingPhysicianSID]
      --,[DischargeASIHSequence]
      --,[DischargeEnteredByStaffSID]
      --,[DischargeEnteredOnDateTime]
      --,[DischargeLastEditedByStaffSID]
      --,[DischargeLastEditedOnDateTime]
      --,[SpecialtyCDR]
      --,[TransmitFlag]
      --,[DischargeFromSpecialtySID]
      --,[DischargeFromService]
      --,[DischargeDRGSID]
      ,[LOSInService]
      ,[LOSCumulative]
      --,[ProviderSID]
      --,[DischargeSuicideSelfInflict]
      --,[DischargePsychSeverity]
      --,[DischargePsychFunctional]
      --,[DischargePsychHighLevel]
      --,[LeaveDays]
      --,[DischargeAbusedSubstanceSID]
      --,[PassDays]
      ,[AgentOrangeFlag]
      ,[CombatFlag]
      ,[HeadNeckCancerFlag]
      ,[IonizingRadiationFlag]
      ,[LegionnairesDiseaseFlag]
      ,[MilitarySexualTraumaFlag]
      ,[ServiceConnectedFlag]
      ,[SHADFlag]
      ,[SWAsiaConditionsFlag]
      --,[FirstClosedOutDateTime]
      --,[FirstClosedOutVistaErrorDate]
      --,[FirstClosedOutDateTimeTransformSID]
      --,[DischargeWardLocationSID]
      --,[DischargeWardCDR]
      --,[DischargeSpecialtySID]
      --,[Discharge45WardLocationSID]
      --,[Discharge45SpecialtySID]
  FROM [CDWWork].[Inpat].[Inpatient]
  where PrincipalDiagnosisICD10SID = 1001480161


select top 10 
ICD10SID, EventDateTime, VisitDateTime, VDiagnosisDateTime, AgentOrangeFlag, IonizingRadiationFlag, HeadNeckCancerFlag, CombatFlag, ShipboardHazardDefenseFlag

from Outpat.VDiagnosisg
where ICD10SID = 1001480161



select top 100 *
from CDWWork.dim.LabChemTest
where sta3n = 580 and (LabChemTestName like '%kappa%'
or LabChemTestName like '%lambda%')

select top 10 * from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like '%loinc%'
