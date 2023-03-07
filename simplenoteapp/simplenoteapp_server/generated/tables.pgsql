--
-- Class Note as table note
--

CREATE TABLE "note" (
  "id" serial,
  "data" text NOT NULL
);

ALTER TABLE ONLY "note"
  ADD CONSTRAINT note_pkey PRIMARY KEY (id);


