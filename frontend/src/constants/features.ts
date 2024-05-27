// keep this consistent with backend constants.go
export enum FeatureKeys {
	SSO = 'SSO',
	ENTERPRISE_PLAN = 'ENTERPRISE_PLAN',
	BASIC_PLAN = 'BASIC_PLAN',
	ALERT_CHANNEL_SLACK = 'ALERT_CHANNEL_SLACK',
	ALERT_CHANNEL_WEBHOOK = 'ALERT_CHANNEL_WEBHOOK',
	ALERT_CHANNEL_PAGERDUTY = 'ALERT_CHANNEL_PAGERDUTY',
	ALERT_CHANNEL_OPSGENIE = 'ALERT_CHANNEL_OPSGENIE',
	ALERT_CHANNEL_MSTEAMS = 'ALERT_CHANNEL_MSTEAMS',
	DurationSort = 'DurationSort',
	TimestampSort = 'TimestampSort',
	SMART_TRACE_DETAIL = 'SMART_TRACE_DETAIL',
	CUSTOM_METRICS_FUNCTION = 'CUSTOM_METRICS_FUNCTION',
	QUERY_BUILDER_PANELS = 'QUERY_BUILDER_PANELS',
	QUERY_BUILDER_ALERTS = 'QUERY_BUILDER_ALERTS',
	DISABLE_UPSELL = 'DISABLE_UPSELL',
	USE_SPAN_METRICS = 'USE_SPAN_METRICS',
	OSS = 'OSS',
	ONBOARDING = 'ONBOARDING',
	CHAT_SUPPORT = 'CHAT_SUPPORT',
	PLANNED_MAINTENANCE = 'PLANNED_MAINTENANCE',
}
