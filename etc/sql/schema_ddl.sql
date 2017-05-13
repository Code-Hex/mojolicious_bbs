CREATE TABLE "thread" (
  "id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "category" character varying(255) NOT NULL,
  "created_at" timestamp NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "category_idx" on "thread" ("category");

--
-- Table: writer
--
CREATE TABLE "writer" (
  "id" serial NOT NULL,
  "thread_id" integer NOT NULL,
  "name" character varying(255) NOT NULL,
  "email" character varying(40) NOT NULL,
  "created_at" timestamp NOT NULL,
  PRIMARY KEY ("thread_id")
);
CREATE INDEX "thread_id_idx" on "writer" ("thread_id");

--
-- Table: message
--
CREATE TABLE "message" (
  "id" serial NOT NULL,
  "writer_id" integer NOT NULL,
  "text" text NOT NULL,
  "abone" smallint DEFAULT 0 NOT NULL,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp NOT NULL,
  PRIMARY KEY ("writer_id")
);
CREATE INDEX "message_id_idx" on "message" ("id");

--
-- Foreign Key Definitions
--

ALTER TABLE "thread" ADD FOREIGN KEY ("id")
  REFERENCES "writer" ("thread_id") DEFERRABLE;

ALTER TABLE "writer" ADD FOREIGN KEY ("thread_id")
  REFERENCES "thread" ("id") DEFERRABLE;

ALTER TABLE "writer" ADD FOREIGN KEY ("id")
  REFERENCES "message" ("writer_id") DEFERRABLE;

ALTER TABLE "message" ADD FOREIGN KEY ("writer_id")
  REFERENCES "writer" ("id") DEFERRABLE;

