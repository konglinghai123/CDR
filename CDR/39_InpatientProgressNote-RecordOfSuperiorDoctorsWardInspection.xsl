<?xml version="1.0" encoding="UTF-8"?>
<!-- Created with Liquid Studio 2017 - Developer Bundle Edition (Trial) 15.1.4.7515 (https://www.liquid-technologies.com) -->
<xsl:stylesheet version="1.0" xmlns="urn:hl7-org:v3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:sdtc="urn:hl7-org:sdtc" xmlns:isc="http://extension-functions.intersystems.com" xmlns:exsl="http://exslt.org/common" xmlns:set="http://exslt.org/sets" exclude-result-prefixes="isc sdtc exsl set">
	<xsl:include href="CDA-Support-Files/Export/Common/OIDs-IOT.xsl"/>
	<xsl:include href="CDA-Support-Files/Export/Common/CDAHeader.xsl"/>
	<xsl:include href="CDA-Support-Files/Export/Common/PatientInformation.xsl"/>
	<xsl:include href="CDA-Support-Files/Export/Entry-Modules/ChiefComplaint.xsl"/>
	<xsl:include href="CDA-Support-Files/Export/Entry-Modules/TreatmentPlan.xsl"/>
	<xsl:include href="CDA-Support-Files/Export/Section-Modules/Diagnosis.xsl"/>
	<!--xsl:include href="CDA-Support-Files/Export/Section-Modules/Encounter.xsl"/-->
	<xsl:template match="/Document">
		<ClinicalDocument xmlns:mif="urn:hl7-org:v3/mif" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3">
			<xsl:apply-templates select="." mode="CDAHeader"/>
			
			<xsl:comment>病人信息</xsl:comment>
			<recordTarget contextControlCode="OP" typeCode="RCT">
				<patientRole classCode="PAT">
					<!-- 住院号标识 -->
					<xsl:apply-templates select="Encounter/Patient" mode="InpatientID"/>
					<patient classCode="PSN" determinerCode="INSTANCE">
						<!--患者身份证号-->
						<xsl:apply-templates select="Encounter/Patient" mode="IDNo"/>
						<xsl:apply-templates select="Encounter/Patient" mode="Name"/>
						<xsl:apply-templates select="Encounter/Patient" mode="Gender"/>
						<xsl:apply-templates select="Encounter/Patient" mode="BirthTime"/>
						<!--xsl:apply-templates select="Encounter/Patient" mode="Age"/-->
					</patient>
				</patientRole>
			</recordTarget>
			
			<!--以下省略很多机构签名等等 -->
			<relatedDocument typeCode="RPLC">
				<!--文档中医疗卫生事件的就诊场景,即入院场景记录-->
				<parentDocument>
					<id/>
					<setId/>
					<versionNumber/>
				</parentDocument>
			</relatedDocument>
			<!-- 病床号、病房、病区、科室和医院的关联 -->
			
			
			
			
			<!--文档体-->
		<component> 
    <structuredBody> 
      <!--
********************************************************
健康评估章节
********************************************************
-->  
      <component> 
        <section> 
          <code code="51848-0" displayName="Assessment note" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>  
          <text/>  
          <!--条目：查房记录-->  
          <entry> 
            <observation classCode="OBS" moodCode="EVN"> 
              <code code="DE06.00.181.00" displayName="查房记录" codeSystem="2.16.156.10011.2.2.1" codeSystemName="卫生信息数据元目录"/>  
              <value xsi:type="ST"><xsl:value-of select="HealthAssess/CheckR"/></value> 
            </observation> 
          </entry> 
        </section> 
      </component>  
      <!--
**************************************************
诊断记录章节
**************************************************
-->  
      <component> 
        <section> 
          <code code="29548-5" displayName="Diagnosis" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>  
          <text/>  
          <entry> 
            <observation classCode="OBS" moodCode="EVN"> 
              <code code="DE02.10.28.00" displayName="中医“四诊”结果" codeSystem="2.16.156.10011.2.2.1" codeSystemName="卫生信息数据元目录"/>  
              <value xsi:type="ST"><xsl:value-of select="Diagnosis/TCPsizhen"/></value> 
            </observation> 
          </entry> 
        </section> 
      </component>  
      <!--
**************************************************
用药章节
**************************************************
-->  
      <!--用药章节 1..*-->  
      <component> 
        <section> 
          <code code="10160-0" displayName="HISTORY OF MEDICATION USE" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>  
          <text/>  
          <!--中药煎煮法-->  
          <entry> 
            <observation classCode="OBS" moodCode="EVN "> 
              <code code="DE08.50.047.00" displayName="中药煎煮方法" codeSystem="2.16.156.10011.2.2.1" codeSystemName="卫生信息数据元目录"/>  
              <value xsi:type="ST"><xsl:value-of select="Medication/DecoctingMethod"/></value> 
            </observation> 
          </entry>  
          <!--中药用药方法-->  
          <entry> 
            <observation classCode="OBS" moodCode="EVN "> 
              <code code="DE06.00.136.00" displayName="中药用药方法" codeSystem="2.16.156.10011.2.2.1" codeSystemName="卫生信息数据元目录"/>  
              <value xsi:type="ST"><xsl:value-of select="Medication/MedicationMethod"/></value> 
            </observation> 
          </entry> 
        </section> 
      </component>  
      <!--
*************************************************
治疗计划章节
*************************************************
-->  
      <component> 
        <section> 
          <code code="18776-5" displayName="TREATMENT PLAN" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>  
          <text/>  
          <!--诊疗计划-->  
          <entry> 
            <observation classCode="OBS" moodCode="INT "> 
              <code code="DE05.01.025.00" displayName="诊疗计划"/>  
              <value xsi:type="ST"><xsl:value-of select="TreatmentPlan/zlPlan"/></value> 
            </observation> 
          </entry>  
          <!--辩证论治详细描述-->  
          <entry> 
            <observation classCode="OBS" moodCode="INT"> 
              <code code="DE05.10.131.00" displayName="辩证论治"/>  
              <value xsi:type="ST"><xsl:value-of select="TreatmentPlan/bzlz"/></value> 
            </observation> 
          </entry> 
        </section> 
      </component>  
      <!--
**********************************************
医嘱章节
**********************************************
-->  
      <component> 
        <section> 
          <code code="46209-3" codeSystem="2.16.840.1.113883.6.1" displayName="Provider Orders" codeSystemName="LOINC"/>  
          <text/>  
          <!--医嘱内容-->  
          <entry> 
            <observation classCode="OBS" moodCode="EVN"> 
              <code code="DE06.00.287.00" displayName="医嘱内容" codeSystem="2.16.156.10011.2.2.1" codeSystemName="卫生信息数据元目录"/>  
              <value xsi:type="ST"><xsl:value-of select="Order/zyOrder"/></value> 
            </observation> 
          </entry> 
        </section> 
      </component> 
    </structuredBody> 
  </component> 
  
  
			
		</ClinicalDocument>
	</xsl:template>
</xsl:stylesheet>
