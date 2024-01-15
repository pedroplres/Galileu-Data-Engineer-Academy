CREATE DATABASE PP1_G3_DW;


USE PP1_G3_DW;


CREATE TABLE dim_album (
    album_id INT NOT NULL,
    album_title NVARCHAR(100) NOT NULL,
    release_date DATE NOT NULL,
    band_id INT NOT NULL,
    label_id INT NOT NULL,
    genre_id INT NOT NULL
);

CREATE TABLE dim_country (
    country_code CHAR(2) NOT NULL,
    country_name NVARCHAR(50) NOT NULL
);

CREATE TABLE dim_band (
    band_id INT NOT NULL,
    band_name NVARCHAR(50) NOT NULL,
    country_code CHAR(2) NOT NULL,
    genre_id INT NOT NULL
);

CREATE TABLE dim_genre (
    genre_id INT NOT NULL,
    genre_name NVARCHAR(50) NOT NULL
);

CREATE TABLE dim_label (
    label_id INT NOT NULL,
    label_name NVARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL
);

CREATE TABLE dim_session (
    session_id INT NOT NULL,
    timestamp_id INT NOT NULL,
    user_id INT NOT NULL,
    country_code CHAR(2) NOT NULL,
    album_track_id INT NOT NULL
);

CREATE TABLE dim_user (
    user_id INT NOT NULL,
    username NVARCHAR(50) NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) NOT NULL,
    phone NVARCHAR(16) CHECK (phone NOT LIKE '%[^0-9]%'),
    password VARCHAR(25) NOT NULL,
    country_code CHAR(2) NOT NULL
);

CREATE TABLE dim_user_timestamp (
    timestamp_id INT NOT NULL,
    timestamp_login DATETIME2 NOT NULL,
    timestamp_logout DATETIME2 NOT NULL,
    user_id INT NOT NULL
);

CREATE TABLE fact_album_track (
    album_track_id INT NOT NULL,
    album_id INT NOT NULL,
    track_number TINYINT NOT NULL,
    track_title NVARCHAR(100) NOT NULL,
    duration_track TIME(0) NOT NULL,
    genre_id INT NOT NULL,
    label_id INT NOT NULL
);

CREATE TABLE fact_user_track (
    user_track_id INT NOT NULL,
    user_id INT NOT NULL,
    album_track_id INT NOT NULL,
    listen_datetime DATETIME2 NOT NULL
);

CREATE TABLE log (
    messege password NVARCHAR(MAX) NOT NULL,
    insertdate DATETIME NOT NULL
);