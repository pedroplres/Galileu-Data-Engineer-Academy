CREATE DATABASE PP1_G3;


USE PP1_G3;


-- CREATE SCHEMA
CREATE SCHEMA session;

CREATE SCHEMA music;

CREATE SCHEMA [User];

CREATE SCHEMA country;

-- CREATE TABLES
CREATE TABLE [Session].[session]
  (
     session_id    INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     timestamp_id  INT NOT NULL,
     user_id       INT NOT NULL,
     country_code  CHAR(2) NOT NULL,
     albumtrack_id INT NOT NULL
  );

CREATE TABLE [Music].[band]
  (
     band_id       INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     band_name     NVARCHAR (50),
     country_code  CHAR(2) NOT NULL,
     genre_id      INT NOT NULL,
     [description] NVARCHAR (1000) NULL
  );

CREATE TABLE [Music].[albumtrack]
  (
     album_track_id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     album_id       INT NOT NULL,
     track_number   TINYINT NOT NULL,
     track_title    NVARCHAR (100),
     duration_track TIME(0) NOT NULL,
     genre_id       INT NOT NULL,
     label_id       INT NOT NULL,
     session_id     INT 
  );


CREATE TABLE [Music].[album]
  (
     album_id       INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     album_title    NVARCHAR (100) NOT NULL,
     [release_date] DATE NOT NULL,
     band_id        INT NOT NULL,
     label_id       INT NOT NULL,
     genre_id       INT NOT NULL,
     album_track_id INT 
  );


CREATE TABLE [Music].[genre]
  (
     genre_id       INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     genre_name     NVARCHAR (50) NOT NULL,
     [description]  NVARCHAR (1000),
     album_track_id INT,
     album_id       INT
  );

CREATE TABLE [Music].[label]
  (
     [label_id]     INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
     [label_name]   NVARCHAR (100) NOT NULL,
     country_code   CHAR(2) NOT NULL,
     album_track_id INT 
  );


CREATE TABLE [User].[user]
  (
     user_id      INT IDENTITY(1, 1) PRIMARY KEY,
     username     NVARCHAR(50) NOT NULL,
     first_name   NVARCHAR(50) NOT NULL,
     last_name    NVARCHAR(50) NOT NULL,
     email        NVARCHAR(50) NOT NULL,
     phone        NVARCHAR(16) CHECK (phone NOT LIKE '%[^0-9]%'),
     password     VARCHAR(8) NOT NULL,
     country_code CHAR(2) NOT NULL,
     session_id   INT,
     timestamp_id INT
  );


CREATE TABLE [User].[useralbum]
  (
     user_id  INT
          FOREIGN KEY (user_id) REFERENCES [User].[user] (user_id),
          album_id INT
     FOREIGN KEY(album_id) REFERENCES [Music].[album] (album_id)
  );

CREATE TABLE [User].[usertrack]
  (
     usertrack_id    INT IDENTITY (1, 1) PRIMARY KEY,
     user_id         INT
          FOREIGN KEY (user_id) REFERENCES [User].[user] (user_id),
          album_track_id  INT
          FOREIGN KEY (album_track_id) REFERENCES [Music].[albumtrack] (
          album_track_id),
     listen_datetime DATETIME2
  );

CREATE TABLE [User].[usertimestamp]
  (
     timestamp_id     INT IDENTITY(1, 1) PRIMARY KEY,
     timestamp_login  DATETIME2,
     timestamp_logout DATETIME2,
     user_id          INT
     FOREIGN KEY (user_id) REFERENCES [User].[user] (user_id)
  );

CREATE TABLE [Country].[country]
  (
     country_code CHAR(2) NOT NULL PRIMARY KEY,
     country_name NVARCHAR(50) NOT NULL,
     session_id   INT,
     band_id      INT,
     [user_id]    INT
  );

CREATE TABLE [User].[usercountry]
  (
     user_id      INT
          FOREIGN KEY (user_id) REFERENCES [User].[user] (user_id),
          country_code CHAR(2)
     FOREIGN KEY (country_code) REFERENCES [Country].[country] (country_code)
  );

-- FOREIGN KEYS
ALTER TABLE [Country].[country]
  ADD CONSTRAINT fk_session_id FOREIGN KEY (session_id) REFERENCES
  [Session].[session] (session_id);

ALTER TABLE [Country].[country]
  ADD CONSTRAINT fk_band_id FOREIGN KEY (band_id) REFERENCES [Music].[band] (
  band_id);

ALTER TABLE [Country].[country]
  ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES [User].[user] (
  user_id);

ALTER TABLE [Music].[album]
  ADD CONSTRAINT fk_band_id FOREIGN KEY (band_id) REFERENCES [Music].[band] (
  band_id);

ALTER TABLE [Music].[album]
  ADD FOREIGN KEY (album_track_id) REFERENCES [Music].[albumtrack] (
  album_track_id);

ALTER TABLE [Music].[album]
  ADD FOREIGN KEY (label_id) REFERENCES [Music].[label] (label_id);

ALTER TABLE [Music].[album]
  ADD FOREIGN KEY (genre_id) REFERENCES [Music].[genre] (genre_id);

ALTER TABLE [Music].[albumtrack]
  ADD CONSTRAINT fk_album_id FOREIGN KEY (album_id) REFERENCES [Music].[album] (
  album_id);

ALTER TABLE [Music].[albumtrack]
  ADD FOREIGN KEY (genre_id) REFERENCES [Music].[genre] (genre_id);

ALTER TABLE [Music].[albumtrack]
  ADD CONSTRAINT fk_label_id FOREIGN KEY (label_id) REFERENCES [Music].[label] (
  label_id);

ALTER TABLE [Music].[albumtrack]
  ADD FOREIGN KEY (session_id) REFERENCES [Session].[session] (session_id);

ALTER TABLE [Music].[band]
  ADD CONSTRAINT fk_country_code FOREIGN KEY (country_code) REFERENCES
  [Country].[country] (country_code);

ALTER TABLE [Music].[band]
  ADD FOREIGN KEY (genre_id) REFERENCES [Music].[genre] (genre_id);

ALTER TABLE [Music].[genre]
  ADD FOREIGN KEY (album_track_id) REFERENCES [Music].[albumtrack] (
  album_track_id);

ALTER TABLE [Music].[genre]
  ADD FOREIGN KEY (album_id) REFERENCES [Music].[album] (album_id);

ALTER TABLE [Music].[label]
  ADD FOREIGN KEY (album_track_id) REFERENCES [Music].[albumtrack] (
  album_track_id);

ALTER TABLE [Music].[label]
  ADD FOREIGN KEY (country_code) REFERENCES [Country].[country] (country_code);

ALTER TABLE [Session].[session]
  ADD CONSTRAINT fk_timestamp_id FOREIGN KEY (timestamp_id) REFERENCES
  [User].[usertimestamp] (timestamp_id);

ALTER TABLE [Session].[session]
  ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES [User].[user] (
  user_id);

ALTER TABLE [Session].[session]
  ADD CONSTRAINT fk_country_code FOREIGN KEY (country_code) REFERENCES
  [Country].[country] (country_code);

ALTER TABLE [Session].[session]
  ADD FOREIGN KEY (albumtrack_id) REFERENCES [Music].[albumtrack] (
  album_track_id);

ALTER TABLE [User].[user]
  ADD CONSTRAINT fk_country_code FOREIGN KEY (country_code) REFERENCES
  [Country].[country] (country_code);

ALTER TABLE [User].[user]
  ADD CONSTRAINT fk_session_id FOREIGN KEY (session_id) REFERENCES
  [Session].[session] (session_id);

ALTER TABLE [User].[user]
  ADD FOREIGN KEY (timestamp_id) REFERENCES [User].[usertimestamp] (timestamp_id
  ); 