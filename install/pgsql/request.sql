CREATE TABLE request (
	request_id serial NOT NULL,
	create_date timestamp NOT NULL,
	last_exec timestamp,
	title character varying NOT NULL,
	body character varying NOT NULL,
	login character varying NOT NULL,
	datefields character varying,
	CONSTRAINT request_pk PRIMARY KEY (request_id)

);
-- ddl-end --
COMMENT ON TABLE request IS E'Request table in database';
-- ddl-end --
COMMENT ON COLUMN request.create_date IS E'Date of create of the request';
-- ddl-end --
COMMENT ON COLUMN request.last_exec IS E'Date of the last execution';
-- ddl-end --
COMMENT ON COLUMN request.title IS E'Title of the request';
-- ddl-end --
COMMENT ON COLUMN request.body IS E'Body of the request. Don''t begin it by SELECT, which will be added automatically';
-- ddl-end --
COMMENT ON COLUMN request.login IS E'Login of the creator of the request';
-- ddl-end --
COMMENT ON COLUMN request.datefields IS E'List of the date fields used in the request, separated by a comma, for format it';
-- ddl-end --
ALTER TABLE request OWNER TO metabo;
