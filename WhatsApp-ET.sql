-- Users-related tables

drop table Users
CREATE TABLE Users (
    users_id INT PRIMARY KEY,
    usersname VARCHAR(255),
    phone_number VARCHAR(20),
    registration_date DATE
);
INSERT INTO Users 
VALUES 
       (1, 'Anmol', '0987654321', '2024-04-18'),
       (2, 'Anubhav', '1357902468', '2024-04-18'),
       (3, 'Ayush', '2468013579', '2024-04-18'),
       (4, 'payal', '9876543210', '2024-04-18')
	   select * from Users


CREATE TABLE Users_Profile (
    profile_id INT PRIMARY KEY,
    users_id INT,
    status TEXT,
    profile_picture_url VARCHAR(255),
    last_seen DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Profile (profile_id, users_id, status, profile_picture_url, last_seen) VALUES
(1, 1, 'Active', 'profile1.jpg', '2024-04-18 09:00:00'),
(2, 2, 'Away', 'profile2.jpg', '2024-04-18 10:00:00'),
(3, 3, 'Offline', 'profile3.jpg', '2024-04-18 11:00:00'),
(4, 4, 'Active', 'profile4.jpg', '2024-04-18 12:00:00')

CREATE TABLE Users_Contact (
    contact_id INT PRIMARY KEY,
    users_id INT,
    contact_users_id INT,
    FOREIGN KEY (users_id) REFERENCES Users(users_id),
    FOREIGN KEY (contact_users_id) REFERENCES Users(users_id)
);


INSERT INTO Users_Contact (contact_id, users_id, contact_users_id) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 1),
(4, 3, 4)


-- Chat-related tables
CREATE TABLE Chat (
    chat_id INT PRIMARY KEY,
    chat_name VARCHAR(255),
    is_group_chat varchar(10)
);

INSERT INTO Chat (chat_id, chat_name, is_group_chat) VALUES
(1, 'Random Chat1', 'FALSE'),
(2, 'Random Chat2', 'FALSE'),
(3, 'Group Chat 1', 'TRUE'),
(4, 'Group Chat 2', 'TRUE'),
(5, 'Group Chat 3', 'TRUE');

CREATE TABLE Chat_Member (
    chat_id INT,
    users_id INT,
    is_admin varchar(50),
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

-- Chat_Member table
INSERT INTO Chat_Member (chat_id, users_id, is_admin) VALUES
(3, 1, 'TRUE'),
(3, 2, 'FALSE'),
(3, 3, 'FALSE'),
(4, 3, 'TRUE'),
(4, 4, 'FALSE');


CREATE TABLE Message (
    message_id INT PRIMARY KEY,
    chat_id INT,
    sender_id INT,
    message_text TEXT,
    message_time DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (sender_id) REFERENCES Users(users_id)
);

-- Message table
INSERT INTO Message (message_id, chat_id, sender_id, message_text, message_time) VALUES
(1, 1, 1, 'Hi Mom!', '2024-04-18 09:05:00'),
(2, 1, 2, 'Hi Dad!', '2024-04-18 09:06:00'),
(3, 2, 3, 'Hey Babe!', '2024-04-18 10:10:00'),
(4, 2, 4, 'Hey !', '2024-04-18 10:11:00')

CREATE TABLE Media_Message (
    media_id INT PRIMARY KEY,
    message_id INT,
    media_type VARCHAR(50),
    file_path VARCHAR(255),
    upload_date DATETIME,
    FOREIGN KEY (message_id) REFERENCES Message(message_id)
);

select * from [dbo].[Message]
 --Media_Message table
INSERT INTO Media_Message (media_id, message_id, media_type, file_path, upload_date) VALUES
(1, 1, 'Image', '/path/to/image.jpg', '2024-04-18 09:00:00'),
(2, 2, 'Video', '/path/to/video.mp4', '2024-04-18 10:00:00'),
(3, 3, 'Audio', '/path/to/audio.mp3', '2024-04-18 11:00:00'),
(4, 4, 'Image', '/path/to/image2.jpg', '2024-04-18 12:00:00')

select * from [dbo].[Media_Message]

-- Call-related tables
CREATE TABLE Call_Log (
    call_id INT PRIMARY KEY,
    caller_id INT,
    receiver_id INT,
    call_type VARCHAR(50),
    call_duration INT,
    call_time DATETIME,
    FOREIGN KEY (caller_id) REFERENCES Users(users_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(users_id)
);

-- Call_Log table
INSERT INTO Call_Log (call_id, caller_id, receiver_id, call_type, call_duration, call_time) VALUES
(1, 1, 2, 'Voice', 60, '2024-04-18 09:00:00'),
(2, 2, 3, 'Video', 120, '2024-04-18 10:00:00'),
(3, 3, 4, 'Voice', 180, '2024-04-18 11:00:00'),
(4, 4, 2, 'Voice', 90, '2024-04-18 12:00:00'),
(5, 2, 4, 'Video', 150, '2024-04-18 13:00:00');


CREATE TABLE Call_Rating (
    rating_id INT PRIMARY KEY,
    call_id INT,
    users_id INT,
    rating DECIMAL(2, 1),
    review_text TEXT,
    FOREIGN KEY (call_id) REFERENCES Call_Log(call_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

-- Call_Rating table
INSERT INTO Call_Rating (rating_id, call_id, users_id, rating, review_text) VALUES
(1, 1, 2, 4.5, 'Great call!'),
(2, 2, 3, 3.0, 'Average call.'),
(3, 3, 4, 5.0, 'Excellent call!'),
(4, 4, 1, 2.5, 'Not a good call.'),
(5, 5, 1, 4.0, 'Good call, could be better.');


-- Status-related tables
CREATE TABLE Status (
    status_id INT PRIMARY KEY,
    users_id INT,
    status_text TEXT,
    status_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);


INSERT INTO Status (status_id, users_id, status_text, status_time) VALUES
(1, 1, 'Busy.', '2024-04-18 09:00:00'),
(2, 2, 'Busy with work.', '2024-04-18 10:00:00'),
(3, 3, 'Excited!', '2024-04-18 11:00:00'),
(4, 4, 'Feeling tired.', '2024-04-18 12:00:00'),
(5, 2, 'Looking forward to the movie tonight.', '2024-04-18 16:00:00');

select * from [dbo].[Status]

-- Location-related tables


CREATE TABLE Location_Share (
    location_id INT PRIMARY KEY,
    users_id INT,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    share_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Location_Share (location_id, users_id, latitude, longitude, share_time) VALUES
(1, 1, 37.7749, -122.4194, '2024-04-18 09:00:00'),
(2, 2, 34.0522, -118.2437, '2024-04-18 10:00:00'),
(3, 3, 40.7128, -74.0060, '2024-04-18 11:00:00'),
(4, 4, 51.5074, -0.1278, '2024-04-18 12:00:00'),
(5, 1, 48.8566, 2.3522, '2024-04-18 13:00:00');

CREATE TABLE Live_Location (
    live_location_id INT PRIMARY KEY,
    users_id INT,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    update_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Live_Location (live_location_id, users_id, latitude, longitude, update_time) VALUES
(1, 1, 37.7749, -122.4194, '2024-04-18 09:00:00'),
(2, 2, 34.0522, -118.2437, '2024-04-18 10:00:00'),
(3, 3, 40.7128, -74.0060, '2024-04-18 11:00:00'),
(4, 4, 51.5074, -0.1278, '2024-04-18 12:00:00'),
(5, 1, 48.8566, 2.3522, '2024-04-18 13:00:00');

-- Group-related tables
CREATE TABLE Group_Chat (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(255),
    creation_date DATE
);

INSERT INTO Group_Chat (group_id, group_name, creation_date) VALUES
(1, 'Office', '2024-04-01'),
(2, 'Launde', '2024-04-05'),
(3, 'Ghar', '2024-04-10'),
(4, 'Padhakus', '2024-04-15'),
(5, 'Building', '2024-04-20');


CREATE TABLE Group_Member (
    group_id INT,
    users_id INT,
    is_admin varchar(50),
    FOREIGN KEY (group_id) REFERENCES Group_Chat(group_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

-- Group_Member table
INSERT INTO Group_Member (group_id, users_id, is_admin) VALUES
(1, 1, 'TRUE'),
(1, 2, 'FALSE'),
(1, 3, 'FALSE'),
(2, 2, 'TRUE'),
(2, 3, 'TRUE');


-- Message-related tables
CREATE TABLE Message_Read_Status (
    message_id INT,
    users_id INT,
    read_status varchar(50),
    PRIMARY KEY (message_id, users_id),
    FOREIGN KEY (message_id) REFERENCES Message(message_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Message_Read_Status (message_id, users_id, read_status) VALUES
(1, 1, 'TRUE'),
(1, 2, 'TRUE'),
(2, 1, 'FALSE'),
(2, 3, 'FALSE'),
(3, 2, 'TRUE');



CREATE TABLE Message_Reply (
    reply_id INT PRIMARY KEY,
    message_id INT,
    users_id INT,
    reply_text TEXT,
    reply_time DATETIME,
    FOREIGN KEY (message_id) REFERENCES Message(message_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);


INSERT INTO Message_Reply (reply_id, message_id, users_id, reply_text, reply_time) VALUES
(1, 1, 2, 'Badiya!', '2024-04-18 09:05:00'),
(2, 2, 3, 'Bilkul.', '2024-04-18 10:05:00'),
(3, 3, 4, 'Kya?', '2024-04-18 11:05:00'),
(4, 3, 2, 'Exactly', '2024-04-18 12:05:00'),
(5, 2, 1, 'Okay', '2024-04-18 13:05:00');


-- Additional tables for future expansion
CREATE TABLE Chat_Block_List (
    block_id INT PRIMARY KEY,
    users_id INT,
    blocked_users_id INT,
    block_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id),
    FOREIGN KEY (blocked_users_id) REFERENCES Users(users_id)
);

INSERT INTO Chat_Block_List (block_id, users_id, blocked_users_id, block_time) VALUES
(1, 1, 2, '2024-04-18 09:10:00'),
(2, 2, 3, '2024-04-18 10:10:00'),
(3, 3, 4, '2024-04-18 11:10:00'),
(4, 4, 1, '2024-04-18 12:10:00'),
(5, 2, 1, '2024-04-18 13:10:00');




CREATE TABLE Users_Device (
    device_id INT PRIMARY KEY,
    users_id INT,
    device_name VARCHAR(255),
    device_type VARCHAR(255),
    last_login DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Device (device_id, users_id, device_name, device_type, last_login) VALUES
(1, 1, 'iPhone 15', 'Mobile', '2024-04-18 09:15:00'),
(2, 2, 'Samsung Galaxy S21', 'Mobile', '2024-04-18 10:15:00'),
(3, 3, 'iPad Pro', 'Tablet', '2024-04-18 11:15:00'),
(4, 4, 'Dell XPS 15', 'Laptop', '2024-04-18 12:15:00'),
(5, 1, 'MacBook Air', 'Laptop', '2024-04-18 13:15:00');




CREATE TABLE Users_Status (
    status_id INT PRIMARY KEY,
    users_id INT,
    status_text TEXT,
    status_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Status (status_id, users_id, status_text, status_time) VALUES
(1, 1, 'Feeling great today!', '2024-04-18 09:20:00'),
(2, 2, 'Just finished a project.', '2024-04-18 10:20:00'),
(3, 3, 'Looking forward to the weekend.', '2024-04-18 11:20:00'),
(4, 4, 'Feeling tired after work.', '2024-04-18 12:20:00'),
(5, 1, 'Excited for the upcoming trip.', '2024-04-18 13:20:00');


CREATE TABLE Chat_Message_Status (
    status_id INT PRIMARY KEY,
    message_id INT,
    users_id INT,
    status VARCHAR(50),
    status_time DATETIME,
    FOREIGN KEY (message_id) REFERENCES Message(message_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

select * from [dbo].[Message]

INSERT INTO Chat_Message_Status (status_id, message_id, users_id, status, status_time) VALUES
(1, 1, 2, 'Read', '2024-04-18 09:25:00'),
(2, 2, 3, 'Read', '2024-04-18 10:25:00'),
(3, 3, 4, 'Delivered', '2024-04-18 11:25:00'),
(4, 4, 2, 'Delivered', '2024-04-18 12:25:00')



CREATE TABLE Chat_Invite (
    invite_id INT PRIMARY KEY,
    chat_id INT,
    inviter_id INT,
    invitee_id INT,
    invite_time DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (inviter_id) REFERENCES Users(users_id),
    FOREIGN KEY (invitee_id) REFERENCES Users(users_id)
);
select * from [dbo].[Chat]
INSERT INTO Chat_Invite (invite_id, chat_id, inviter_id, invitee_id, invite_time) VALUES
(1, 1, 1, 2, '2024-04-18 09:30:00'),
(2, 2, 2, 3, '2024-04-18 10:30:00'),
(3, 3, 3, 4, '2024-04-18 11:30:00'),
(4, 4, 4, 1, '2024-04-18 12:30:00'),
(5, 5, 1, 3, '2024-04-18 13:30:00');

CREATE TABLE Group_Event (
    event_id INT PRIMARY KEY,
    group_id INT,
    event_name VARCHAR(255),
    event_date DATE,
    event_time TIME,
    location VARCHAR(255),
    description TEXT,
    FOREIGN KEY (group_id) REFERENCES Group_Chat(group_id)
);

INSERT INTO Group_Event (event_id, group_id, event_name, event_date, event_time, location, description) VALUES
(1, 1, 'Meeting', '2024-04-20', '10:00:00', 'Conference Room A', 'Discuss  updates.'),
(2, 2, 'Party', '2024-04-22', '19:00:00', 'My''s Place', 'Celebrate birthday.'),
(3, 3, 'Study', '2024-04-25', '15:00:00', 'Library', 'Prepare for exams.'),
(4, 4, 'Game Night', '2024-04-28', '18:00:00', 'Community Center', 'Play board games.'),
(5, 5, 'Movie NIght', '2024-04-30', '12:00:00', 'Home', 'Watch movies.');


CREATE TABLE Group_Event_Attendance (
    attendance_id INT PRIMARY KEY,
    event_id INT,
    users_id INT,
    attendance_status VARCHAR(50),
    FOREIGN KEY (event_id) REFERENCES Group_Event(event_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Group_Event_Attendance (attendance_id, event_id, users_id, attendance_status) VALUES
(1, 1, 1, 'Going'),
(2, 1, 2, 'Going'),
(3, 2, 3, 'Going'),
(4, 2, 4, 'Maybe'),
(5, 3, 2, 'Not Going');


CREATE TABLE Message_Poll (
    poll_id INT PRIMARY KEY,
    message_id INT,
    question TEXT,
    FOREIGN KEY (message_id) REFERENCES Message(message_id)
);

select * from [dbo].[Message]

INSERT INTO Message_Poll (poll_id, message_id, question) VALUES
(1, 1, 'Cricket?'),
(2, 2, 'Movie?'),
(3, 4, 'Valorant?'),
(4, 3, 'Which book should we read?');



CREATE TABLE Poll_Option (
    option_id INT PRIMARY KEY,
    poll_id INT,
    option_text TEXT,
    FOREIGN KEY (poll_id) REFERENCES Message_Poll(poll_id)
);


INSERT INTO Poll_Option (option_id, poll_id, option_text) VALUES
(1, 1, 'Yes'),
(2, 1, 'No'),
(3, 1, 'Maybe'),
(4, 2, 'Action'),
(5, 2, 'Comedy'),
(6, 2, 'Drama'),
(7, 3, 'Yes'),
(8, 3, 'No'),
(9, 3, 'Maybe'),
(10, 4, 'Sci-Fi'),
(11, 4, 'Mystery'),
(12, 4, 'Fantasy');



CREATE TABLE Poll_Vote (
    vote_id INT PRIMARY KEY,
    poll_id INT,
    users_id INT,
    option_id INT,
    FOREIGN KEY (poll_id) REFERENCES Message_Poll(poll_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id),
    FOREIGN KEY (option_id) REFERENCES Poll_Option(option_id)
);

INSERT INTO Poll_Vote (vote_id, poll_id, users_id, option_id) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 1, 3, 3),
(4, 2, 3, 4),
(5, 2, 4, 5),
(6, 2, 1, 6),
(7, 3, 1, 7),
(8, 3, 2, 8),
(9, 3, 3, 9),
(10, 4, 2, 10),
(11, 4, 3, 11),
(12, 4, 4, 12);




CREATE TABLE Message_Star (
    star_id INT PRIMARY KEY,
    message_id INT,
    users_id INT,
    star_time DATETIME,
    FOREIGN KEY (message_id) REFERENCES Message(message_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);


INSERT INTO Message_Star (star_id, message_id, users_id, star_time) VALUES
(1, 1, 2, '2024-04-18 09:06:00'),
(2, 2, 1, '2024-04-18 09:07:00'),
(3, 3, 4, '2024-04-18 10:11:00'),
(4, 4, 3, '2024-04-18 10:12:00')


CREATE TABLE Chat_Link (
    link_id INT PRIMARY KEY,
    chat_id INT,
    link_text VARCHAR(255),
    creation_time DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id)
);

-- Chat_Link table
INSERT INTO Chat_Link (link_id, chat_id, link_text, creation_time) VALUES
(1, 1, 'https://example.com', '2024-04-18 09:45:00'),
(2, 2, 'https://example.com', '2024-04-18 10:45:00'),
(3, 3, 'https://example.com', '2024-04-18 11:45:00'),
(4, 4, 'https://example.com', '2024-04-18 12:45:00'),
(5, 5, 'https://example.com', '2024-04-18 13:45:00'); 

CREATE TABLE Users_Activity (
    activity_id INT PRIMARY KEY,
    users_id INT,
    activity_type VARCHAR(255),
    activity_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Activity (activity_id, users_id, activity_type, activity_time) VALUES
(1, 1, 'Logged In', '2024-04-18 09:50:00'),
(2, 2, 'Logged Out', '2024-04-18 10:50:00'),
(3, 3, 'Changed Profile Picture', '2024-04-18 11:50:00'),
(4, 4, 'Posted a Status Update', '2024-04-18 12:50:00'),
(5, 1, 'Sent a Message', '2024-04-18 13:50:00');


CREATE TABLE Message_Reaction (
    reaction_id INT PRIMARY KEY,
    message_id INT,
    users_id INT,
    reaction_type VARCHAR(50),
    reaction_time DATETIME,
    FOREIGN KEY (message_id) REFERENCES Message(message_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Message_Reaction (reaction_id, message_id, users_id, reaction_type, reaction_time) VALUES
(1, 1, 2, 'Like', '2024-04-18 09:55:00'),
(2, 2, 3, 'Love', '2024-04-18 10:55:00'),
(3, 3, 4, 'Haha', '2024-04-18 11:55:00'),
(4, 4, 1, 'Wow', '2024-04-18 12:55:00');



CREATE TABLE Users_Settings (
    setting_id INT PRIMARY KEY,
    users_id INT,
    setting_name VARCHAR(255),
    setting_value VARCHAR(255),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Settings (setting_id, users_id, setting_name, setting_value) VALUES
(1, 1, 'Notification Sound', 'On'),
(2, 2, 'Dark Mode', 'Off'),
(3, 3, 'Language Preference', 'English'),
(4, 4, 'Email Notifications', 'On'),
(5, 3, 'Theme Color', 'Blue');

CREATE TABLE Chat_Pinned_Message (
    pinned_message_id INT PRIMARY KEY,
    chat_id INT,
    message_id INT,
    pinned_time DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (message_id) REFERENCES Message(message_id)
);

INSERT INTO Chat_Pinned_Message (pinned_message_id, chat_id, message_id, pinned_time) VALUES
(1, 1, 1, '2024-04-18 09:00:00'),
(2, 2, 2, '2024-04-18 10:00:00'),
(3, 3, 3, '2024-04-18 11:00:00'),
(4, 4, 4, '2024-04-18 12:00:00');


CREATE TABLE Group_Admin (
    admin_id INT PRIMARY KEY,
    group_id INT,
    users_id INT,
    FOREIGN KEY (group_id) REFERENCES Group_Chat(group_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Group_Admin (admin_id, group_id, users_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 2);

select * from [dbo].[Group_Chat]
select * from [dbo].[Users]
CREATE TABLE Chat_Moderator (
    moderator_id INT PRIMARY KEY,
    chat_id INT,
    users_id INT,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);


INSERT INTO Chat_Moderator (moderator_id, chat_id, users_id) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 5, 1);

CREATE TABLE Chat_Ban (
    ban_id INT PRIMARY KEY,
    chat_id INT,
    users_id INT,
    ban_start DATETIME,
    ban_end DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Chat_Ban (ban_id, chat_id, users_id, ban_start, ban_end) VALUES
(1, 1, 2, '2024-04-18 09:00:00', '2024-04-18 10:00:00'),
(2, 2, 3, '2024-04-18 10:00:00', '2024-04-18 11:00:00'),
(3, 3, 4, '2024-04-18 11:00:00', '2024-04-18 12:00:00'),
(4, 5, 1, '2024-04-18 13:00:00', '2024-04-18 14:00:00');


CREATE TABLE Users_Note (
    note_id INT PRIMARY KEY,
    users_id INT,
    note_text TEXT,
    note_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Note (note_id, users_id, note_text, note_time) VALUES
(1, 1, 'Remember to buy groceries.', '2024-04-18 09:00:00'),
(2, 2, 'Meeting with clients at 3 PM.', '2024-04-18 10:00:00'),
(3, 3, 'Submit report by Noon.', '2024-04-18 11:00:00'),
(4, 4, 'Call mom for her birthday.', '2024-04-18 12:00:00');



CREATE TABLE Users_Block_List (
    block_id INT PRIMARY KEY,
    users_id INT,
    blocked_user_id INT,
    block_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id),
    FOREIGN KEY (blocked_user_id) REFERENCES Users(users_id)
);

INSERT INTO Users_Block_List (block_id, users_id, blocked_user_id, block_time) VALUES
(1, 1, 2, '2024-04-18 09:00:00'),
(2, 2, 3, '2024-04-18 10:00:00'),
(3, 3, 4, '2024-04-18 11:00:00'),
(4, 4, 2, '2024-04-18 12:00:00');

CREATE TABLE Message_Favorite (
    favorite_id INT PRIMARY KEY,
    users_id INT,
    message_id INT,
    favorite_time DATETIME,
    FOREIGN KEY (users_id) REFERENCES Users(users_id),
    FOREIGN KEY (message_id) REFERENCES Message(message_id)
);

INSERT INTO Message_Favorite (favorite_id, users_id, message_id, favorite_time) VALUES
(1, 1, 1, '2024-04-18 09:00:00'),
(2, 2, 2, '2024-04-18 10:00:00'),
(3, 3, 3, '2024-04-18 11:00:00'),
(4, 4, 4, '2024-04-18 12:00:00');

CREATE TABLE Chat_Mute (
    mute_id INT PRIMARY KEY,
    chat_id INT,
    users_id INT,
    mute_start DATETIME,
    mute_end DATETIME,
    FOREIGN KEY (chat_id) REFERENCES Chat(chat_id),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);

INSERT INTO Chat_Mute (mute_id, chat_id, users_id, mute_start, mute_end) VALUES
(1, 1, 2, '2024-04-18 09:00:00', '2024-04-18 10:00:00'),
(2, 2, 3, '2024-04-18 10:00:00', '2024-04-18 11:00:00'),
(3, 3, 4, '2024-04-18 11:00:00', '2024-04-18 12:00:00'),
(4, 4, 1, '2024-04-18 12:00:00', '2024-04-18 13:00:00');

CREATE TABLE User_Access_Log (
    log_id INT PRIMARY KEY,
    users_id INT,
    access_time DATETIME,
    access_type VARCHAR(50),
    FOREIGN KEY (users_id) REFERENCES Users(users_id)
);


INSERT INTO User_Access_Log (log_id, users_id, access_time, access_type) VALUES
(1, 1, '2024-04-18 09:00:00', 'login'),
(2, 2, '2024-04-18 10:00:00', 'login'),
(3, 3, '2024-04-18 11:00:00', 'login'),
(4, 4, '2024-04-18 12:00:00', 'login');




SELECT 
    u1.username AS blocking_user,
    u2.username AS blocked_user,
    ubl.block_time
FROM 
    Users_Block_List ubl
INNER JOIN 
    Users u1 ON ubl.users_id = u1.users_id
INNER JOIN 
    Users u2 ON ubl.blocked_user_id = u2.users_id;


--- Query 1: Find all users who have blocked other users.

   SELECT u1.usersname AS blocking_user, u2.usersname AS blocked_user
   FROM Users_Block_List ubl
   INNER JOIN Users u1 ON ubl.users_id = u1.users_id
   INNER JOIN Users u2 ON ubl.blocked_user_id = u2.users_id;

 --- Query 2: Find all users who have been invited to a chat and the inviter's username.

   SELECT ci.invitee_id, u.usersname AS invitee_usersname, ci.inviter_id, u2.usersname AS inviter_usersname
   FROM Chat_Invite ci
   INNER JOIN Users u ON ci.invitee_id = u.users_id
   INNER JOIN Users u2 ON ci.inviter_id = u2.users_id;

  --- Query 3: Count the number of messages sent by each user.

   SELECT sender_id, COUNT(*) AS message_count
   FROM Message
   GROUP BY sender_id;

 --- Query 4: Find users who have blocked more than one user.

   SELECT users_id, COUNT(blocked_user_id) AS blocked_count
   FROM Users_Block_List
   GROUP BY users_id
   HAVING COUNT(blocked_user_id) > 1;

 --- Query 5: Find users who have favorited their own messages using a subquery.

   SELECT users_id, message_id
   FROM Message_Favorite
   WHERE users_id IN (SELECT message_id FROM Message_Favorite);

   --- Query 6: Rank users based on the number of messages they've sent.

SELECT u.users_id, u.usersname, m.message_count,
       RANK() OVER (ORDER BY m.message_count DESC) AS message_rank
FROM (
    SELECT sender_id AS users_id, COUNT(*) AS message_count
    FROM Message
    GROUP BY sender_id
) AS m
JOIN Users u ON m.users_id = u.users_id;

  --- Query 7: Find all users whose usernames start with 'A'.

   SELECT *
   FROM Users
   WHERE LEFT(usersname, 1) = 'A';

  --*User Blocking Analysis*: Find users who have been blocked the most and users who have blocked the most.

   SELECT ubl.blocked_users_id, COUNT(ubl.users_id) AS blocked_count
   FROM Users_Block_List ubl
   GROUP BY ubl.blocked_users_id
   ORDER BY blocked_count DESC



   LIMIT 1;

   SELECT ubl.user_id, COUNT(ubl.blocked_user_id) AS blocking_count
   FROM User_Block_List ubl
   GROUP BY ubl.user_id
   ORDER BY blocking_count DESC
   LIMIT 1;


--*Top Active Users*: Find the top 10 users who have sent the most messages.
   sql
SELECT TOP 10 u.usersname, COUNT(m.message_id) AS message_count
FROM Users u
INNER JOIN Message m ON u.users_id = m.sender_id
GROUP BY u.usersname
ORDER BY message_count DESC;

--*Average Message Length*: Calculate the average length of messages sent by each user.

SELECT u.usersname, AVG(LEN(m.message_text,)) AS avg_message_length
FROM Users u
INNER JOIN Message m ON u.users_id = m.sender_id
GROUP BY u.usersname;


--Call Rating Analysis*: Calculate the average call rating given by users and identify users with the highest and lowest average ratings.
SELECT TOP 1 users_id, AVG(rating) AS avg_rating
FROM Call_Rating
GROUP BY users_id
ORDER BY avg_rating DESC;

--Find out which user_id has the Lowest Avergae Call Rating
SELECT top 1 users_id, AVG(rating) AS avg_rating
   FROM Call_Rating
   GROUP BY users_id
   ORDER BY avg_rating ASC

--Most Popular Chat*: Find the chat with the highest number of messages.

SELECT TOP 1 c.chat_name, COUNT(m.message_id) AS message_count
FROM Chat c
INNER JOIN Message m ON c.chat_id = m.chat_id
GROUP BY c.chat_name
ORDER BY message_count DESC;

--Insert Data
INSERT INTO Users VALUES 
(5, 'Neha', 123456789, '2024-04-18')
select * from Users


--2. Update Data
UPDATE Users
SET usersname = 'Sameer' 
WHERE users_id = 5
select * from Users

--3. Retrieve Data
SELECT * from Users
WHERE users_id <3

--4. Delete Data

DELETE FROM Users
WHERE users_id = 5
Select * from Users
