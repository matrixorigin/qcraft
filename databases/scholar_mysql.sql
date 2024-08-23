
CREATE TABLE author (
    authorid BIGINT NOT NULL,
    authorname TEXT
);


CREATE TABLE cite (
    citingpaperid BIGINT NOT NULL,
    citedpaperid BIGINT NOT NULL
);


CREATE TABLE dataset (
    datasetid BIGINT NOT NULL,
    datasetname TEXT
);


CREATE TABLE field (
    fieldid BIGINT
);


CREATE TABLE journal (
    journalid BIGINT NOT NULL,
    journalname TEXT
);


CREATE TABLE keyphrase (
    keyphraseid BIGINT NOT NULL,
    keyphrasename TEXT
);


CREATE TABLE paper (
    paperid BIGINT NOT NULL,
    title TEXT,
    venueid BIGINT,
    year BIGINT,
    numciting BIGINT,
    numcitedby BIGINT,
    journalid BIGINT
);


CREATE TABLE paperdataset (
    paperid BIGINT,
    datasetid BIGINT
);


CREATE TABLE paperfield (
    fieldid BIGINT,
    paperid BIGINT
);


CREATE TABLE paperkeyphrase (
    paperid BIGINT,
    keyphraseid BIGINT
);


CREATE TABLE venue (
    venueid BIGINT NOT NULL,
    venuename TEXT
);


CREATE TABLE writes (
    paperid BIGINT,
    authorid BIGINT
);


INSERT INTO author (authorid, authorname) VALUES
(1, 'John Smith'),
(2, 'Emily Johnson'),
(3, 'Michael Brown'),
(4, 'Sarah Davis'),
(5, 'David Wilson'),
(6, 'Jennifer Lee'),
(7, 'Robert Moore'),
(8, 'Linda Taylor'),
(9, 'William Anderson'),
(10, 'Karen Martinez')
;

INSERT INTO cite (citingpaperid, citedpaperid) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1),
(3, 5),
(4, 2),
(1, 4),
(3, 1)
;

INSERT INTO dataset (datasetid, datasetname) VALUES
(1, 'COVID-19 Research'),
(2, 'Machine Learning Datasets'),
(3, 'Climate Change Data'),
(4, 'Social Media Analysis')
;

INSERT INTO field (fieldid) VALUES
(1),
(2),
(3),
(4)
;

INSERT INTO journal (journalid, journalname) VALUES
(1, 'Nature'),
(2, 'Science'),
(3, 'IEEE Transactions on Pattern Analysis and Machine Intelligence'),
(4, 'International Journal of Mental Health')
;

INSERT INTO keyphrase (keyphraseid, keyphrasename) VALUES
(1, 'Machine Learning'),
(2, 'Climate Change'),
(3, 'Social Media'),
(4, 'COVID-19'),
(5, 'Mental Health')
;

INSERT INTO paper (paperid, title, venueid, year, numciting, numcitedby, journalid) VALUES
(1, 'A Study on Machine Learning Algorithms', 1, 2020, 2, 2, 3),
(2, 'The Effects of Climate Change on Agriculture', 1, 2020, 1, 2, 1),
(3, 'Social Media and Mental Health', 2, 2019, 3, 1, 4),
(4, 'COVID-19 Impact on Society', 1, 2020, 2, 2, 2),
(5, 'Machine Learning in Tackling Climate Change', 2, 2019, 1, 2, 3)
;

INSERT INTO paperdataset (paperid, datasetid) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1),
(5, 2),
(5, 3)
;

INSERT INTO paperfield (fieldid, paperid) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 5)
;

INSERT INTO paperkeyphrase (paperid, keyphraseid) VALUES
(1, 1),
(2, 2),
(3, 3),
(3, 5),
(4, 4),
(5, 1),
(5, 2)
;

INSERT INTO venue (venueid, venuename) VALUES
(1, 'Conference on Machine Learning'),
(2, 'International Journal of Climate Change'),
(3, 'Social Media Analysis Workshop')
;

INSERT INTO writes (paperid, authorid) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 3),
(1, 4),
(2, 3),
(4, 5),
(5, 1),
(2, 1),
(4, 3),
(4, 6),
(2, 7),
(2, 8),
(2, 9)
;



