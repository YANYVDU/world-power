--==========================================================================================================================
-- NOTIFICATIONS
--==========================================================================================================================	
-- Notifications
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Notifications (NotificationType)
SELECT 'NOTIFICATION_INSTANT_YIELD' UNION ALL	
SELECT	'NOTIFICATION_PLAGUE';
--==========================================================================================================================
--==========================================================================================================================