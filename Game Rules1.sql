-- Insert SQL Rules Here 

			<Row Tag="TXT_KEY_VOLCAN_EVENT_TITLE">
				<Text>��ɽ������</Text>
			</Row>
			<Row Tag="TXT_KEY_VOLCANO_EVENT_1">
				<Text>һ����ɽ������С��ģ�緢��</Text>
			</Row>
			<Row Tag="TXT_KEY_VOLCANO_EVENT_2">
				<Text>һ����ɽ�����˴��ģ�緢��</Text>
			</Row>
			<Row Tag="TXT_KEY_VOLCANO_EVENT_3">
				<Text>һ����ɽ�����˳����ģ�緢��</Text>
			</Row>

INSERT INTO Project_YieldModifiers(ProjectType,YieldType, Yield)VALUES
('PROJECT_BLIALI', 'YIELD_SCIENCE',300);

INSERT INTO Project_YieldChanges(ProjectType,YieldType, Yield)VALUES
('PROJECT_BLIALI', 'YIELD_PRODUCTION',300);




	<Row Tag="TXT_KEY_KNOWLEDGE_5_HELP">
				<Text>[COLOR_POSITIVE_TEXT]�鱨����[ENDCOLOR][NEWLINE]���һ��[ICON_SPY]��������͵�Ƽ��ٶ�+50%��[ICON_SPY]���ÿ�غϿ�͵ȡ���ڳ���100%��[ICON_RESEARCH]���С����Ρ�������������+2[ICON_RESEARCH]���С�</Text>
			</Row>
		

-----------------------------------------------------------------------------------------------------
--Technologies
-----------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Technology_Health (TechType TEXT DEFAULT NULL, Yield INTEGER DEFAULT 0);

INSERT INTO Technology_Health (TechType,	Yield)
SELECT 'TECH_ANIMAL_HUSBANDRY',				-1 UNION ALL
SELECT 'TECH_THE_WHEEL',					-1 UNION ALL
SELECT 'TECH_SAILING',						-1 UNION ALL
SELECT 'TECH_IRON_WORKING',					-1 UNION ALL
SELECT 'TECH_OPTICS',						-1 UNION ALL
SELECT 'TECH_COMPASS',						-2 UNION ALL
SELECT 'TECH_ASTRONOMY',					-1 UNION ALL
SELECT 'TECH_NAVIGATION',					-2 UNION ALL
SELECT 'TECH_COMBUSTION',					-2 UNION ALL
SELECT 'TECH_FLIGHT',						-2 UNION ALL
SELECT 'TECH_GLOBALIZATION',				-3 UNION ALL
SELECT 'TECH_PRINTING_PRESS',				1 UNION ALL
SELECT 'TECH_ARCHITECTURE',					1 UNION ALL
SELECT 'TECH_EDUCATION',					1 UNION ALL
SELECT 'TECH_POTTERY',						1 UNION ALL
SELECT 'TECH_ENGINEERING',					1 UNION ALL
SELECT 'TECH_CHEMISTRY',					1 UNION ALL
SELECT 'TECH_SCIENTIFIC_THEORY',			1 UNION ALL
SELECT 'TECH_BIOLOGY',						1 UNION ALL
SELECT 'TECH_ELECTRICITY',					1 UNION ALL
SELECT 'TECH_REFRIGERATION',				1 UNION ALL
SELECT 'TECH_PENICILIN',					1 UNION ALL
SELECT 'TECH_ECOLOGY',						1 UNION ALL
SELECT 'TECH_SATELLITES',					1 UNION ALL
SELECT 'TECH_ROBOTICS',						1 UNION ALL
SELECT 'TECH_NANOTECHNOLOGY',				1;
