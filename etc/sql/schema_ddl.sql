CREATE TABLE "thread" (
  "id" serial NOT NULL,
  "name" character varying(255) NOT NULL,
  "category" character varying(255) NOT NULL,
  "created_at" timestamp DEFAULT 'now()' NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "category_idx" on "thread" ("category");

--
-- Table: writer
--
CREATE TABLE "writer" (
  "thread_id" integer NOT NULL,
  "id" character varying(25) NOT NULL,
  "name" character varying(255) NOT NULL,
  "email" character varying(40) NOT NULL,
  "message" text NOT NULL,
  "abone" smallint DEFAULT 0 NOT NULL,
  "created_at" timestamp DEFAULT 'now()' NOT NULL,
  PRIMARY KEY ("thread_id")
);
CREATE INDEX "thread_id_idx" on "writer" ("thread_id");

--
-- Foreign Key Definitions
--

ALTER TABLE "thread" ADD FOREIGN KEY ("id")
  REFERENCES "writer" ("thread_id") DEFERRABLE;

ALTER TABLE "writer" ADD FOREIGN KEY ("thread_id")
  REFERENCES "thread" ("id") DEFERRABLE;

