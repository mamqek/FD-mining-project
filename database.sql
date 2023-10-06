-- public.ar_internal_metadata definition

-- Drop table

-- DROP TABLE public.ar_internal_metadata;

CREATE TABLE public.ar_internal_metadata (
	"key" varchar NOT NULL,
	value varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY ("key")
);


-- public.audit_logs definition

-- Drop table

-- DROP TABLE public.audit_logs;

CREATE TABLE public.audit_logs (
	id bigserial NOT NULL,
	"event" varchar NULL,
	actor_type int4 NULL,
	actor_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	entity_id int4 NULL,
	CONSTRAINT audit_logs_pkey PRIMARY KEY (id)
);


-- public.audit_records definition

-- Drop table

-- DROP TABLE public.audit_records;

CREATE TABLE public.audit_records (
	id serial4 NOT NULL,
	creation_date timestamp NULL,
	creator varchar NULL,
	table_name varchar NULL,
	operation varchar NULL,
	payload json NULL,
	previous_version json NULL,
	CONSTRAINT audit_records_pkey PRIMARY KEY (id)
);


-- public.auth_tokens definition

-- Drop table

-- DROP TABLE public.auth_tokens;

CREATE TABLE public.auth_tokens (
	id bigserial NOT NULL,
	access_token varchar NULL,
	refresh_token varchar NULL,
	id_token varchar NULL,
	user_id int4 NULL,
	expires_at int4 NULL,
	uuid uuid NULL DEFAULT uuid_generate_v4(),
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT auth_tokens_pkey PRIMARY KEY (id)
);


-- public.banned_vehicles definition

-- Drop table

-- DROP TABLE public.banned_vehicles;

CREATE TABLE public.banned_vehicles (
	id bigserial NOT NULL,
	right_identifier varchar NULL,
	banned_by_user_name varchar NULL,
	car_park_id int8 NULL,
	reason text NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	uuid uuid NULL DEFAULT uuid_generate_v4(),
	CONSTRAINT banned_vehicles_pkey PRIMARY KEY (id)
);


-- public.building_organisations definition

-- Drop table

-- DROP TABLE public.building_organisations;

CREATE TABLE public.building_organisations (
	id serial4 NOT NULL,
	building_id int4 NULL,
	organisation_uuid varchar NULL,
	organisation_name varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT building_organisations_pkey PRIMARY KEY (id)
);


-- public.buildings definition

-- Drop table

-- DROP TABLE public.buildings;

CREATE TABLE public.buildings (
	id serial4 NOT NULL,
	name varchar NULL,
	address_line_1 varchar NULL,
	address_line_2 varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	time_zone varchar NULL,
	CONSTRAINT buildings_pkey PRIMARY KEY (id)
);


-- public.car_park_gates definition

-- Drop table

-- DROP TABLE public.car_park_gates;

CREATE TABLE public.car_park_gates (
	id serial4 NOT NULL,
	car_park_id int4 NULL,
	name varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	plc_address varchar NULL,
	plc_port int4 NULL,
	uuid uuid NOT NULL DEFAULT uuid_generate_v4(),
	plc_uid int4 NULL,
	disabled bool NULL DEFAULT false,
	CONSTRAINT car_park_gates_pkey PRIMARY KEY (id)
);


-- public.car_park_poses definition

-- Drop table

-- DROP TABLE public.car_park_poses;

CREATE TABLE public.car_park_poses (
	id bigserial NOT NULL,
	car_park_id int4 NULL,
	name varchar NULL,
	pos_uuid varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT car_park_poses_pkey PRIMARY KEY (id)
);


-- public.car_parks definition

-- Drop table

-- DROP TABLE public.car_parks;

CREATE TABLE public.car_parks (
	id serial4 NOT NULL,
	name varchar NULL,
	total_spots int4 NULL DEFAULT 0,
	building_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	minion_uuid varchar NULL,
	passage_requests_ttl int4 NULL DEFAULT 14,
	right_panel_ttl int4 NULL DEFAULT 10,
	down_time_type varchar NULL DEFAULT 'inactive'::character varying,
	free_public_group bool NULL DEFAULT true,
	data_ttl int4 NULL,
	CONSTRAINT car_parks_pkey PRIMARY KEY (id)
);


-- public.group_allocations definition

-- Drop table

-- DROP TABLE public.group_allocations;

CREATE TABLE public.group_allocations (
	id serial4 NOT NULL,
	name varchar NULL,
	description text NULL,
	tenant_allocation_id int4 NULL,
	consumes_parking_spots bool NULL,
	guaranteed bool NULL DEFAULT false,
	spots_allocated int4 NULL DEFAULT 0,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	long_term bool NULL DEFAULT false,
	uuid uuid NULL DEFAULT uuid_generate_v4(),
	default_parking_right_duration_type varchar NULL,
	default_parking_right_duration int4 NULL,
	permit_uuid uuid NULL,
	public_group_setting_id int8 NULL,
	grace_minutes_on_entry int4 NULL DEFAULT 0,
	CONSTRAINT group_allocations_pkey PRIMARY KEY (id)
);


-- public.location_removal_processes definition

-- Drop table

-- DROP TABLE public.location_removal_processes;

CREATE TABLE public.location_removal_processes (
	id bigserial NOT NULL,
	status varchar NULL,
	process_errors jsonb NULL DEFAULT '{}'::jsonb,
	building_id int4 NULL,
	initiator_user_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT location_removal_processes_pkey PRIMARY KEY (id)
);


-- public.notifications definition

-- Drop table

-- DROP TABLE public.notifications;

CREATE TABLE public.notifications (
	id bigserial NOT NULL,
	body text NULL,
	actor_id int4 NULL,
	actor_type varchar NULL,
	kind varchar NULL,
	published_at timestamp NULL,
	depublished_at timestamp NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT notifications_pkey PRIMARY KEY (id)
);


-- public.outbox_messages definition

-- Drop table

-- DROP TABLE public.outbox_messages;

CREATE TABLE public.outbox_messages (
	id bigserial NOT NULL,
	status varchar NOT NULL,
	topic varchar NULL,
	payload text NULL,
	meta_data jsonb NOT NULL DEFAULT '{}'::jsonb,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	publisher_type varchar NULL DEFAULT 'rabbitmq'::character varying,
	CONSTRAINT outbox_messages_pkey PRIMARY KEY (id)
);


-- public.passage_requests definition

-- Drop table

-- DROP TABLE public.passage_requests;

CREATE TABLE public.passage_requests (
	id serial4 NOT NULL,
	car_park_camera_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	right_identifier varchar NULL,
	observed_at timestamp NULL,
	images _varchar NULL DEFAULT '{}'::character varying[],
	status int4 NOT NULL DEFAULT 0,
	country varchar NULL,
	vehicle_direction varchar NULL,
	vehicle_direction_confidence varchar NULL,
	vehicle_direction_angle varchar NULL,
	vehicle_speed_indication varchar NULL,
	confidence varchar NULL,
	characters_confidence text NULL,
	camera_name varchar NULL,
	global_id varchar NULL,
	observed_as varchar NULL,
	metadata jsonb NULL,
	message_type varchar NULL,
	CONSTRAINT passage_requests_pkey PRIMARY KEY (id)
);


-- public.report_subscriptions definition

-- Drop table

-- DROP TABLE public.report_subscriptions;

CREATE TABLE public.report_subscriptions (
	id bigserial NOT NULL,
	user_id int8 NULL,
	building_id int8 NULL,
	organisations_uuids _varchar NULL,
	email varchar NULL,
	spot_allocation bool NULL,
	duration_parking_actions_per_vehicle bool NULL,
	sum_all_parking_actions_per_tenant bool NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT report_subscriptions_pkey PRIMARY KEY (id)
);


-- public.schema_migrations definition

-- Drop table

-- DROP TABLE public.schema_migrations;

CREATE TABLE public.schema_migrations (
	"version" varchar NOT NULL,
	CONSTRAINT schema_migrations_pkey PRIMARY KEY ("version")
);


-- public.spatial_ref_sys definition

-- Drop table

-- DROP TABLE public.spatial_ref_sys;

CREATE TABLE public.spatial_ref_sys (
	srid int4 NOT NULL,
	auth_name varchar(256) NULL,
	auth_srid int4 NULL,
	srtext varchar(2048) NULL,
	proj4text varchar(2048) NULL,
	CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid),
	CONSTRAINT spatial_ref_sys_srid_check CHECK (((srid > 0) AND (srid <= 998999)))
);



-- public.tenants definition

-- Drop table

-- DROP TABLE public.tenants;

CREATE TABLE public.tenants (
	id serial4 NOT NULL,
	name varchar NULL,
	mess_permit_owner_id varchar NULL,
	organisation_uuid varchar NULL,
	building_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	shared bool NULL DEFAULT false,
	phone_number varchar NULL,
	for_reservations bool NULL DEFAULT false,
	CONSTRAINT tenants_pkey PRIMARY KEY (id)
);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id serial4 NOT NULL,
	first_name varchar NULL,
	last_name varchar NULL,
	uuid varchar NULL,
	roles jsonb NULL DEFAULT '{}'::jsonb,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	recent_building_ids text NULL,
	"admin" bool NOT NULL DEFAULT false,
	email varchar NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id)
);


-- public.webhooks definition

-- Drop table

-- DROP TABLE public.webhooks;

CREATE TABLE public.webhooks (
	id bigserial NOT NULL,
	owner_type varchar NULL,
	owner_id int8 NULL,
	description text NULL,
	url varchar NULL,
	"key" varchar NULL,
	metadata jsonb NULL DEFAULT '{}'::jsonb,
	active bool NULL DEFAULT true,
	max_retries int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT webhooks_pkey PRIMARY KEY (id)
);


-- public.activity_logs definition

-- Drop table

-- DROP TABLE public.activity_logs;

CREATE TABLE public.activity_logs (
	id bigserial NOT NULL,
	status int4 NOT NULL,
	group_allocation_id int4 NULL,
	actor_type int4 NOT NULL,
	actor_id int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	mess_parking_right_id int4 NULL,
	right_identifier varchar NULL,
	passage_request_id int4 NULL,
	needs_attention bool NULL DEFAULT false,
	name varchar NULL,
	in_violation_from timestamp NULL,
	event_context jsonb NULL,
	car_park_id int8 NULL,
	general_image varchar NULL,
	plate_image varchar NULL,
	stream_image varchar NULL,
	early_arrival bool NULL DEFAULT false,
	CONSTRAINT activity_logs_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_902fa90e5a FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id)
);


-- public.calling_activities definition

-- Drop table

-- DROP TABLE public.calling_activities;

CREATE TABLE public.calling_activities (
	id bigserial NOT NULL,
	tenant_id int8 NULL,
	passage_request_id int8 NULL,
	status varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	right_identifier varchar NULL,
	CONSTRAINT calling_activities_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_5cbdca75e1 FOREIGN KEY (tenant_id) REFERENCES public.tenants(id)
);


-- public.car_park_cameras definition

-- Drop table

-- DROP TABLE public.car_park_cameras;

CREATE TABLE public.car_park_cameras (
	id bigserial NOT NULL,
	name varchar NULL,
	camera_type varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	car_park_gate_id int8 NULL,
	CONSTRAINT car_park_cameras_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_b0df1a3e73 FOREIGN KEY (car_park_gate_id) REFERENCES public.car_park_gates(id)
);


-- public.car_park_counting_boards definition

-- Drop table

-- DROP TABLE public.car_park_counting_boards;

CREATE TABLE public.car_park_counting_boards (
	id bigserial NOT NULL,
	gate_id int8 NULL,
	allowed_displays_count int4 NULL DEFAULT 8,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT car_park_counting_boards_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_791cacd102 FOREIGN KEY (gate_id) REFERENCES public.car_park_gates(id)
);


-- public.car_park_counting_displays definition

-- Drop table

-- DROP TABLE public.car_park_counting_displays;

CREATE TABLE public.car_park_counting_displays (
	id bigserial NOT NULL,
	show_availability bool NULL DEFAULT false,
	group_allocation_id int8 NULL,
	counting_board_id int8 NULL,
	register int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT car_park_counting_displays_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_e9102fb52d FOREIGN KEY (counting_board_id) REFERENCES public.car_park_counting_boards(id),
	CONSTRAINT fk_rails_f692e570d2 FOREIGN KEY (group_allocation_id) REFERENCES public.group_allocations(id)
);


-- public.car_park_gate_commands definition

-- Drop table

-- DROP TABLE public.car_park_gate_commands;

CREATE TABLE public.car_park_gate_commands (
	id bigserial NOT NULL,
	gate_id int8 NULL,
	"event" varchar NULL DEFAULT 'on_entry'::character varying,
	command_bit int4 NULL,
	description varchar NULL,
	group_allocations_ids _text NULL DEFAULT '{}'::text[],
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT car_park_gate_commands_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_32f075e7e1 FOREIGN KEY (gate_id) REFERENCES public.car_park_gates(id)
);


-- public.car_park_inner_gates definition

-- Drop table

-- DROP TABLE public.car_park_inner_gates;

CREATE TABLE public.car_park_inner_gates (
	id bigserial NOT NULL,
	car_park_id int8 NULL,
	name varchar NULL,
	camera_host varchar NULL,
	status varchar NULL,
	camera_port int4 NULL,
	group_allocations_ids _text NULL DEFAULT '{}'::text[],
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT car_park_inner_gates_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_c992744edb FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id)
);


-- public.car_park_planned_down_times definition

-- Drop table

-- DROP TABLE public.car_park_planned_down_times;

CREATE TABLE public.car_park_planned_down_times (
	id bigserial NOT NULL,
	start_datetime timestamp NULL,
	end_datetime timestamp NULL,
	sunday bool NULL DEFAULT false,
	monday bool NULL DEFAULT false,
	tuesday bool NULL DEFAULT false,
	wednesday bool NULL DEFAULT false,
	thursday bool NULL DEFAULT false,
	friday bool NULL DEFAULT false,
	saturday bool NULL DEFAULT false,
	description text NOT NULL,
	car_park_id int8 NULL,
	extras jsonb NOT NULL DEFAULT '{}'::jsonb,
	recurring bool NULL DEFAULT false,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	creator_id int8 NULL,
	CONSTRAINT car_park_planned_down_times_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_5c0fc8cbe5 FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id),
	CONSTRAINT fk_rails_92c694e05d FOREIGN KEY (creator_id) REFERENCES public.users(id)
);


-- public.exemptions definition

-- Drop table

-- DROP TABLE public.exemptions;

CREATE TABLE public.exemptions (
	id bigserial NOT NULL,
	activity_log_id int8 NULL,
	exempted_by_id int8 NULL,
	reason varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT exemptions_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_28f2d5a74e FOREIGN KEY (exempted_by_id) REFERENCES public.users(id),
	CONSTRAINT fk_rails_2efc20f6f4 FOREIGN KEY (activity_log_id) REFERENCES public.activity_logs(id)
);


-- public.notification_reads definition

-- Drop table

-- DROP TABLE public.notification_reads;

CREATE TABLE public.notification_reads (
	id bigserial NOT NULL,
	user_id int8 NULL,
	notification_id int8 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT notification_reads_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_17fefdab8f FOREIGN KEY (user_id) REFERENCES public.users(id),
	CONSTRAINT fk_rails_47fe63fb51 FOREIGN KEY (notification_id) REFERENCES public.notifications(id)
);


-- public.pedestrians_gates definition

-- Drop table

-- DROP TABLE public.pedestrians_gates;

CREATE TABLE public.pedestrians_gates (
	id bigserial NOT NULL,
	car_park_id int8 NULL,
	name varchar NULL,
	uuid uuid NULL,
	default_relay_number int4 NULL,
	default_open_duration int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT pedestrians_gates_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_444545365c FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id)
);


-- public.present_vehicles definition

-- Drop table

-- DROP TABLE public.present_vehicles;

CREATE TABLE public.present_vehicles (
	id bigserial NOT NULL,
	right_identifier varchar NOT NULL,
	group_allocation_id int8 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	activity_log_id int4 NULL,
	name varchar NULL,
	in_violation_from timestamp NULL,
	CONSTRAINT present_vehicles_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_351878deb3 FOREIGN KEY (group_allocation_id) REFERENCES public.group_allocations(id)
);


-- public.public_group_settings definition

-- Drop table

-- DROP TABLE public.public_group_settings;

CREATE TABLE public.public_group_settings (
	id bigserial NOT NULL,
	mess_area_id varchar NULL,
	area_uuid uuid NULL,
	mess_permit_owner_id varchar NULL,
	owner_uuid varchar NOT NULL,
	car_park_id int8 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	exit_strategy varchar NULL,
	CONSTRAINT public_group_settings_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_7f6724d7fa FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id)
);


-- public.tenant_allocations definition

-- Drop table

-- DROP TABLE public.tenant_allocations;

CREATE TABLE public.tenant_allocations (
	id serial4 NOT NULL,
	tenant_id int4 NULL,
	spots_allocated int4 NULL DEFAULT 0,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	car_park_id int8 NULL,
	mess_area_id varchar NULL,
	area_uuid uuid NULL,
	CONSTRAINT tenant_allocations_pkey PRIMARY KEY (id),
	CONSTRAINT fk_rails_69f87822e9 FOREIGN KEY (car_park_id) REFERENCES public.car_parks(id)
);